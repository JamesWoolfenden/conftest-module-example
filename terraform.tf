
resource "aws_security_group_rule" "my-rule" {
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = 80
  from_port         = 80
  protocol          = "http"
  security_group_id = aws_db_security_group.my-group.id
}

resource "aws_alb_listener" "my-alb-listener" {
  port              = "80"
  protocol          = "HTTP"
  load_balancer_arn = ""
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_db_security_group" "my-group" {
  name = "db"
  ingress {
    cidr = "10.0.0.0/24"
  }
}

