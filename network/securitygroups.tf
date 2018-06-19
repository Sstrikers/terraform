resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow ssh"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
   tags {
    Name = "allow_ssh"
  }
}

output "allow_ssh" {
  value = "${aws_security_group.allow_ssh.id}"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "allow_http"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
   tags {
    Name = "allow_http"
  }
}

output "allow_http" {
  value = "${aws_security_group.allow_http.id}"
}