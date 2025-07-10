# Terraform Secure Artifacts Bucket

---

## Project Overview

This project provisions a secure, versioned S3 bucket with AES256 server-side encryption (SSE-S3) for storing CI/CD artifacts. The bucket name includes a random suffix to guarantee global uniqueness.

---

## Resources Created
- AWS S3 bucket with a unique name  
- AWS S3 bucket versioning enabled (via aws_s3_bucket_versioning)  
- AWS S3 server-side encryption configuration (AES256)  

---

## Usage

### Prerequisites

- A remote backend and state lock table must be provisioned and accessible (S3 bucket and DynamoDB table) before running the pipeline.

### 1. Environment variables

The GitHub Actions CI/CD pipeline uses the following secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### 2. Deployment

Clone the repository and push changes to trigger the CI/CD workflow.

---

## CI/CD Pipeline

A GitHub Actions workflow (`.github/workflows/deploy.yml`) is included to automate Terraform deployment on every push. 

The pipeline:
- Sets required environment variables
- Initializes Terraform  
- Formats and validates Terraform code 
- Executes Terraform plan and apply to provision resources  

It uses GitHub Actions environment secrets for secure authentication.
The `PROJECT_URL` variable is injected automatically by the pipeline and passed to Terraform for tagging purposes.

---

## Variables

| Variable      | Description                                | Required |
|---------------|--------------------------------------------|----------|
| name          | Resources name prefix                      | Yes      |
| tags          | Custom tags to apply to all resources      | Yes      |
| project_url   | Project repository URL                     | Yes      |

---

## Tags

All AWS resources are consistently tagged for clarity, traceability, and ownership. Tags include:

| Key           | Value                                                       |
|---------------|-------------------------------------------------------------|
| `Environment` | `<environment>` (e.g., `production`, `dev`, `staging`)      |
| `Owner`       | `<team-name>` (e.g., `devops-team`, `backend-team`)         |
| `Project`     | `<project-name>`                                            |
| `Name`        | `<prefix-name> + <resource-type>`                           |
| `project_url` | `<project-repo-url>`                                        |

---

## Outputs

| Name        | Description           |
|-------------|-----------------------|
| bucket_name | Bucket name           |
| bucket_arn  | Bucket ARN            |
| bucket_id   | Bucket ID             |

---

## Additional Notes
- This project uses a remote backend for Terraform state management. Ensure the backend (S3 bucket and DynamoDB table) is provisioned and accessible before running the pipeline.
