resource "aws_iam_role" "ecs-role" {
  name               = "ecsInstanceRole"
}

resource "aws_iam_policy" "policy" {
    name        = "test-policy"
    description = "A test policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
	
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

