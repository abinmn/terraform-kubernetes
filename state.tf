terraform {
 backend "s3" {
   bucket         = "tf-state-mn"
   key            = "state/terraform.tfstate"
   region         = "ap-south-1"
   dynamodb_table = "tf-state-db-mn"
 }
}
