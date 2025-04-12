variable "name_prefix" {
  description = "Prefijo para nombrar recursos"
  type        = string
}

variable "ecr_repo_url" {
  description = "URL del repositorio ECR con la imagen del runner"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-2"
}

variable "cpu" {
  description = "Cantidad de CPU para la tarea ECS"
  type        = string
  default     = "512"
}

variable "memory" {
  description = "Memoria para la tarea ECS"
  type        = string
  default     = "1024"
}
