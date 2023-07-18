variable "buses" {
  type        = list(string)
  default     = ["arn:aws:events:us-east-1:768827764971:event-bus/eb1", "arn:aws:events:us-east-1:768827764971:event-bus/eb2"]
  description = "Name of the first EventBus"
}

variable "centralEB" {
  type        = string
  default     = "centralEB"
  description = "Name of central EventBus"
}

variable "names" {
  type  = set(string)
  default = [ "eb1","eb2" ]
  
}

