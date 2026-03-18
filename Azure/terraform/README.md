Terraform Practical Lab
Create an Azure Resource Group using Terraform and VS Code

Step 1 – Introduction to Terraform
Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp.
Terraform allows us to create and manage cloud infrastructure using code instead of manually creating resources in the portal.
Terraform supports multiple cloud platforms such as:
Microsoft Azure
Amazon Web Services
Google Cloud
Examples of resources Terraform can create:
Virtual Machines
Storage Accounts
Networks
Resource Groups
Databases

Step 2 – Understanding Azure Resource Structure
Azure resources follow a hierarchy.
Azure Subscription
        ↓
Resource Group
        ↓
Resources (VM, Storage, Network)

Example:
Subscription
   ↓
Resource Group (Example-RG)
   ↓
VM / Storage / Network

A Resource Group is like a folder that contains all related resources.

Step 3 – Prerequisites
Before starting this lab, install the following tools.
Tool
Purpose
Visual Studio Code
Code editor
Terraform
Infrastructure as Code tool
Azure CLI
Authenticate with Azure


Step 4 – Install Visual Studio Code
Install Visual Studio Code
Steps:
Open browser
Go to
https://code.visualstudio.com

Download VS Code for Windows
Install normally.
VS Code will be used to write Terraform scripts.

Step 5 – Install Terraform
Download Terraform
Open browser
Go to
https://developer.hashicorp.com/terraform/downloads

Download:
Windows AMD64

Example file:
terraform_1.x.x_windows_amd64.zip


Step 6 – Extract Terraform
Go to Downloads
Right click the ZIP file
Click Extract All
After extraction you will see:
terraform.exe


Step 7 – Create Terraform Folder
Create a folder in C drive.
C:\Terraform

Move the file:
terraform.exe

into this folder.
Final location:
C:\Terraform\terraform.exe


Step 8 – Add Terraform to Environment Variables
This allows Terraform to run from any terminal.
Steps:
Press Windows key
Search
Environment Variables

Click
Edit the system environment variables

Click Environment Variables
Under System Variables → Path
Click Edit → New
Add:
C:\Terraform

Click OK

Step 9 – Verify Terraform Installation
Open Command Prompt.
Run:
terraform -version

Example output:
Terraform v1.x.x

If you see the version → Terraform is installed successfully.

Step 10 – Install Azure CLI
Install Azure CLI
Download from:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

Verify installation:
az --version


Step 11 – Open VS Code
Open Visual Studio Code
Click
File → Open Folder

Create a new folder
Example:
C:\Users\User\terraform-project


Step 12 – Create Terraform File
Inside the project folder:
Click New File
Name the file
main.tf

.tf means Terraform configuration file.

Step 13 – Write Terraform Provider Code
Paste the following code inside main.tf
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

Save the file.

Step 14 – Open Terminal in VS Code
Click:
Terminal → New Terminal

Terminal will open like:
PS C:\Users\User\terraform-project>


Step 15 – Find Tenant ID in Azure Portal
Open Microsoft Azure Portal
Steps:
Go to
https://portal.azure.com

Search
Microsoft Entra ID

Click Overview
Copy the Tenant ID



Step 16 – Login to Azure
In the terminal run:
az login --tenant <tenant-id>

Example:
az login --tenant acc0c915-b8fb-47d4-aaa0-c1d689b552e5

A browser window will open.
Login with your Azure account.

Step 17 – Add Resource Group Code
Add this code inside main.tf
resource "azurerm_resource_group" "example" {
  name     = "rg-terraform-demo"
  location = "Central India"
}

Save the file.

Step 18 – Initialize Terraform
Run:
terraform init

Expected message:
Terraform has been successfully initialized


Step 19 – Check Terraform Plan
Run:
terraform plan

This shows what resources Terraform will create.

Step 20 – Deploy Infrastructure
Run:
terraform apply

Type:
yes

Terraform will create the resource.

Step 21 – Verify in Azure Portal
Open Azure Portal.
Search:
Resource Groups

You will see:
rg-terraform-demo

created successfully.

Step 22 – Destroy Resources (Optional)
To delete the resource run:
terraform destroy

Type:
yes


Terraform Workflow Summary
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




