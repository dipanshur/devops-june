provider "aws" {

    region = "us-east-2"
    assume_role {
        role_arn = "arn:aws:iam::372517046939:role/tg-devops-june-terraform-role"
        session_name = "terraform"
    }
    
}