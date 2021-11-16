resource "aws_s3_bucket" "terraform_state" {
  bucket = var.TERRAFORM_STATE_BUCKET
  acl    = "private"

  versioning {
    enabled = true
  }

}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state_db" {
  name           = var.TERRAFORM_STATE_DB
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}