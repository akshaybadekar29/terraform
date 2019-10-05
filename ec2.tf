provider "aws"{
    region = "us-east-1"
}

data "template_file" "userdata" {
  template = "${file("template/userdata.tpl")}"
}

data "aws_vpc" "default" {
    default =true
  
}

data "aws_subnet_ids" "default" {

    vpc_id = data.aws_vpc.default.id
  
}


variable "http_port" {

    description = "http port"
    type = number
    default = 80
  
}

variable "asg_min_size" {
    description = "number of ec2 minimum instance auto scalling group"
    type =number
    default=2
  
}

variable "asg_max_size" {
    description = "number of ec2 maximum instance auto scalling group"
    type =number
    default=3
  
}

resource "aws_instance" "webserver" {

    ami = "ami-0b69ea66ff7391e80"
    instance_type ="t2.micro"
    vpc_security_group_ids =  [ aws_security_group.Web_Security_Group.id ]
    user_data = "${data.template_file.userdata.rendered}"
    key_name = "2019"
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

resource "aws_launch_configuration" "web_server_launch_config" {
   image_id = "ami-0b69ea66ff7391e80"
   instance_type = "t2.micro"
   security_groups = [ aws_security_group.Web_Security_Group.id ]
   user_data = "${data.template_file.userdata.rendered}"
}

resource "aws_autoscaling_group" "web_server_autoscalling_group" {

  launch_configuration = aws_launch_configuration.web_server_launch_config.name
  vpc_zone_identifier =  data.aws_subnet_ids.default.ids
  min_size = var.asg_min_size
  max_size = var.asg_max_size
  tag{
      key = "Name"
      value = "ASG terraform"
      propagate_at_launch = true

  }
  lifecycle{
  
  create_before_destroy=true
  }
}
