resource "aws_vpc" "this" {
    tags = {
        Name = "${var.batch_code}-terraform-vpc"
        Environment = var.environment
    }

    cidr_block = var.vpc_cidr  #"10.0.0.0/16"
    instance_tenancy   = "default"

}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.batch_code}-terraform-public-subnet"
        Environment = var.environment
    }

    availability_zone = var.public_subnet_az
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.batch_code}-terraform-private-subnet"
        Environment = var.environment
    }

    availability_zone = var.private_subnet_az
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = false
  
}

resource "aws_subnet" "private2" {

    count = var.extra_private_subnet_needed ? length(var.extra_private_subnet_pool) : 0

    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.batch_code}-terraform-private-subnet"
        Environment = var.environment
    }

    availability_zone = var.private_subnet_az
    cidr_block = var.extra_private_subnet_pool[count.index]
    map_public_ip_on_launch = false
  
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.batch_code}-terraform-internet-gateway"
        Environment = var.environment
    }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.batch_code}-te rraform-public-route-table"
        Environment = var.environment
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
        Name = "${var.batch_code}-terraform-private-route-table"
        Environment = var.environment
    }
  
}

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id 
  
}

resource "aws_route_table_association" "private2" {

    count = var.extra_private_subnet_needed ? length(var.extra_private_subnet_pool) : 0

    subnet_id =   aws_subnet.private2[count.index].id
    route_table_id = aws_route_table.private.id

    depends_on = [ aws_subnet.private2 ]
  
}


