# terraform-X
### Terraform Learning Experiments

This repository is a sandbox for experimenting with [Terraform](https://www.terraform.io/), a powerful Infrastructure as Code (IaC) tool. My goal with this project is to understand the basics of Terraform, including provisioning resources, managing state, and writing reusable code.

## Project Overview

In this project, I'm using Terraform to:
- Set up AWS provider configuration.
- Launch and manage basic AWS resources like EC2 instances.
- Get familiar with Terraform commands and workflows (`init`, `plan`, `apply`, `destroy`, `output`).
- Experiment with creating reusable and modular Terraform configurations.
- Customize instance names and types using variables defined in `terraform.tfvars`.
- Output useful details like instance ID and public IP address.

## Project Structure

```plaintext
.
├── main.tf                # Main configuration for AWS resources
├── output.tf              # Output variables (instance ID, public IP)
├── provider.tf            # AWS provider configuration
├── terraform.tfvars       # Input values for instance name and type
├── variables.tf           # Definitions of input variables
├── .gitignore             # Ignore sensitive or unnecessary files
└── README.md              # This file
```

- **`main.tf`**: Defines the resource block to create an EC2 instance.
- **`output.tf`**: Specifies output variables, such as instance ID and public IP.
- **`provider.tf`**: Configures the AWS provider and the region to be used for resources.
- **`terraform.tfvars`**: Stores values for the variables (instance name and type).
- **`variables.tf`**: Declares the variables used across the Terraform configuration.

## Prerequisites

To follow along with this repository, make sure you have the following set up:
1. An [AWS account](https://aws.amazon.com/free).
2. [Terraform](https://www.terraform.io/downloads) installed on your local machine.
3. AWS credentials configured (using `aws configure` or environment variables).

---

## Getting Started

### 1. Clone the Repository

Start by cloning this repository to your local machine:

```bash
git clone https://github.com/s000ik/terraform-X.git
cd terraform-X
```

### 2. Configure AWS Credentials

Make sure your AWS credentials are configured. You can use the AWS CLI by running:

```bash
aws configure
```

Alternatively, you can set the environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).

### 3. Verify Terraform Installation

Check that Terraform is installed correctly by running:

```bash
terraform -help
```

---

## Key Terraform Commands

Here are the most common Terraform commands you'll use:

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
   This installs the necessary provider plugins and sets up your Terraform environment.

2. **Preview Changes**:
   ```bash
   terraform plan
   ```
   This shows you what changes Terraform will make (create, modify, or destroy resources).

3. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
   This actually provisions the resources defined in your `.tf` files. Terraform will prompt for confirmation, just type `yes` to proceed.

4. **Destroy the Infrastructure**:
   ```bash
   terraform destroy
   ```
   This will tear down all resources created by Terraform. It’s good practice to destroy resources when you're done experimenting.

---

## Understanding the Configuration

### Provider Configuration (`provider.tf`)

In the `provider.tf` file, we specify the AWS provider and the region where the resources will be provisioned:

```hcl
provider "aws" {
  profile = "default"  # Your AWS CLI profile
  region  = "ap-south-1"  # The AWS region for your resources
}
```

### EC2 Instance Configuration (`main.tf`)

The `main.tf` file defines the EC2 instance resource, where you can customize things like the instance type and the AMI to be used:

```hcl
resource "aws_instance" "myec2" {
  ami           = "ami-0fd05997b4dff7aac"  # Amazon Linux 2023 AMI x86 (or any other AMI)
  instance_type = var.ec2_instance_type
  tags = {
    Name = var.instance_name
  }
}
```

### Variables (`variables.tf` and `terraform.tfvars`)

The `variables.tf` file defines the input variables that can be customized:

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

In the `terraform.tfvars` file, you can override these values:

```hcl
instance_name    = "MyInstance"
ec2_instance_type = "t2.micro" 
```

### Outputs (`output.tf`)

The `output.tf` file defines output variables that display important information after resources are created, such as the EC2 instance ID and public IP:

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

To avoid unnecessary charges, always remember to destroy the resources you've created once you're done:

```bash
terraform destroy
```

---

## Important Notes

1. **AWS Free Tier**:
   - Be sure to stay within the [AWS Free Tier](https://aws.amazon.com/free/) limits to avoid unexpected charges while learning.

2. **Learning Approach**:
   - This repository is meant for experimentation and learning. Feel free to make changes to the code, but remember to clean up resources using `terraform destroy` when you're finished.

---

## Useful Links

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

---

## Disclaimer

This repository is intended solely for learning purposes. Always review and understand your configurations before applying them in any real environment.

