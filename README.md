# AWS S3 Static Website Hosting with Terraform

## Overview

This project provisions an AWS S3 bucket to host a static website using Terraform. It configures the necessary policies to allow public access to the website files and uploads all content from the `website` directory.

## Infrastructure

- **Terraform**: Infrastructure as Code (IaC) tool used to provision AWS resources.
- **AWS S3**: Object storage service used to host the static website.
- **S3 Bucket Policy**: Grants public read access to objects within the bucket.
- **S3 Website Configuration**: Enables static website hosting with an index document.

## Prerequisites

Ensure you have the following installed before proceeding:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://aws.amazon.com/cli/)
- An AWS account with appropriate permissions

## Setup Instructions

### 1. Clone the Repository

```sh
git clone <repository_url>
cd <repository_name>
```

### 2. Configure AWS Credentials

Ensure your AWS credentials are set up properly using the AWS CLI:

```sh
aws configure
```

Alternatively, you can use an IAM role if running from an AWS environment.

### 3. Initialize Terraform

Run the following command to initialize Terraform and download required providers:

```sh
terraform init
```

### 4. Customize Variables

Modify the `variables.tf` file to set the AWS region and S3 bucket name:

```hcl
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_bucket_name" {
  default = "your-unique-bucket-name"
}
```

### 5. Apply Terraform Configuration

Run the following command to create the resources:

```sh
terraform apply -auto-approve
```

This will provision the S3 bucket, configure policies, and upload website files.

### 6. Access Your Website

After deployment, Terraform outputs the website URL. You can retrieve it using:

```sh
echo $(terraform output website_url)
```

Copy and paste the URL into a browser to view your static website.

## Cleanup

To destroy the resources and remove the S3 bucket, run:

```sh
terraform destroy -auto-approve
```

This will delete all provisioned resources.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributions

Feel free to open issues or submit pull requests to improve this project.
