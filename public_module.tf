module "learn_terraform" {
  source  = "https://github.com/hashicorp/learn-terraform-provision-eks-cluster.git"
  version = "1.16.0"

  name = "s3-bucket"
}

resource "aws_s3_bucket" "destination" {
  bucket = "tf-test-bucket-destination-12345"
  versioning {
    enabled = var.enabled
  }
  tags = {
    yor_trace = "353ce78b-0b57-4f8d-9eae-61a829c8bd8e"
  }
}