resource "aws_instance" "web" {
   ami           = "${var.ami_id}"
   instance_type = "${var.instance_type}"
   # count         = "${var.ec2_count}"
     key_name      = "website"
     vpc_security_group_ids = ["${aws_security_group.webSG.id}"]
            user_data = <<-EOF
  			   #!bin/bash
  				 sudo yum install httpd -y
           sudo systemctl start httpd
           sudo systemctl enable httpd
           sudo chmod 0777 /var/www/html/
            touch /var/www/html/index.html
            sudo chmod 0777 /var/www/html/index.html
            echo >> "Hello world" /var/www/html/index.html
  				 	EOF
      tags = {
    Name = "HelloWorld"
  }
}
resource "aws_security_group" "webSG" {
  name        = "webSG"
  description = "Allow ssh  inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
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
