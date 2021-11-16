resource "aws_s3_bucket" "terraform_state" {
 bucket = "ajesh-abin-terraform-state"
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
 name           = "terraform_state_db"
 read_capacity  = 20
 write_capacity = 20
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}

terraform {
 backend "s3" {
   bucket         = "ajesh-abin-terraform-state"
   key            = "state/terraform.tfstate"
   region         = "ap-south-1"
   dynamodb_table = "terraform_state_db"
 }
}
