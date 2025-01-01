# terraform-X 
### Terraform Learning Experiments

### This repository is a sandbox for me to experiment with [Terraform](https://www.terraform.io/), an Infrastructure as Code (IaC) tool. The goal of this is to understand the basics of Terraform, including resource provisioning, state management, and configuration.


## Project Overview

This repository contains Terraform configuration files (`*.tf`) to:
- Setup AWS provider configuration.
- Launch and provision a basic AWS resource like EC2 instances.
- Understand Terraform commands and workflows (`init`, `plan`, `apply`, `destroy`).
- Practice writing reusable and modular Terraform code.
- Customizable instance name and type via variables (`terraform.tfvars`).
- Outputs to display the instance ID and public IP address.

## Files Overview

```plaintext
.
├── main.tf                # Main Terraform configuration for resources
├── output.tf              # Output variables (instance ID, public IP)
├── provider.tf            # AWS provider configuration
├── terraform.tfvars       # Input variables with values for instance name/type
├── variables.tf           # Terraform variables definition
├── .gitignore             # Ignore sensitive and unnecessary files
└── README.md              # This file
```

- **`main.tf`**: Contains the resource block to create an EC2 instance.
- **`output.tf`**: Contains output blocks to display the instance ID and public IP.
- **`provider.tf`**: Configures the AWS provider to interact with the AWS account and set the region.
- **`terraform.tfvars`**: Specifies the values for variables like instance name and instance type.
- **`variables.tf`**: Declares the variables used across the Terraform configuration.


## Prerequisites

To follow along this repository, make sure you have the following:
1. An [AWS account](https://aws.amazon.com/free).
2. [Terraform](https://www.terraform.io/downloads) installed on your machine.
3. AWS credentials configured locally using `aws configure` or environment variables.

---

## Setting Up and Running Terraform

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/s000ik/terraform-X.git
cd terraform-X
```

### 2. Configure AWS Credentials

Ensure you have configured your AWS credentials either by running `aws configure` or setting the necessary environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).

### 3. Verifying Terraform

Run the following command to verify the correct installation of Terraform:

```bash
terraform -help
```
---

## Key Terraform Commands

Here are some commonly used commands to manage the infrastructure:

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
   This downloads the necessary provider plugins and initializes the project.

2. **Plan the Infrastructure**:
   ```bash
   terraform plan
   ```
   This previews the changes that Terraform will make.

3. **Apply the Changes**:
   ```bash
   terraform apply
   ```
   This provisions the resources defined in the `*.tf` files.

4. **Destroy the Infrastructure**:
   ```bash
   terraform destroy
   ```
   This tears down all resources managed by this Terraform configuration.

---

## Understanding the Configuration

### Provider Configuration (`provider.tf`)

The `provider.tf` file configures the AWS provider, specifying the profile (set in AWS CLI) and the region:

```hcl
provider "aws" {
  profile = "default"  # AWS CLI profile
  region  = "ap-south-1"  # Your AWS region for provisioning the resources
}
```

### Resource Block (`main.tf`)

The `main.tf` file defines the resource block to provision an EC2 instance with specific properties:

```hcl
resource "aws_instance" "myec2" {
  ami           = "ami-0fd05997b4dff7aac"  # Amazon Linux 2023 AMI x86 (You can have any)
  instance_type = var.ec2_instance_type
  tags = {
    Name = var.instance_name
  }
}
```

### Variables (`variables.tf` and `terraform.tfvars`)

The `variables.tf` file defines two input variables (`instance_name` and `ec2_instance_type`) which can be customized in the `terraform.tfvars` file:

```hcl
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "MyInstance"
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}
```

In `terraform.tfvars`, you can override these variables with different values for different environments:

```hcl
instance_name    = "MyInstance"
ec2_instance_type = "t2.micro" 
```

### Outputs (`output.tf`)

The `output.tf` file captures and displays useful information after resource creation:

```hcl
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.myec2.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.myec2.public_ip
}
```

---

## Cleaning Up

Remember to always clean up the resources you’ve created to avoid unnecessary charges:

```bash
terraform destroy
```

---


## Important Notes

1. **AWS Free Tier**:
   - Ensure that the resources you provision stay within the [AWS Free Tier](https://aws.amazon.com/free/) limits to avoid unexpected charges.

2. **Learning Approach**:
   - Feel free to experiment with the code, but remember to clean up resources using `terraform destroy` after testing.

---

## Useful Links

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

---

## Disclaimer

This repository is intended solely for learning purposes. Please review and understand the configurations before applying them to your production environment.


