provider "aws"{
    region = "us-east-1"
}

resource "aws_instance" "webserver" {

    ami = "ami-0b69ea66ff7391e80"
    instance_type ="t2.micro"
    user_data = <<-EOF
                #!/bin/bash
                echo "hello world"
                yum update -y
                yum install -y httpd
                systemctl start httpd
                EOF
    tags = {
        Name = "webserver"
    }

}


resource "aws_security_group" "Web_Security_Group" {
    name = "Web_Security_Group"
    ingress {
        from_port = 8080
        to_port = 8080 
        protocol ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
