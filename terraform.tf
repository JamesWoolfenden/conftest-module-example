
resource "aws_security_group_rule" "my-rule" {
  type              = "ingress"
  description       = "amything will do"
  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = 80
  from_port         = 80
  protocol          = "http"
  security_group_id = aws_db_security_group.my-group.id
}

#checkov:skip=CKV_AWS_2: "Ensure ALB protocol is HTTPS"
resource "aws_alb_listener" "my-alb-listener" {
  port              = "80"
  protocol          = "HTTPS"
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
  #checkov:skip=CKV_AWS_23: "Ensure every security groups rule has a description"
  name = "db"

  ingress {
    cidr = "10.0.0.0/24"
  }
}
