variable "name_prefix" {
  description = "Prefijo para nombres de recursos ECS"
  type        = string
}

variable "cpu" {
  description = "CPU para el ECS task"
  type        = string
  default     = "512"
}

variable "memory" {
  description = "Memoria para el ECS task"
  type        = string
  default     = "1024"
}

variable "ecr_repo_url" {
  description = "URL de la imagen del contenedor en ECR"
  type        = string
}

variable "aws_region" {
  description = "Región AWS"
  type        = string
}