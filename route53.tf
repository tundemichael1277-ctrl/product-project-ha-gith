# Create a Public Route 53 Hosted Zone
resource "aws_route53_zone" "tdmfashion" {
  name    = "tdmfashion.com"
  comment = "Managed by Terraform"
}

# Create a Standard A Record (pointing to an IPv4 address)
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.tdmfashion.id
  name    = "www.tdmfashion.com"
  type    = "A"
  ttl     = 300
  records = ["192.0.2.1"] # Replace with your public IP address
}

# Create an Alias Record (pointing to an AWS Resource like an ALB)
resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.tdmfashion.id
  name    = "tdmfashion.com"
  type    = "A"

  alias {
    name                   = "plant-project-ASG-1-6782297702.eu-west-2.elb.amazonaws.com" 
    zone_id                = "ZHURV8PSTC4K8"           
    evaluate_target_health = true
  }
}
