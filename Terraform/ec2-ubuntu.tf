#Resource to Create Key Pair
# resource "aws_key_pair" "demo_key_pair" {
#   key_name   = var.key_pair_name
#   public_key = var.public_key
# }

# resource "aws_instance" "ubuntu_server" {
#   ami           = "ami-07b8a117da8f2c473"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.demo_key_pair.key_name
# }

# ami "us-west-2" = "ami-07b8a117da8f2c473"

provider "aws" {
   region     = "us-west-2"
   access_key = ""
   secret_key = ""
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-07b8a117da8f2c473"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("C:\Users\ydjou\workspace\key-pair")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "SHA256:upbioyqyf44wxfrpd3YtJ2mpozoeSE7jijhJ8mJxAaM ydjou@LAPTOP-33DRIP57"
}
