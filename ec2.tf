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
