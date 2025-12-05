#Similar to NSGs over on Azure, AWS' security groups will permit or deny traffic
#based on several characteristics as seen below with our ingress and egress rules
resource "aws_security_group" "security_group" {
  vpc_id = aws_vpc.main_vpc.id
  name = "ECS-SG"

  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
