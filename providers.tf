provider "aws" {

    region = "us-east-2"
    alias = "ue2"
    assume_role {
        role_arn = "arn:aws:iam::372517046939:role/tg-devops-june-terraform-role"
        session_name = "terraform"
    }
    
}

provider "aws" {
    region = "ap-south-1"
    alias = "aps1"

    assume_role {
        role_arn = "arn:aws:iam::372517046939:role/tg-devops-june-terraform-role"
        session_name = "terraform"
    }
  
}