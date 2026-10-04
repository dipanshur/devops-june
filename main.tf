module "vpc1" {

    providers = {
      aws = aws.ue2
    }

    source = "./iaac"
    batch_code = "tg-devops-june-2026"
    vpc_cidr = "10.0.0.0/16"
    environment = "dev"
    public_subnet_az = "us-east-2a"
    private_subnet_az = "us-east-2b"
    public_subnet_cidr = "10.0.0.0/24"
    private_subnet_cidr = "10.0.1.0/24"
    extra_private_subnet_needed = true
    extra_private_subnet_pool = ["10.0.16.0/24", "10.0.17.0/24"]

    ingress_rules = {
        ssh = {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        http = {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

     egress_rules = {
        all = {
            from_port = 0
            to_port = 65535
            protocol =  "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
     }

  
}

module "vpc2" {

    providers = {
      aws = aws.aps1
    }

    source = "./iaac"
    batch_code = "tg-devops-june-2025"
    vpc_cidr = "192.168.0.0/16"
    environment = "prod"
    public_subnet_az = "ap-south-1b"
    private_subnet_az = "ap-south-1c"
    public_subnet_cidr = "192.168.0.0/24"
    private_subnet_cidr = "192.168.1.0/24"

    depends_on = [ module.vpc1 ]

    extra_private_subnet_needed = true
    extra_private_subnet_pool = ["192.168.16.0/24", "192.168.17.0/24"]

    ingress_rules = {
        ssh = {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        http = {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

     egress_rules = {
        all = {
            from_port = 0
            to_port = 65535
            protocol =  "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
     }


  
}

