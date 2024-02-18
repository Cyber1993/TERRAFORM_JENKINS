provider "aws" {
  region = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket"
  tags = {
    Name = "My Terraform Bucket"
  }
}

resource "aws_s3_bucket_object" "example_object_folder" {
  bucket = aws_s3_bucket.my_bucket.id
  key = "myfolder-test/"
  content = ""
  tags = {
    Name = "My Folder"
  }
}

resource "aws_s3_bucket_object" "example_object_image" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "myfolder-test/devops.jpg"
  source = "https://github.com/Cyber1993/TERRAFORM_JENKINS/blob/main/S3/devops.jpg"
  tags = {
    Name = "devops.jpg Image"
  }
}