resource "aws_key_pair" "ec2_deploy_key" {
  key_name   = "ec2_instance"
  public_key = var.ec2_key_pair_public_key
}

data "template_file" "initial_installation" {
  template = file(var.tfl_script)
}
resource "aws_instance" "ec2_instance" {
  ami = var.ec2_ami

  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_deploy_key.key_name

  monitoring           = var.monitoring
  iam_instance_profile = var.instance_profile

  associate_public_ip_address = var.public_ip_association
  ebs_optimized               = var.ebs_optimized

  user_data = data.template_file.initial_installation.rendered

  tags = {
    Name    = var.instance_name
    Billing = var.instance_name
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = var.delete_on_termination
    volume_size           = var.volume_size
    volume_type           = var.volume_type

    tags = {
      Name = var.instance_name
    }
  }
}
