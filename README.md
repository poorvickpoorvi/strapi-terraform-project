**=> Strapi Terraform Deployment on AWS <=**

This project deploys a Strapi CMS application on AWS using Terraform.
AWS resources are created and managed automatically through infrastructure-as-code.

What this project does ?

✔ Creates AWS EC2 instance (Ubuntu)
✔ Installs Node.js, npm, and Strapi automatically
✔ Sets up Security Groups to allow SSH and Strapi port (1337)
✔ Uses PM2 to run Strapi in background
✔ Outputs public IP and Strapi URL after deployment

->Project Structure
strapi-terraform-project/
│
├─ infra/                 # Terraform files to deploy infrastructure
│   ├─ main.tf
│   ├─ variables.tf
│   ├─ outputs.tf
│
└─ strapi-app/            # Strapi application source code

⚙️ Requirements
Tool / Service	Version
Terraform	v1.5+
Node.js	v18+
AWS Account	Required
🔧 Deployment Steps

Run these commands inside the infra folder:

terraform init
terraform plan
terraform apply


After apply, Terraform will show:

strapi_public_ip = "xx.xx.xx.xx"
strapi_url       = "http://xx.xx.xx.xx:1337"


Open the Strapi dashboard in your browser 👆

 Destroy Resources (to avoid AWS charges)
terraform destroy

* Notes

Make sure the SSH key pair name in Terraform matches your AWS Key Pair.

Use free tier resources to avoid AWS billing.

Do not expose AWS credentials in GitHub.
