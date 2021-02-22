

//Variable required for content catalog to select terraform version
variable "TF_VERSION" {
  default = "0.12"
  description = "terraform engine version to be used in schematics"
}

terraform {
  required_version = ">= 0.12"
}
