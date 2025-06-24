# 🧾 AWS Serverless Expense Tracker (Terraform Edition)

A fully serverless, multi-user expense tracker built with **Terraform** using AWS services like **Lambda**, **API Gateway**, **DynamoDB**, **Cognito**, **S3**, and **CloudFront** — all deployed via Infrastructure as Code (IaC) within the AWS Free Tier.

> 🔐 Authenticated access, 📊 exportable data, and 💾 receipt uploads — all backed by secure, modular Terraform.

---

## 🚀 Tech Stack

| Layer        | Service                     |
|--------------|-----------------------------|
| IaC          | Terraform (modular setup)   |
| Auth         | Amazon Cognito (via `auth/`)|
| Backend      | API Gateway + Lambda        |
| Database     | DynamoDB (`db/` module)     |
| Storage      | Amazon S3 (`s3_data/`)      |
| Frontend     | HTML/CSS via CloudFront     |

---

## ✅ Features

- 🔐 Secure login using Amazon Cognito
- 💸 Add, retrieve, and export user-specific expenses
- 🧾 Upload and store receipt images in S3
- 🗃️ Export expenses as JSON for analysis (e.g., QuickSight)
- ⚙️ All components deployed with Terraform
- 🌍 CORS support enabled
- 🧱 Organized with reusable, isolated modules
- 🧪 Designed to stay within the AWS Free Tier

---

## 🧱 Project Structure

```

myET/
│
├── build/
│   └── lambda\_zips/
│       ├── add.zip
│       ├── get.zip
│       └── export.zip
│
├── html/
│   ├── login.html
│   └── tracker.html
│
├── modules/
│   ├── api/
│   ├── auth/                      # Amazon Cognito
│   ├── cors/                      # CORS configuration
│   ├── db/                        # DynamoDB table
│   ├── frontend/                  # S3 + CloudFront + config.js.tpl
│   ├── iam/                       # IAM roles & policies
│   ├── lambdas/
│   │   ├── add/
│   │   ├── get/
│   │   └── export/
│   └── s3_data/                   # S3 bucket for receipts/data
│
├── main.tf                       # Root Terraform config
├── outputs.tf                    # Project-wide outputs
├── variables.tf                  # Common root-level variables
└── README.md                     # You're reading it!

````

---

## 🛠️ How to Deploy

Make sure you have:
- AWS CLI configured
- Terraform installed (v1.6+)

### 1. Clone the Repo

```bash
git clone https://github.com/Oshinyemio/terraform-aws-expense-tracker.git
cd terraform-aws-expense-tracker
````

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Apply Infrastructure

```bash
terraform apply
```

Terraform will:

* Create the API Gateway, Lambda functions, and DynamoDB table
* Set up Cognito for user sign-up/login
* Create S3 buckets for app hosting and data storage
* Deploy your `login.html`, `tracker.html`, and generate `config.js` via `config.js.tpl`

---

## 🌐 After Deployment

1. Copy the CloudFront URL output from Terraform.
2. Open it in your browser — the app is live!
3. Use the login/signup interface to create a new user.
4. Start adding expenses and (optionally) uploading receipts.

---

## 📸 Project Architecture

![tracker-architecture](https://github.com/user-attachments/assets/2c34ecb4-db2b-425e-b5b4-fcacfc5b1613)

---

## 📄 License

MIT License — free to use, adapt, and learn from.

---

## 🙋 About the Author

**Ope (Oshinyemio)**
Cloud | DevOps | Terraform | AWS
[GitHub](https://github.com/Oshinyemio)

---

## ⭐️ Star This Project

If you found this project helpful or interesting, consider starring ⭐ the repo to support more Terraform-based projects like this.
