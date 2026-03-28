#  Azure VM Scale Set Autoscaling LAB (Step-by-Step)

##  Objective
Create an Azure VM Scale Set (VMSS), enable autoscaling, generate CPU load, and observe automatic scaling.

---

##  Real-World Use Case
- High traffic → Scale Out (add VMs)
- Low traffic → Scale In (remove VMs)

Example: Amazon sale vs normal days

---

##  Prerequisites
- Azure Free Trial Account
- Basic knowledge of Azure & Linux

---

##  Step 1: Enable Autoscaling Service

Autoscaling requires Microsoft.Insights provider.

1. Go to Azure Portal  
2. Search → Subscriptions  
3. Select your subscription  
4. Click → Resource Providers  
5. Search → Microsoft.Insights  
6. Click → Register  

✅ Wait until status = Registered

---

## 🖥️ Step 2: Create VM Scale Set

1. Search → Virtual Machine Scale Set  
2. Click → Create  

---

## 📋 Step 3: Basics Configuration

- Resource Group → rg-vmss-demo  
- VMSS Name → vmss-demo  
- Region → Central India  
- Image → Ubuntu Server 22.04 LTS  

### VM Size (Free Trial Safe)
- Standard_B1s  

---

## 🔐 Step 4: Authentication

- Username → azureuser  
- Password → your password  

---

##  Step 5: Enable Autoscaling

Select: Autoscaling  

---

## 📉 Step 5.1: Instance Limits

- Minimum → 1  
- Default → 1  
- Maximum → 2  

---

## 📈 Step 6: Configure Scaling Rules

### Scale OUT Rule
- Metric → CPU Percentage  
- Condition → Greater than 60%  
- Duration → 3 minutes  
- Action → Increase count by 1  

### Scale IN Rule
- Metric → CPU Percentage  
- Condition → Less than 30%  
- Duration → 3 minutes  
- Action → Decrease count by 1  

---

##  Step 7: Create VMSS

Click → Review + Create → Create  

⏳ Wait 3–5 minutes  

---

## 🔓 Step 8: Allow SSH Access

1. Go to VMSS  
2. Click → Networking  
3. Add inbound rule  

- Port → 22  
- Protocol → TCP  
- Action → Allow  

---

## 🖥️ Step 9: Verify Instance

Go to VMSS → Instances  

✅ You will see 1 VM  

---

## 🔗 Step 10: Connect via SSH

1. Click VM instance  
2. Click → Connect → SSH  
3. Run command in terminal  

---

##  Step 11: Check CPU Usage

```bash
top
```

CPU will be low (~1–5%)

Press Ctrl + C

---

##  Step 12: Generate CPU Load

### Method 1 (Recommended)
```bash
sudo apt update
sudo apt install stress -y
stress --cpu 1 --timeout 600
```

### Method 2 (Quick)
```bash
yes > /dev/null &
yes > /dev/null &
```

---

##  Step 13: Monitor CPU

```bash
top
```

Expected CPU → 80%–100%

---

## ⏳ Step 14: Wait for Autoscaling

Wait 5–10 minutes  

---

## 📈 Step 15: Verify Scale-Out

Go to VMSS → Instances  

✅ VM count: 1 → 2  

---

## 🛑 Step 16: Stop Load

```bash
pkill yes
```

OR wait for stress command  

---

## 📉 Step 17: Observe Scale-In

After a few minutes:  

✅ VM count: 2 → 1  

---

##  Architecture

User Load → VMSS → CPU Metrics → Autoscale Rules → Scale In/Out  

---

##  Key Learnings

- VM Scale Set creation  
- Autoscaling configuration  
- CPU-based scaling  
- Load testing  
- Monitoring  

---

## 🏁 Conclusion

Azure VMSS autoscaling automatically adjusts infrastructure based on demand, which is essential in DevOps and Cloud Engineering.

---

## 📌 Tags

Azure, VMSS, Autoscaling, DevOps, Cloud, Azure Monitor
