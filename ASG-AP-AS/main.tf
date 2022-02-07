provider "aws" {
  region = "ap-southeast-2"
}



# Define Autoscalling launch configurations
#Outputs name
resource "aws_launch_configuration" "custom_launch_config" {

  name = "custom_launch_config"
  image_id = "ami-0ae77e53d9de53d0e"
  instance_type = "t2.micro"
  #USE aws Resouce mapped to key pair
  

}

# Define an Auto Scalling Group

resource "aws_autoscaling_group" "auto_scalling_g" {

name = "auto_scalling_g"
desired_capacity = 1
max_size = 2
min_size = 1
health_check_grace_period = 300
health_check_type = "EC2"
force_delete = true
launch_configuration = aws_launch_configuration.custom_launch_config.name
vpc_zone_identifier = [ "subnet-a3c582fb" ]

#tag {

#key = "Name"
#propagate_at_launch = true

#}
  
}

# Define Autoscalling UP Configuration Policy
resource "aws_autoscaling_policy" "custom_cpu_policy" {
  name = "custom_cpu_policy"
  autoscaling_group_name = aws_autoscaling_group.auto_scalling_g.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 100
  policy_type = "SimpleScaling"
  
}

#Define Cloudwatch CPU monitoring for Scalling Metrics
resource "aws_cloudwatch_metric_alarm" "cw_cpu_alarm" {
  alarm_name = "CPU Alarm Scale"
  alarm_description = "Breached CPU treshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 80

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.auto_scalling_g.name

  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.custom_cpu_policy.arn]
  

}

#Define auto descaling policy

resource "aws_autoscaling_policy" "custom_cpu_descaling" {
  name = "custom_cpu_descaling"
  autoscaling_group_name = aws_autoscaling_group.auto_scalling_g.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown = 100
  policy_type = "SimpleScaling"
  
}

# Define Descaling Cloud Watch
resource "aws_cloudwatch_metric_alarm" "cw_cpu_scaledown" {
  alarm_name = "cw_cpu_scaledown"
  alarm_description = "Below CPU treshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 40

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.auto_scalling_g.name

  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.custom_cpu_descaling.arn]
  

}




