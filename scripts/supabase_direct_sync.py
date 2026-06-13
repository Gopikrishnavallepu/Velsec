#!/usr/bin/env python3
import os
import re
import json
import urllib.request
import urllib.error

# Config
SUPABASE_URL = "https://ubfkvjzuqvgqrfkunmqx.supabase.co"
SUPABASE_KEY = "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS"

def parse_markdown_file(file_path, vault_dir):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return None

    match = re.match(r'^---\s*\n(.*?)\n---\s*\n(.*)$', content, re.DOTALL)
    if not match:
        return None

    frontmatter_str = match.group(1)
    body = match.group(2)

    metadata = {}
    for line in frontmatter_str.split('\n'):
        if not line.strip() or ':' not in line:
            continue
        key, val = line.split(':', 1)
        key = key.strip()
        val = val.strip()

        if val.startswith('"') and val.endswith('"'):
            val = val[1:-1]
        elif val.startswith("'") and val.endswith("'"):
            val = val[1:-1]
        elif val.startswith('[') and val.endswith(']'):
            items = val[1:-1].split(',')
            val = [i.strip().strip('"').strip("'") for i in items if i.strip()]

        metadata[key] = val

    note_id = os.path.splitext(os.path.basename(file_path))[0]

    # Calculate folder path relative to vault
    rel_path = os.path.relpath(file_path, vault_dir)
    folder_path = os.path.dirname(rel_path).replace('\\', '/')
    category = folder_path if folder_path and folder_path != "." else metadata.get("category", "General")

    return {
        "id": note_id,
        "title": metadata.get("title", "Untitled Note"),
        "category": category,
        "tags": metadata.get("tags", []),
        "content": body.strip(),
        "last_updated": metadata.get("lastUpdated", "2026-06-03")
    }

def scan_notes_vault(vault_dir):
    notes = []
    seen_ids = set()
    for root, _, files in os.walk(vault_dir):
        for file in files:
            if file.endswith('.md'):
                file_path = os.path.join(root, file)
                parsed = parse_markdown_file(file_path, vault_dir)
                if parsed:
                    note_id = parsed['id']
                    if note_id in seen_ids:
                        print(f"[WARN] Duplicate note ID found: {note_id} at {file_path}. Skipping.")
                        continue
                    seen_ids.add(note_id)
                    notes.append(parsed)
    return notes

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.realpath(__file__))
    vault_dir = os.path.realpath(os.path.join(script_dir, "..", "notes-vault"))
    notes = scan_notes_vault(vault_dir)
    print(f"[INFO] Parsed {len(notes)} notes.")

    # Call Supabase REST API directly
    url = f"{SUPABASE_URL}/rest/v1/notes"
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "resolution=merge-duplicates"
    }

    req_body = json.dumps(notes).encode('utf-8')
    req = urllib.request.Request(url, data=req_body, headers=headers, method="POST")

    try:
        with urllib.request.urlopen(req) as response:
            res_body = response.read().decode('utf-8')
            print(f"[SUCCESS] Upserted notes to Supabase directly. Status: {response.status}")
    except urllib.error.HTTPError as e:
        print(f"[ERROR] HTTP request failed with code {e.code}: {e.read().decode('utf-8')}")
    except urllib.error.URLError as e:
        print(f"[ERROR] Connection failed: {e.reason}")
