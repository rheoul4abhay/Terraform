resource "aws_iam_user" "admin" {
  name = "marx"
  tags = {
    Description = "Technical Team Lead"
  }
}

resource "aws_iam_policy" "adminUser" {
  name   = "AdminUsers"
  policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "marx-admin-acess" {
  user       = aws_iam_user.admin.name
  policy_arn = aws_iam_policy.adminUser.arn
}