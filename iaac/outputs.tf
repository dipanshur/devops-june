output "ami_id" {
    value = data.aws_ami.web-app.id
  
}

output "vpc_id" {
    value = aws_vpc.this.id
  
}

output "instance_id" {
    value = aws_instance.this[*].id
  
}

output "instance_public_ip" {
    value = aws_instance.this[*].public_ip
  
}

output "extra_subnet_id" {
    value = aws_subnet.private2[*].id
  
}