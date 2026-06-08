#!/usr/bin/env python3
"""
Sets required Vercel environment variables for the velsec-org project.
Uses os.system to avoid subprocess pipe-hanging issues on Windows.
"""
import os
import sys

# Environment variables to set on Vercel
ENV_VARS = {
    "SUPABASE_URL": "https://ubfkvjzuqvgqrfkunmqx.supabase.co",
    "SUPABASE_KEY": "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS",
    "SUPABASE_JWT_SECRET": "00accb65-6cc0-4f86-90fe-f5909777e46e",
    "SYNC_API_KEY": "Velsec-Super-Secret-Sync-Key-212313",
    "NEXT_PUBLIC_SUPABASE_URL": "https://ubfkvjzuqvgqrfkunmqx.supabase.co",
    "NEXT_PUBLIC_SUPABASE_ANON_KEY": "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS",
    "NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY": "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS",
}

ENVIRONMENTS = ["production", "development"]

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.realpath(__file__))
    project_root = os.path.realpath(os.path.join(script_dir, ".."))
    os.chdir(project_root)

    print("[INFO] Setting Vercel environment variables...")
    print(f"[INFO] Working directory: {os.getcwd()}")
    print()

    success = 0
    failed = 0
    for name, value in ENV_VARS.items():
        for env in ENVIRONMENTS:
            print(f"Setting {name} for {env}...", flush=True)
            cmd = f'vercel.cmd env add {name} {env} --value "{value}" --force --yes'
            ret = os.system(cmd)
            if ret == 0:
                print(f"  [OK]")
                success += 1
            else:
                print(f"  [FAIL] (exit status {ret})")
                failed += 1

    print(f"\n[RESULT] {success} set, {failed} failed")
    if failed > 0:
        sys.exit(1)
