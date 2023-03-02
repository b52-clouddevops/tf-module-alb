# Creates listener needed to ALB ; And for this listener, we have to created the rules

resource "aws_lb_listener" "private" {
  count             = var.INTERNAL ? 1 : 0

  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "I am operational"
      status_code  = "200"
    }
}