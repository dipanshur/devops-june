data "aws_ami" "web-app" {
    
    filter {
      name = "tag:Name"
      values = [ "webapp" ]
    }
  
}