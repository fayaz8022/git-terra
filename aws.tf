provider "aws"{
    region = "ap-south-1"
}
resource "aws_instance" "testterrafrom" {
      ami = "ami-08e0ca9924195beba"
      instance_type = "t2.micro"
 tags = {
    Name = "Myappllication"
  }

}
