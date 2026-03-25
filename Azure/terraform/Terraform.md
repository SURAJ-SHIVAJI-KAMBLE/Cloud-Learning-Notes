---

# 🚀 Terraform Practical Lab

### Create an Azure Resource Group using Terraform & VS Code

---

## 📌 Step 1 – Introduction to Terraform

Terraform is an **Infrastructure as Code (IaC)** tool developed by HashiCorp.

It allows you to create and manage cloud infrastructure using code instead of manually configuring resources in a portal.

### 🌐 Supported Cloud Platforms

* Microsoft Azure
* Amazon Web Services (AWS)
* Google Cloud Platform (GCP)

### ⚙️ Resources Terraform Can Create

* Virtual Machines
* Storage Accounts
* Networks
* Resource Groups
* Databases

---

## 📌 Step 2 – Understanding Azure Resource Structure

Azure follows a hierarchical structure:

```
Azure Subscription
        ↓
Resource Group
        ↓
Resources (VM, Storage, Network)
```

### 📦 Example

```
Subscription
   ↓
Resource Group (Example-RG)
   ↓
VM / Storage / Network
```

👉 A **Resource Group** acts like a folder that contains related resources.

---

## 📌 Step 3 – Prerequisites

Install the following tools before starting:

| Tool               | Purpose                     |
| ------------------ | --------------------------- |
| Visual Studio Code | Code Editor                 |
| Terraform          | Infrastructure as Code Tool |
| Azure CLI          | Azure Authentication        |

---

## 📌 Step 4 – Install Visual Studio Code

1. Open browser
2. Go to: [https://code.visualstudio.com](https://code.visualstudio.com)
3. Download **VS Code for Windows**
4. Install normally

---

## 📌 Step 5 – Install Terraform

1. Go to: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)
2. Download: **Windows AMD64**

Example file:

```
terraform_1.x.x_windows_amd64.zip
```

---

## 📌 Step 6 – Extract Terraform

1. Go to **Downloads**
2. Right-click ZIP file → **Extract All**
3. After extraction, you will see:

```
terraform.exe
```

---

## 📌 Step 7 – Create Terraform Folder

Create a folder:

```
C:\Terraform
```

Move:

```
terraform.exe
```

Final structure:

```
C:\Terraform\terraform.exe
```

---

## 📌 Step 8 – Add Terraform to Environment Variables

1. Press **Windows Key**
2. Search: `Environment Variables`
3. Click: **Edit the system environment variables**
4. Click **Environment Variables**
5. Under **System Variables → Path → Edit → New**
6. Add:

```
C:\Terraform
```

7. Click **OK**

---

## 📌 Step 9 – Verify Terraform Installation

Open Command Prompt and run:

```bash
terraform -version
```

✅ Example Output:

```
Terraform v1.x.x
```

---

## 📌 Step 10 – Install Azure CLI

Download from:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

🔍 Verify Installation
az --version
⚠️ Troubleshooting (Only if command fails)

If az --version is not recognized, add Azure CLI to PATH manually:

C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin

Then:

Restart terminal / VS Code
Run again:
az --version

---

## 📌 Step 11 – Open VS Code

1. Open VS Code
2. Click: **File → Open Folder**
3. Create folder:

```
C:\Users\User\terraform-project
```

---

## 📌 Step 12 – Create Terraform File

Inside the project folder:

* Create new file → `main.tf`

👉 `.tf` = Terraform configuration file

---

## 📌 Step 13 – Add Provider Configuration

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

---

## 📌 Step 14 – Open Terminal in VS Code

```
Terminal → New Terminal
```

Example:

```
PS C:\Users\User\terraform-project>
```

---

## 📌 Step 15 – Get Tenant ID from Azure

1. Open: [https://portal.azure.com](https://portal.azure.com)
2. Search: **Microsoft Entra ID**
3. Click **Overview**
4. Copy **Tenant ID**

---

## 📌 Step 16 – Login to Azure

```bash
az login --tenant <tenant-id>
```

Example:

```bash
az login --tenant acc0c915-b8fb-47d4-aaa0-c1d689b552e5
```

---

## 📌 Step 17 – Add Resource Group Code

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-terraform-demo"
  location = "Central India"
}
```

---

## 📌 Step 18 – Initialize Terraform

```bash
terraform init
```

✅ Output:

```
Terraform has been successfully initialized
```

---

## 📌 Step 19 – Check Execution Plan

```bash
terraform plan
```

👉 Shows what Terraform will create

---

## 📌 Step 20 – Apply Configuration

```bash
terraform apply
```

Type:

```
yes
```

---

## 📌 Step 21 – Verify in Azure Portal

1. Open Azure Portal
2. Search: **Resource Groups**
3. Verify:

```
rg-terraform-demo
```

✅ Successfully created

---

## 📌 Step 22 – Destroy Resources (Optional)

```bash
terraform destroy
```

Type:

```
yes
```

---

# 🔁 Terraform Workflow Summary

```
Install Terraform
        ↓
Add Terraform Path
        ↓
Open VS Code
        ↓
Create main.tf
        ↓
Login to Azure
        ↓
terraform init
        ↓
terraform plan
        ↓
terraform apply
```

---

# 🎯 Final Outcome

✅ Azure Resource Group created using Terraform
✅ Hands-on with IaC (Infrastructure as Code)
✅ Ready for next level (VM, VNet, Storage)

---
