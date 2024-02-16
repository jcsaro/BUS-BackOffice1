
variable "Environment" {
  description = "AMBIENTE"
  type = string
  }




variable "ApplicationName" {
    description = "application name"
      default = "PORTAL"
      }

variable "location" {
        description = "Location Resource Name"
	  default = "Central US"
	  }

variable "short_location" {
	    description = "Location Resource Name"
	      default = "cus"
	      }