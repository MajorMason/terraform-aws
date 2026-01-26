#Similar to NSGs over on Azure, AWS' security groups will permit or deny traffic
#based on several characteristics as seen below with our ingress and egress rules
#NOTE: AWS can rely on both Security Groups and ACLs for resource/network security
resource "aws_security_group" "security_group" {
  vpc_id = data.aws_vpc.main_vpc.id
  name = "ECS-SG"

  tags = {
    environment = "${var.environment}"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#We must specify a value of "-1" which denotes "all" and as such, requries
#us to also define a port range of zero to zero, no other ranges are accepted
