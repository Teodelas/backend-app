resource "aws_lb" "lb_good_1" {
  tags = {
    yor_trace = "aecd5a7f-6bb3-4a10-b45e-34bf4cad1a44"
  }
}

resource "aws_lb" "lb_good_2" {
  tags = {
    yor_trace = "87dcada2-cdb6-4175-9870-def053a13c63"
  }
}

resource "aws_lb" "lb_good_3" {
  tags = {
    yor_trace = "ed9da322-4900-471d-bdf3-1bddc59d76a7"
  }
}

resource "aws_alb" "alb_good_1" {
  tags = {
    yor_trace = "920888df-63fe-46d3-8344-906b28c8e2c2"
  }
}

resource "aws_lb" "lb_bad_1" {
  tags = {
    yor_trace = "99a0ae95-17e9-46e2-a4ee-ce54a380b4d9"
  }
}

resource "aws_lb" "lb_bad_2" {
  tags = {
    yor_trace = "f2e3f746-e28a-4d6e-b3d1-30a0b8b44e17"
  }
}

resource "aws_alb" "alb_bad_1" {
  tags = {
    yor_trace = "bbb06301-ad43-4133-a9e6-5191dd5193b4"
  }
}

resource "aws_lb_listener" "listener_good_1" {
  load_balancer_arn = aws_lb.lb_good_1.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type = "action"
  }
}

resource "aws_lb_listener" "listener_good_2" {
  load_balancer_arn = aws_lb.lb_good_2.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}

resource "aws_lb_listener" "listener_good_3" {
  load_balancer_arn = aws_lb.lb_good_3.arn
  port              = 80 #as an int
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}

resource "aws_alb_listener" "listener_good_1" {
  load_balancer_arn = aws_alb.alb_good_1.arn
  port              = 80 #as an int
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
  tags = {
    yor_trace = "faedd1bc-270a-4939-8c2d-f317749894dd"
  }
}

resource "aws_lb_listener" "listener_bad_1" {
  load_balancer_arn = aws_lb.lb_bad_1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "some-action"
  }
}

resource "aws_lb_listener" "listener_bad_2" {
  load_balancer_arn = aws_lb.lb_bad_2.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "some-action"
  }
}

resource "aws_alb_listener" "listener_bad_1" {
  load_balancer_arn = aws_alb.alb_bad_1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "some-action"
  }
  tags = {
    yor_trace = "d092468a-1da9-4d48-8082-3ba88b14b758"
  }
}