resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.api_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        name = "public subnet"
    }
}