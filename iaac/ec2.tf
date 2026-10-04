resource "aws_instance" "this" {

    count = 2

    ami = data.aws_ami.web-app.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    key_name = "pranav-devops-june-ohio"

    associate_public_ip_address = true
    metadata_options {
      http_endpoint = "enabled"
      http_tokens = "optional"
    }
    tags = {
        Name = "${var.batch_code}-terraform-ec2-instance"
        Environment = var.environment
    }

    security_groups = [ aws_security_group.this.id ]

    depends_on = [ aws_vpc.this ]

    lifecycle {
      ignore_changes = [ security_groups ]
    }
  
}

resource "aws_security_group" "this" {
    vpc_id = aws_vpc.this.id
    name = "${var.batch_code}-terraform-sg"
    description = "Security group for ${var.batch_code} terraform project"
    tags = {
      Name = "${var.batch_code}-terraform-sg"
    }
  
}

resource "aws_security_group_rule" "ingress_rule" {

    type = "ingress"
    security_group_id = aws_security_group.this.id

    for_each = var.ingress_rules

    from_port = each.value.from_port
    to_port = each.value.to_port
    protocol = each.value.protocol  
    cidr_blocks = each.value.cidr_blocks
  
}

resource "aws_security_group_rule" "egress_rule" {

    type = "egress"
    security_group_id = aws_security_group.this.id

    for_each = var.egress_rules

    from_port = each.value.from_port
    to_port = each.value.to_port
    protocol = each.value.protocol
    cidr_blocks = each.value.cidr_blocks

  
}