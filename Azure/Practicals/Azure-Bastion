## Azure Bastion – Secure VM Connection

### Objective

Use Azure Bastion to securely connect to a Virtual Machine through the Azure Portal without exposing the VM to the public internet.

---

## What is Azure Bastion?

Azure Bastion is a managed service that provides **secure RDP and SSH connectivity to virtual machines directly from the Azure Portal**.

Benefits:

* No public IP required for VM
* Secure connection over HTTPS (port 443)
* Protection against port scanning and attacks
* No need to open RDP (3389) or SSH (22) ports

---

## Architecture

User Browser
↓
Azure Portal
↓
Azure Bastion
↓
Virtual Network
↓
Virtual Machine

---

## Prerequisites

Before creating Azure Bastion ensure:

* Virtual Network exists
* Virtual Machine is deployed
* Subnet named **AzureBastionSubnet** is available
* VM is in the same VNet

---

# Step-by-Step Implementation

## Step 1 – Create Virtual Network

1. Go to Azure Portal
2. Search **Virtual Network**
3. Click **Create**
4. Configure:

* Address Space: `10.0.0.0/16`

Create subnets:

* **VMSubnet**
* **AzureBastionSubnet** (Required name)

Example:

```
VMSubnet: 10.0.1.0/24
AzureBastionSubnet: 10.0.2.0/27
```

---

## Step 2 – Create Virtual Machine

1. Go to **Virtual Machines**
2. Click **Create**
3. Configure:

* Image: Windows Server / Ubuntu
* Size: Standard B1s
* Virtual Network: select created VNet
* Subnet: VMSubnet

For security:

* Disable Public IP (optional but recommended)

Click **Create**.

---

## Step 3 – Create Azure Bastion

1. Go to **Azure Portal**
2. Search **Bastion**
3. Click **Create**

Configure:

* Resource Group
* Region
* Virtual Network
* Subnet: **AzureBastionSubnet**

Public IP:

Create a new public IP for Bastion.

Click **Review + Create**.

Deployment may take **5–10 minutes**.

---

## Step 4 – Connect to VM using Bastion

1. Go to **Virtual Machine**
2. Click **Connect**
3. Select **Bastion**

Enter credentials:

```
Username
Password
```

Click **Connect**.

The VM will open inside the **browser window**.

---

## Result

You can now securely access the virtual machine **without exposing RDP or SSH ports to the internet**.

Traffic flow:

```
User Browser
↓
Azure Portal
↓
Azure Bastion
↓
Virtual Network
↓
Virtual Machine
```

---

## Advantages of Azure Bastion

* Secure browser-based connection
* No public IP needed for VMs
* Reduced attack surface
* Managed platform service
* Supports both RDP and SSH

---

## Author

Suraj Shivaji Kamble
Cloud Learning Project
