---

# 🔥 Step-by-Step: Upload Local Project to GitHub (Using Git Bash)

## ✅ Step 1: Install & Open Git Bash

* Install Git from: [https://git-scm.com/](https://git-scm.com/)
* Right click inside your project folder → **"Git Bash Here"**

---

## ✅ Step 2: Initialize Git Repository

```bash
git init
```

👉 This creates a hidden `.git` folder (means Git tracking started)

---

## ✅ Step 3: Check Status

```bash
git status
```

👉 Shows files not yet tracked (red color)

---

## ✅ Step 4: Add Files to Staging

```bash
git add .
```

👉 Adds all files
(You can also add specific file: `git add filename`)

---

## ✅ Step 5: Commit Your Code

```bash
git commit -m "Initial commit"
```

👉 Saves your code snapshot

---

## ✅ Step 6: Create Repository on GitHub

Go to 👉 GitHub

* Click **New Repository**
* Give name (e.g., `azure-labs`)
* Click **Create Repository**

⚠️ Don’t add README (we already have local files)

---

## ✅ Step 7: Connect Local Repo to GitHub

Copy your repo URL from GitHub

Example:

```
https://github.com/your-username/azure-labs.git
```

Now run:

```bash
git remote add origin https://github.com/your-username/azure-labs.git
```

---

## ✅ Step 8: Push Code to GitHub

```bash
git branch -M main
git push -u origin main
```

👉 First time it may ask:

* Username
* Password → Use **Personal Access Token (PAT)** (not GitHub password)

---

## 🔐 If Authentication Error Comes

Use GitHub token:

1. Go to GitHub → Settings → Developer Settings → Tokens
2. Generate new token
3. Use that as password

---

## 🔄 Future Updates (Very Important)

After making changes:

```bash
git add .
git commit -m "updated project"
git push
```

---

# ⚡ Pro Tips (DevOps Style 💡)

* Always write meaningful commit messages
* Use branches later:

```bash
git checkout -b feature-branch
```

* Check logs:

```bash
git log
```

---

# 🧠 Simple Flow to Remember

👉 `init → add → commit → remote → push`

---
