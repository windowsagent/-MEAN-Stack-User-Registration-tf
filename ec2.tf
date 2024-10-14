resource "aws_instance" "api_instance" {
    ami = "ami-058bd2d568351da34"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    key_name = "knox-key"

    security_groups = [aws_security_group.api_instance_sg.id]

    tags = {
        name = "api_instance"
    }

    user_data_base64 = base64encode("${templatefile("${path.module}/provision.sh", {})}")
}

output "instance_ip" {
    description = "Public IP of the monolithic instance"
    value = aws_instance.api_instance.public_ip
}