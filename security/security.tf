resource "aws_key_pair" "ssh_access" {
  key_name   = "ssh_access"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTuSUxr4Udrx5q3LZPfqUo202LHntq2s30rZJa48C9MPFVuXu/n+Rd/pnjL3osMag7xDYQmtpqQ6umTbCYuTSWLfzBhifFgjly1AnflfnSxDQChfhqqTk3s8aRa3CSJIgGRcfXGLz9XzSR8CU3alH3SI8fuf1sSuhpa+ENsjs71hyT7QQEwFW77vktvn1gIXu8Rhgy68I2zZMcS6SlKooP41/6yrCHwLC3cd4uky2HowOHCQCmTK5XxMn7o9FYyxpZl/7qGpPGSvD079iKiGeQhJ4zE5dtesEklXJly2kTR4cJ6XUgewKOyW4uI+mF9RWY790N+F39U4HFEVV7E3N9 SSH Access"
}  

output "key_name" {
  value = "${aws_key_pair.ssh_access.key_name}"
}

 

  
  
