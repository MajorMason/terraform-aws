#AWS S3 buckets combine both Stoarge Account and Storage Container roles into one resource
#The only "separator" is a forward slash to create psuedo folders as desired
#Our S3 bucket used for storing our state & tfvars files
resource "aws_s3_bucket" "terraform_s3" {
    bucket = "${var.environment}-terraform-s3"

    tags = {
      environment = "${var.environment}"
    }
}
