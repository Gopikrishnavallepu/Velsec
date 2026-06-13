Setting up Obsidian Git on Android takes a few specific steps because Android doesn't have Git built-in natively. You will have to use a **GitHub Personal Access Token** instead of a normal password. 

> [!WARNING]
> Because your `Velsec` repository contains an entire Next.js website, it is very large. The Obsidian Git plugin on Android uses a JavaScript version of Git that has severe memory limits. **It might crash your phone's Obsidian app while trying to download the entire repository.** 
> If it crashes, read the "Android Alternative" section at the bottom.

Here is the exact step-by-step process for Android:

### Step 1: Create your GitHub Password (Token)
Since Android can't use SSH keys or browser logins for this plugin, you need a special token.
1. On your phone's browser (or computer), go to your GitHub **Settings > Developer settings > Personal access tokens > Tokens (classic)**.
2. Click **Generate new token (classic)**.
3. Name it "Obsidian Android" and check the **`repo`** checkbox.
4. Generate the token and **copy it to your clipboard**. You won't be able to see it again!

### Step 2: Prepare Obsidian on Android
1. Open the Obsidian app on your Android phone.
2. Select **Create new vault**. Give it a temporary name like "TempVault" and create it.
3. Open the menu, go to **Settings (⚙️) > Community plugins**, turn off Safe Mode, and install the **Obsidian Git** plugin.
4. **Enable** the plugin.

### Step 3: Configure and Clone
1. Still inside the Settings menu, scroll down the left sidebar to **Obsidian Git**.
2. Scroll to the **Authentication/Commit Author** section.
3. Enter your GitHub username: `Gopikrishnavallepu`
4. Paste the **Personal Access Token** you copied in Step 1 into the Password field.
5. Exit the Settings menu. 
6. Swipe down on the screen to open the **Command Palette**.
7. Search for and tap: `Obsidian Git: Clone an existing remote repo`.
8. When asked for the repository URL, paste exactly: `https://github.com/Gopikrishnavallepu/Velsec.git`
9. Follow the prompts. 

**Do not close the app while it clones.** Once it finishes, a popup will tell you to restart Obsidian. Fully close the Android app (swipe it away from your recent apps) and reopen it. You can now tap **Open folder as vault** and select the `Velsec/notes-vault` folder to see all your notes!

---

### 🚨 What to do if the Android App crashes during Step 3
If Obsidian crashes or freezes forever while trying to clone the URL, your `Velsec` website repository is too large for Obsidian's memory limits. 

If this happens, the official Obsidian Git developers recommend using a free Android app called **GitSync** (available on the Google Play Store). 
1. Download **GitSync** on your Android.
2. Use it to clone your `Velsec` repository to a folder on your phone (it uses real Git, so it won't crash).
3. Open Obsidian, tap **Open folder as vault**, and select the `notes-vault` folder that GitSync downloaded.
4. From then on, you use the GitSync app to push/pull your notes instead of the Obsidian plugin.