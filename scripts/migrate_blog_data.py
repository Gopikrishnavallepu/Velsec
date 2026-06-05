import os
import shutil
import re
from datetime import datetime

SOURCE_DIR = r"d:\Velsec\Blog-Data"
DEST_DIR = r"d:\Velsec\velsec-org\notes-vault"

# Mapping source root folders to Target Main Category and Target Subfolder
CATEGORY_MAP = {
    "Cloud_Security": ("Security Engineer", "Security_Engineer\\Cloud_Security"),
    "DevSecOps": ("Security Engineer", "Security_Engineer\\DevSecOps"),
    "SOC": ("Security Engineer", "Security_Engineer\\SOC"),
    "Data_Analytics": ("Data Analyst", "Data_Analyst\\Data_Analytics"),
    "Interview_Preparation": ("Career Development", "Career_Development\\Interview_Preparation"),
    "resume": ("Career Development", "Career_Development\\Resume")
}

def inject_frontmatter(content, title, category, tags):
    # Check if frontmatter already exists
    if content.startswith("---"):
        return content
    
    date_str = datetime.now().strftime("%Y-%m-%d")
    tag_str = ", ".join([f'"{t}"' for t in tags])
    
    frontmatter = f"""---
title: "{title}"
category: "{category}"
tags: [{tag_str}]
lastUpdated: "{date_str}"
---

"""
    return frontmatter + content

def migrate_files():
    if not os.path.exists(SOURCE_DIR):
        print(f"[ERROR] Source directory {SOURCE_DIR} not found.")
        return

    moved_count = 0
    
    for root, _, files in os.walk(SOURCE_DIR):
        # Skip PDF export folders
        if "PDF_Exports" in root:
            continue
            
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                
                # Determine relative path from Blog-Data
                rel_path = os.path.relpath(root, SOURCE_DIR)
                first_folder = rel_path.split(os.sep)[0] if rel_path != "." else ""
                
                # Determine destination mapping
                if first_folder in CATEGORY_MAP:
                    main_cat, sub_path = CATEGORY_MAP[first_folder]
                else:
                    main_cat = "General"
                    sub_path = "Velsec_Blog_Root"
                
                target_dir = os.path.join(DEST_DIR, sub_path)
                os.makedirs(target_dir, exist_ok=True)
                
                target_file_path = os.path.join(target_dir, file)
                
                # Read content
                try:
                    with open(file_path, "r", encoding="utf-8") as f:
                        content = f.read()
                except Exception as e:
                    print(f"Failed to read {file_path}: {e}")
                    continue
                
                # Inject frontmatter if missing
                title = os.path.splitext(file)[0].replace("_", " ").replace("-", " ").title()
                tags = [first_folder] if first_folder else ["General"]
                new_content = inject_frontmatter(content, title, main_cat, tags)
                
                # Write to new location
                try:
                    with open(target_file_path, "w", encoding="utf-8") as f:
                        f.write(new_content)
                    # Remove original file (MOVE)
                    os.remove(file_path)
                    moved_count += 1
                    print(f"[MOVED] {file} -> {sub_path}")
                except Exception as e:
                    print(f"Failed to move {file_path}: {e}")
                    
    print(f"\nMigration Complete. Total files moved: {moved_count}")

if __name__ == "__main__":
    migrate_files()
