variable "buses" {
  type        = list(string)
  default     = ["eb1", "eb2"]
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

