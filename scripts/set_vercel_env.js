const { execSync } = require('child_process');

const envVars = {
  "SUPABASE_URL": "https://ubfkvjzuqvgqrfkunmqx.supabase.co",
  "SUPABASE_KEY": "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS",
  "SUPABASE_JWT_SECRET": "00accb65-6cc0-4f86-90fe-f5909777e46e",
  "SYNC_API_KEY": "Velsec-Super-Secret-Sync-Key-212313",
  "NEXT_PUBLIC_SUPABASE_URL": "https://ubfkvjzuqvgqrfkunmqx.supabase.co",
  "NEXT_PUBLIC_SUPABASE_ANON_KEY": "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS",
  "NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY": "sb_publishable_s9T2KOiy1hsPcOVrISGCfw_Q8jyvHbS",
};

const environments = ["production", "development"];

console.log("[INFO] Setting Vercel environment variables using Node.js execSync (piped)...");

for (const [name, value] of Object.entries(envVars)) {
  for (const env of environments) {
    console.log(`Setting ${name} for ${env}...`);
    try {
      const output = execSync(`vercel.cmd env add ${name} ${env} --value "${value}" --force --yes`);
      console.log(`[OK] Finished setting ${name} for ${env}`);
      console.log(output.toString());
    } catch (err) {
      console.error(`[FAIL] Failed setting ${name} for ${env}: ${err.message}`);
      if (err.stdout) console.log(err.stdout.toString());
      if (err.stderr) console.error(err.stderr.toString());
    }
  }
}

console.log("[RESULT] Done setting all environment variables.");
