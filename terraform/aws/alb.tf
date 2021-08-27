resource "aws_lb" "tsuchida-alb" {
  name               = "${var.PROJECT}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-web.id]
  subnets            = [aws_subnet.tsuchida-subnet-a.id, aws_subnet.tsuchida-subnet-c.id]

  // enable_deletion_protection = true

  tags = {
    Name = "${var.PROJECT}-alb"
  }

  access_logs {
    bucket  = aws_s3_bucket.alb-log-bucket.bucket
    enabled = true
  }
}

resource "aws_lb_listener" "http-redirect" {
  load_balancer_arn = aws_lb.tsuchida-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = 200
      message_body = "OK"
    }
  }
}