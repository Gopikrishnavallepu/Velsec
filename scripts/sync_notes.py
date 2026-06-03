#!/usr/bin/env python3
import os
import re
import json
import urllib.request
import urllib.error

def parse_markdown_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return None

    # Match frontmatter block
    match = re.match(r'^---\s*\n(.*?)\n---\s*\n(.*)$', content, re.DOTALL)
    if not match:
        print(f"[WARN] File {file_path} does not contain valid frontmatter structure. Skipping.")
        return None

    frontmatter_str = match.group(1)
    body = match.group(2)

    # Parse simple YAML key-value pairs
    metadata = {}
    for line in frontmatter_str.split('\n'):
        if not line.strip() or ':' not in line:
            continue
        key, val = line.split(':', 1)
        key = key.strip()
        val = val.strip()

        # Handle simple quotes
        if val.startswith('"') and val.endswith('"'):
            val = val[1:-1]
        elif val.startswith("'") and val.endswith("'"):
            val = val[1:-1]
        elif val.startswith('[') and val.endswith(']'):
            # Parse simple string array e.g., ["Tag1", "Tag2"]
            items = val[1:-1].split(',')
            val = [i.strip().strip('"').strip("'") for i in items if i.strip()]

        metadata[key] = val

    # Generate note ID from filename (slug)
    note_id = os.path.splitext(os.path.basename(file_path))[0]

    return {
        "id": note_id,
        "title": metadata.get("title", "Untitled Note"),
        "category": metadata.get("category", "General"),
        "tags": metadata.get("tags", []),
        "content": body.strip(),
        "last_updated": metadata.get("lastUpdated", "2026-06-03")
    }

def scan_notes_vault(vault_dir):
    notes = []
    print(f"[INFO] Scanning vault directory: {vault_dir}")
    if not os.path.exists(vault_dir):
        print(f"[ERROR] Directory does not exist: {vault_dir}")
        return notes

    for root, _, files in os.walk(vault_dir):
        for file in files:
            if file.endswith('.md'):
                file_path = os.path.join(root, file)
                parsed = parse_markdown_file(file_path)
                if parsed:
                    notes.append(parsed)
    return notes

def sync_notes_to_api(notes):
    api_base = os.environ.get("VELSEC_API_URL", "http://localhost:8000")
    sync_url = f"{api_base}/api/v1/notes/sync"
    sync_key = os.environ.get("SYNC_API_KEY", "default-sync-key")

    print(f"[INFO] Syncing {len(notes)} notes to {sync_url}...")
    
    headers = {
        "Content-Type": "application/json",
        "X-Sync-Key": sync_key
    }
    
    req_body = json.dumps(notes).encode('utf-8')
    req = urllib.request.Request(sync_url, data=req_body, headers=headers, method="POST")

    try:
        with urllib.request.urlopen(req) as response:
            res_body = response.read().decode('utf-8')
            print(f"[SUCCESS] Sync completed. API Response: {res_body}")
            return True
    except urllib.error.HTTPError as e:
        print(f"[ERROR] HTTP Sync failed with code {e.code}: {e.read().decode('utf-8')}")
        return False
    except urllib.error.URLError as e:
        print(f"[ERROR] Sync failed. Could not connect to API: {e.reason}")
        return False

if __name__ == "__main__":
    # Determine directory paths relative to scripts folder
    script_dir = os.path.dirname(os.path.realpath(__file__))
    vault_dir = os.path.realpath(os.path.join(script_dir, "..", "notes-vault"))
    
    notes = scan_notes_vault(vault_dir)
    if notes:
        sync_notes_to_api(notes)
    else:
        print("[INFO] No notes found to synchronize.")
