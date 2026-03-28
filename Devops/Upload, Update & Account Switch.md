---

````md
# 🚀 GitHub Practical: Upload, Update & Account Switch

## 🎯 Objective
In this practical, we will:
- Create a local project
- Add a README.md file
- Upload it to GitHub
- Make changes and push again
- Switch GitHub account

---

## 🧪 Step 1: Create Project Folder

```bash
cd Desktop
mkdir test1
cd test1
````

---

## 📝 Step 2: Create README.md File

```bash
touch README.md
```

Add below content inside file:

```md
# My DevOps Project

## Introduction
This is my first GitHub practical.

## Steps
- Created local repo
- Added README file
```

---

## 🔧 Step 3: Initialize Git

```bash
git init
```

---

## 👤 Step 4: Configure Git User

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@gmail.com"
```

Check config:

```bash
git config --global user.name
git config --global user.email
```

---

## ➕ Step 5: Add & Commit

```bash
git add .
git commit -m "Initial commit with README"
```

---

## 🌐 Step 6: Connect to GitHub

Create a new repository on GitHub, then run:

```bash
git remote add origin https://github.com/your-username/test1.git
git remote -v
```

---

## 🚀 Step 7: Push to GitHub

```bash
git branch -M main
git push -u origin main
```

---

## ✏️ Step 8: Update README.md

Edit README.md and add:

```md
## Update
- Added new section after first push
```

---

## 🔁 Step 9: Push Changes Again

```bash
git add .
git commit -m "Updated README"
git push origin main
```

---

## 🔐 Step 10: Switch GitHub Account

### Remove Old Credentials

```bash
git credential-manager clear
```

Or manually:

* Open Credential Manager (Windows)
* Remove GitHub credentials

---

### Add New Account

```bash
git config --global user.name "New Name"
git config --global user.email "new-email@gmail.com"
```

---

### Push Again (Login with New Account)

```bash
git push origin main
```

Use:

* Username: New GitHub username
* Password: Personal Access Token (PAT)

---

## 🧠 Summary

```bash
git init
git add .
git commit -m "message"
git remote add origin <repo-url>
git push -u origin main

# For updates
git add .
git commit -m "update"
git push origin main
```

---

## ⚡ Outcome

* Learned Git basics
* Uploaded project to GitHub
* Updated files
* Switched GitHub account

---

```
