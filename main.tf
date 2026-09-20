resource "aws_vpc" "this" {
    tags = {
        Name = "tg-devops-june-terraform-vpc"
        Environment = "devops"
    }

    cidr_block = "10.0.0.0/16"
    instance_tenancy   = "default"

}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "tg-devops-june-terraform-public-subnet"
        Environment = "devops"
    }

    availability_zone = "us-east-2a"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "tg-devops-june-terraform-private-subnet"
        Environment = "devops"
    }

    availability_zone = "us-east-2a"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = false
  
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "tg-devops-june-terraform-internet-gateway"
        Environment = "devops"
    }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "tg-devops-june-terraform-public-route-table"
        Environment = "devops"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }

  
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "tg-devops-june-terraform-private-route-table"
        Environment = "devops"
    }
  
}

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id 
  
}