resource "aws_launch_template" "product_project_ha_lt" {
  name                   = "product-project-app"
  description            = "Standard template for web application servers"
  image_id               = "ami-011c04cb040289c2a"
  instance_type          = "t3.micro"
  key_name               = "mine"
  vpc_security_group_ids = [aws_security_group.product_project_ha_sg.id]
  #   iam_instance_profile {
  #     name = ""
  #   }

}

resource "aws_autoscaling_group" "product_project_ha_asg" {
  name_prefix         = "project-product-app-asg-"
  min_size            = 3
  max_size            = 6
  desired_capacity    = 3
  vpc_zone_identifier = ["subnet-0786e56b84ef0b03f", "subnet-039696cf44c263054", "subnet-02b27a6ac45ce1437"]

  launch_template {
    id      = aws_launch_template.product_project_ha_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "product-project-app"
    propagate_at_launch = true
  }

}

