variable "password" {
  type = string
  sensitive = true

}

variable "user" {
  type = string
  sensitive = true
}

variable "student" {
  default = "xander"
}

variable "folder_path" {
  default = "Xander-Petit"
}

variable "vm_hostname" {
  default = "webserver"
}

variable "vm_pwd" {
  type = string
  sensitive = true
}