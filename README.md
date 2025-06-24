# AWS Serverless Expense Tracker (Terraform Edition) ⚙️💰

This project demonstrates how to build and deploy a **serverless expense tracker** using **Terraform** for complete Infrastructure as Code (IaC) setup within the **AWS Free Tier**.

> ✅ Built from scratch with modular Terraform structure.  
> ✅ Ideal for learning or showcasing Terraform and serverless deployment patterns on AWS.

---

## 🚀 Tech Stack

| Layer       | Service Used                  |
|-------------|-------------------------------|
| **IaC**     | Terraform (modular setup)     |
| **Auth**    | Amazon Cognito                |
| **Backend** | AWS API Gateway + Lambda      |
| **Database**| DynamoDB                      |
| **Storage** | S3 (JSON + receipt images)    |
| **Frontend**| Static HTML (hosted on S3 + CloudFront) |

---

## 🧱 Terraform Module Structure

```bash
myET/
├── main.tf              # Root configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── modules/
│   ├── api_gateway/
│   ├── lambda/
│   ├── dynamodb/
│   ├── cognito/
│   ├── iam/
│   ├── s3/
│   └── cloudfront/
└── build/
    └── lambda_zips/
✅ Features
🚀 Deploys entire architecture via terraform apply

👥 Secure user authentication with Cognito

📥 Add and retrieve expenses (per user)

🧾 Upload receipts as images (optional)

📊 Export data for visualization (QuickSight-ready)

🔐 Fine-grained IAM roles and policies

🌍 Cross-Origin Resource Sharing (CORS) support

🧪 Designed to stay within the AWS Free Tier