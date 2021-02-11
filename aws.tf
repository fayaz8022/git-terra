provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "testterrafrom" {
  ami           = "ami-08e0ca9924195beba"
  instance_type = "t2.micro"
  user_data     = <<-EOF
             #!/bin/bash
             yum install java -y
             yum install wget -y
             cd /opt/
             wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.43/bin/apache-tomcat-9.0.43.tar.gz
             tar -xvf apache-tomcat-9.0.43.tar.gz
             ./apache-tomcat-9.0.43/bin/catalina.sh run
             EOF
  tags = {
    Name = "tomcat_container"
  }
}

