---

# 🚀 Azure VM Scale Set Autoscaling LAB (Step-by-Step)

## 📌 Objective

This lab demonstrates how to:

* Create an Azure VM Scale Set (VMSS)
* Enable autoscaling based on CPU usage
* Simulate load and observe automatic scaling

---

## 🧠 Real-World Use Case

Autoscaling helps applications handle traffic dynamically:

* 📈 High traffic → Scale Out (add VMs)
* 📉 Low traffic → Scale In (remove VMs)

Example: Amazon sale vs normal days

---

## 🛠️ Prerequisites

* Azure Free Trial Account
* Basic knowledge of:

  * Virtual Machines
  * Linux commands
  * Azure Portal

---

## ⚙️ Step 1: Enable Autoscaling Service (IMPORTANT)

Autoscaling requires **Microsoft.Insights** provider.

Steps:

1. Go to **Azure Portal**
2. Search → **Subscriptions**
3. Select your subscription
4. Click → **Resource Providers**
5. Search → `Microsoft.Insights`
6. Click → **Register**

✅ Wait until status = **Registered**

---

## 🖥️ Step 2: Create VM Scale Set

1. Search → **Virtual Machine Scale Set**
2. Click → **Create**

---

## 📋 Step 3: Basics Configuration

* Resource Group → `rg-vmss-demo`
* VMSS Name → `vmss-demo`
* Region → `Central India`
* Image → `Ubuntu Server 22.04 LTS`

### 💡 VM Size (Important for Free Trial)

* Select → `Standard_B1s`

---

## 🔐 Step 4: Authentication

* Username → `azureuser`
* Password → Create your password

---

## 📊 Step 5: Enable Autoscaling

Select:
✅ **Autoscaling**

---

## 📉 Step 5.1: Instance Limits (Free Trial Safe)

* Minimum → `1`
* Default → `1`
* Maximum → `2`

💡 Reason:
Azure free trial allows limited vCPU, so we restrict scaling.

---

## 📈 Step 6: Configure Scaling Rules

### 🔹 Rule 1: Scale OUT

* Metric → Percentage CPU
* Condition → Greater than `60%`
* Duration → `3 minutes`
* Action → Increase count by `1`

---

### 🔹 Rule 2: Scale IN

* Metric → Percentage CPU
* Condition → Less than `30%`
* Duration → `3 minutes`
* Action → Decrease count by `1`

---

## 🚀 Step 7: Create VMSS

* Click → **Review + Create**
* Click → **Create**

⏳ Wait for deployment (~3–5 minutes)

---

## 🔓 Step 8: Allow SSH Access

1. Go to VMSS
2. Click → **Networking**
3. Click → **Add inbound port rule**

Set:

* Port → `22`
* Protocol → `TCP`
* Action → `Allow`

---

## 🖥️ Step 9: Verify Initial Instance

Go to:
**VMSS → Instances**

✅ You should see:

* 1 running VM

---

## 🔗 Step 10: Connect to VM

1. Click VM instance
2. Click → **Connect → SSH**
3. Copy and run command in terminal

---

## 📊 Step 11: Check CPU Usage

Run:

```bash
top
```

💡 CPU will be low (~1–5%)

Press:

```
Ctrl + C
```

---

## 🔥 Step 12: Generate CPU Load

### ✅ Method 1 (Recommended)

```bash
sudo apt update
sudo apt install stress -y
stress --cpu 1 --timeout 600
```

### ⚡ Method 2 (Quick)

```bash
yes > /dev/null &
yes > /dev/null &
```

💡 Each command increases CPU usage

---

## 📊 Step 13: Monitor CPU

Run again:

```bash
top
```

✅ Expected:

* CPU usage → 80%–100%

---

## ⏳ Step 14: Wait for Autoscaling

Azure evaluates metrics periodically.

⏱ Wait: **5–10 minutes**

---

## 📈 Step 15: Verify Scale-Out

Go to:
**VMSS → Instances**

✅ Result:

* VM count increases from `1 → 2`

---

## 🛑 Step 16: Stop Load

```bash
pkill yes
```

OR wait for stress command to complete

---

## 📉 Step 17: Observe Scale-In

After a few minutes:

✅ VM count decreases from `2 → 1`

💡 Azure waits to avoid unnecessary scaling due to temporary spikes.

---

## 🧩 Architecture Overview

```
User Load → VMSS → CPU Metrics → Autoscale Rules
                     ↓
              Azure Monitor (Microsoft.Insights)
                     ↓
        Scale Out / Scale In Automatically
```

---

## 🎯 Key Learning Outcomes

* VM Scale Set creation
* Autoscaling configuration
* CPU-based scaling rules
* Real-time load simulation
* Monitoring and validation

---

## 🏁 Conclusion

This lab demonstrates how Azure automatically manages infrastructure based on demand, which is a critical concept in **DevOps and Cloud Engineering**.

---

## 📌 Tags

`Azure` `VMSS` `Autoscaling` `DevOps` `Cloud` `Azure Monitor` `Infrastructure as Code (Concept)`

---
