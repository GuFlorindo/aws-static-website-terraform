# AWS Static Website with Terraform, CloudFront OAC and GitHub Actions

This project provisions a secure static website on AWS using Terraform and demonstrates Infrastructure as Code (IaC), CloudFront, S3 security best practices and CI with GitHub Actions.

## Architecture

```text
                 Internet
                      │
                  HTTPS
                      │
                      ▼
          CloudFront Distribution
                      │
      Origin Access Control (OAC)
                      │
                      ▼
            Amazon S3 (Private Bucket)
```
## Website Image
![Imagem do site no ar](images/project.png)

## Technologies

- Terraform
- AWS S3
- Amazon CloudFront
- Origin Access Control (OAC)
- GitHub Actions
- AWS IAM
- GitHub Secrets

## Features

- Infrastructure as Code with Terraform
- Private S3 bucket
- CloudFront distribution
- Origin Access Control (OAC)
- Bucket versioning
- Secure bucket policy
- Automatic website file upload
- CI pipeline with GitHub Actions

## GitHub Actions Pipeline

Every push to the `main` branch automatically runs:

- `terraform fmt -check`
- `terraform validate`
- `terraform plan`

This ensures the Terraform configuration is formatted, valid and generates a successful execution plan before deployment.

## Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── terraform/
│   ├── provider.tf
│   ├── main.tf
│   ├── cloudfront.tf
│   ├── outputs.tf
│   └── versions.tf
├── website/
│   ├── index.html
│   ├── style.css
│   └── script.js
└── README.md
```

## Deployment

Initialize Terraform:

```bash
terraform init
```

Review the execution plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

Destroy all resources:

```bash
terraform destroy
```

## Skills Demonstrated

- Infrastructure as Code (IaC)
- Terraform
- AWS CloudFront
- Amazon S3
- Cloud Security
- GitHub Actions
- Continuous Integration (CI)
- AWS IAM
- Infrastructure automation