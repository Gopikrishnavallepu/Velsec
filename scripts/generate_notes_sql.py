#!/usr/bin/env python3
"""
Generates batched SQL files from the notes-vault markdown files.
Produces multiple smaller SQL files to avoid the Supabase Management API size limit.
Then executes each batch via: npx supabase db query --linked -f <file>
"""
import os
import re
import sys
import subprocess

BATCH_SIZE = 10  # notes per SQL file


def parse_markdown_file(file_path):
    """Parse a markdown file with YAML frontmatter into a note dict."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return None

    match = re.match(r'^---\s*\n(.*?)\n---\s*\n(.*)$', content, re.DOTALL)
    if not match:
        print(f"[WARN] File {file_path} does not contain valid frontmatter. Skipping.")
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

    return {
        "id": note_id,
        "title": metadata.get("title", "Untitled Note"),
        "category": metadata.get("category", "General"),
        "tags": metadata.get("tags", []),
        "content": body.strip(),
        "last_updated": metadata.get("lastUpdated", "2026-06-03")
    }


def scan_notes_vault(vault_dir):
    """Walk the vault directory and parse all .md files."""
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


def dollar_quote(s, tag="VELSEC"):
    """Dollar-quote a string for safe PostgreSQL insertion."""
    while f"${tag}$" in s:
        tag += "X"
    return f"${tag}${s}${tag}$"


def escape_single_quotes(s):
    """Escape single quotes for SQL."""
    return s.replace("'", "''")


def generate_batch_sql(notes_batch, output_path, batch_num):
    """Generate a SQL file for a batch of notes."""
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(f"-- Batch {batch_num}: {len(notes_batch)} notes\n")
        f.write("BEGIN;\n\n")

        for note in notes_batch:
            note_id = dollar_quote(note['id'])
            title = dollar_quote(note['title'])
            category = dollar_quote(note['category'])
            content = dollar_quote(note['content'])
            last_updated = note.get('last_updated', '2026-06-03')

            tags = note.get('tags', [])
            if isinstance(tags, list) and len(tags) > 0:
                tag_items = ", ".join(f"'{escape_single_quotes(t)}'" for t in tags)
                tags_sql = f"ARRAY[{tag_items}]::TEXT[]"
            else:
                tags_sql = "ARRAY[]::TEXT[]"

            f.write(f"INSERT INTO public.notes (id, title, category, tags, content, last_updated)\n")
            f.write(f"VALUES ({note_id}, {title}, {category}, {tags_sql}, {content}, '{last_updated}')\n")
            f.write(f"ON CONFLICT (id) DO UPDATE SET\n")
            f.write(f"  title = EXCLUDED.title,\n")
            f.write(f"  category = EXCLUDED.category,\n")
            f.write(f"  tags = EXCLUDED.tags,\n")
            f.write(f"  content = EXCLUDED.content,\n")
            f.write(f"  last_updated = EXCLUDED.last_updated;\n\n")

        f.write("COMMIT;\n")


def run_sql_file(file_path, workdir):
    """Execute a SQL file against the linked Supabase database."""
    result = subprocess.run(
        ["npx.cmd", "supabase", "db", "query", "--linked", "-f", file_path],
        cwd=workdir,
        capture_output=True,
        text=True,
        timeout=60
    )
    return result.returncode, result.stdout, result.stderr


if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.realpath(__file__))
    vault_dir = os.path.realpath(os.path.join(script_dir, "..", "notes-vault"))
    project_root = os.path.realpath(os.path.join(script_dir, ".."))
    batch_dir = os.path.join(script_dir, "sql_batches")

    # Create batch directory
    os.makedirs(batch_dir, exist_ok=True)

    notes = scan_notes_vault(vault_dir)
    if not notes:
        print("[ERROR] No notes found.")
        sys.exit(1)

    print(f"[INFO] Found {len(notes)} notes. Splitting into batches of {BATCH_SIZE}...")

    # Generate batch SQL files
    batch_files = []
    for i in range(0, len(notes), BATCH_SIZE):
        batch_num = (i // BATCH_SIZE) + 1
        batch = notes[i:i + BATCH_SIZE]
        batch_file = os.path.join(batch_dir, f"batch_{batch_num:03d}.sql")
        generate_batch_sql(batch, batch_file, batch_num)
        batch_files.append(batch_file)
        print(f"  [OK] Generated batch {batch_num}: {len(batch)} notes -> {batch_file}")

    print(f"\n[INFO] Generated {len(batch_files)} batch files. Executing against linked Supabase DB...")

    # Execute each batch
    success_count = 0
    fail_count = 0
    for batch_file in batch_files:
        batch_name = os.path.basename(batch_file)
        print(f"  [RUN] Executing {batch_name}...", end=" ", flush=True)
        try:
            ret_code, stdout, stderr = run_sql_file(batch_file, project_root)
            if ret_code == 0:
                print("[OK]")
                success_count += 1
            else:
                print(f"[FAIL] (exit code {ret_code})")
                # Print error details
                err_output = stderr or stdout
                if err_output:
                    for line in err_output.strip().split('\n'):
                        if 'WARN' not in line and 'Initialising' not in line:
                            print(f"    ERROR: {line}")
                fail_count += 1
        except subprocess.TimeoutExpired:
            print("[FAIL] TIMEOUT")
            fail_count += 1

    print(f"\n[RESULT] {success_count} batches succeeded, {fail_count} failed out of {len(batch_files)} total.")
    if fail_count == 0:
        print(f"[SUCCESS] All {len(notes)} notes synced to Supabase!")
    else:
        print("[WARNING] Some batches failed. Check errors above.")
        sys.exit(1)
