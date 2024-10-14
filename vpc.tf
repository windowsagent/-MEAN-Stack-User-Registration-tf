resource "aws_vpc" "api_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        name = "api_vpc"
    }
}

resource "aws_internet_gateway" "api_igw"{
    vpc_id = aws_vpc.api_vpc.id
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.api_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.api_igw.id
    }
    tags = {
        name = "Public subnet route table"
    }
}

resource "aws_security_group" "api_instance_sg" {
    vpc_id = aws_vpc.api_vpc.id
        # Access to frontend (HTTP)
        ingress {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        # Internet access to anywhere
        egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
}

output "vpc_id" {
    value = aws_vpc.api_vpc.id
}