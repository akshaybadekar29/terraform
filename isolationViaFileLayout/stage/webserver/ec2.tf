provider "aws"{
    region = "us-east-1"
}


variable "keypair" {
  
  type = string 
  default = "2019"
}

resource "aws_instance" "webserver" {

    ami = "ami-0b69ea66ff7391e80"
    instance_type ="t2.micro"
    vpc_security_group_ids =  [ aws_security_group.Web_Security_Group.id ]
    user_data = "${data.template_file.userdata.rendered}"
    key_name = var.keypair
    tags = {
        Name = "webserver"
    }

}


resource "aws_security_group" "Web_Security_Group" {
    name = "Web_Security_Group"
    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
}
