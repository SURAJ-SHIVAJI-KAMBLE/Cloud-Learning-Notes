### 📹 Video Upload & Integration Guide (Backblaze + Moodle)

---

## 🔹 Step 1: Upload Video to Backblaze

1. Login to Backblaze B2 account
2. Go to **Buckets**
3. Open bucket: `moodle-secure-videos`
4. Click **Upload File**
5. Select your video (example: `03-routing-basics.mp4`)
6. Wait for upload to complete

✅ Make sure:

* File name has **no spaces** (use `-` instead)
* Example: `03-routing-basics.mp4`

---

## 🔹 Step 2: No Need to Copy Any Backblaze Link

❌ Do NOT use:

* Friendly URL
* S3 URL
* Native URL

✅ System is already connected via PHP (`get-video.php`)

---

## 🔹 Step 3: Open Moodle

1. Login to Moodle
2. Go to your **Course**
3. Turn **Edit mode ON**
4. Open or Add a **Page/Activity**
5. Click on **Text Editor**

---

## 🔹 Step 4: Open Source Code

1. Click on **“</>” (Source code)** button in editor

---

## 🔹 Step 5: Paste Video Code

Use this format:

```html
<video controls controlsList="nodownload" width="100%">
  <source 
    src="https://sncyberacademy.com/get-video.php?video=03-routing-basics.mp4"
    type="video/mp4">
</video>
```

---

## 🔹 Step 6: Update File Name

👉 Replace only this part:

```
03-routing-basics.mp4
```

with your uploaded file name

Examples:

* `01-Intro.mp4`
* `02-Network-device.mp4`
* `04-switching.mp4`

---

## 🔹 Step 7: Save & Test

1. Click **Save and display**
2. Play video
3. Ensure it loads properly

---

## 🔐 Important Notes

* Bucket is **private** 🔒
* Videos are accessed via **secure PHP link**
* Link auto-expires after time
* Do NOT share direct Backblaze links

---

## ✅ Summary

* Upload video to Backblaze
* Copy only **file name**
* Paste in Moodle code
* Done 🎉

---

## 💡 Example

If uploaded file is:

```
05-firewall-basics.mp4
```

Then use:

```html
<source src="https://sncyberacademy.com/get-video.php?video=05-firewall-basics.mp4">
```

---
