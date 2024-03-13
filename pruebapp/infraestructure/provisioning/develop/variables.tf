variable "short_company" {
  type        = string
  description = "Short Name for Company"
  default     = "OX"
}
variable "short_cloud" {
  type        = string
  description = "Short Name for Cloud Environment"
  default     = "Z"
}
variable "short_env" {
  type        = string
  description = "Short Name for Cloud Environment"
  default     = "D"
}

variable "short_project" {
  type        = string
  description = "Short Name for Cloud Environment"
  default     = "OXH"
}
variable "environment" {
  description = "AMBIENTE"
  type        = string
}

variable "location" {
  description = "Location Resource Name"

}

variable "rg_name" {
  description = "Resource Group Name"

}