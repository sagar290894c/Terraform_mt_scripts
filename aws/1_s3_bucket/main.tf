resource "aws_s3_bucket" "resgrpwaste" {
    bucket = "myfirstbucket"
    tags = {
        Environment = "Dev"
  }
  
}