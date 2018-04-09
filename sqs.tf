resource "aws_sqs_queue" "terraform_queue" {
  name                      = "tf-webapp-sqs"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400

  tags {
    Name = "tf-webapp-sqs"
  }
}
