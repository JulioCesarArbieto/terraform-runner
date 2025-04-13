# Terraform Runner en AWS ECS con CodePipeline y DevSecOps

Este proyecto despliega una arquitectura serverless para ejecutar Terraform dentro de un contenedor en ECS, orquestado por CodePipeline con análisis de seguridad, estimación de costos y aprobación manual antes de aplicar los cambios. Está diseñado para integrarse fácilmente con GitHub y automatizar despliegues seguros de infraestructura como código.

## 🧱 Arquitectura

La solución está compuesta por los siguientes módulos:

- **ECR**: Repositorio privado para almacenar la imagen del runner.
- **S3 Backend**: Almacena el estado remoto de Terraform.
- **ECS Fargate**: Ejecuta Terraform en contenedores aislados.
- **CodePipeline**: Orquestra los stages del proceso.
- **CodeBuild**: Ejecuta fases de análisis y despliegue.
- **SNS**: Envía notificaciones por correo.
- **EventBridge**: Responde a eventos del pipeline.
- **Herramientas de seguridad**: Ejecuta `tflint`, `checkov` e `infracost`.

## 📁 Estructura del proyecto

```
terraform-runner/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── buildspec-security.yml
├── buildspec-deploy.yml
├── README.md
├── modules/
│   ├── codepipeline/
│   ├── ecs_task/
│   ├── ecr/
│   ├── s3_backend/
│   ├── sns_notifications/
│   ├── eventbridge/
│   └── security_tools/
```

## 🚀 Flujo CI/CD

1. **Source**: Extrae el código desde GitHub.
2. **SecurityChecks**: Corre herramientas como `tflint`, `checkov`, e `infracost`.
3. **Approval**: Requiere una aprobación manual vía consola de AWS.
4. **Deploy**: Ejecuta `terraform plan` y `terraform apply` en ECS.

## 🔐 Seguridad y Validaciones

El stage de seguridad se define en `buildspec-security.yml`, e incluye:

- [TFLint](https://github.com/terraform-linters/tflint): Linter de Terraform.
- [Checkov](https://github.com/bridgecrewio/checkov): Scanner de seguridad.
- [Infracost](https://www.infracost.io/): Estimación de costos.

## 📤 Notificaciones

Se configura un topic SNS para enviar correos electrónicos en caso de fallos o ejecuciones exitosas del pipeline.

## 🔧 Variables necesarias

```hcl
variable "notification_email"   # Correo para notificaciones
variable "pipeline_role_arn"    # Rol IAM para CodePipeline
variable "github_owner"         # Propietario del repo GitHub
variable "github_repo"          # Nombre del repo GitHub
variable "github_branch"        # Rama del repo
variable "github_token"         # Token OAuth GitHub (secreto)
variable "security_codebuild_project"
variable "deploy_codebuild_project"
```

## 📦 Buildspecs

### buildspec-security.yml

Define instalación de herramientas de análisis y su ejecución automática.

### buildspec-deploy.yml

Inicializa Terraform y aplica el plan dentro de ECS, usando credenciales IAM del contenedor.

## ✅ Cómo desplegar

1. Editar `terraform.tfvars` con tus valores.
2. Ejecutar `terraform init && terraform apply`.
3. Confirmar suscripción al correo SNS.
4. Validar ejecución automática desde GitHub.

---

Este pipeline te da control total sobre los despliegues Terraform en AWS, asegurando seguridad, visibilidad y trazabilidad. Ideal para **equipos DevSecOps** y **auditorías regulatorias**.

---


PASOS:
1-
cd .\terraform-runner\modules\infra_core
terraform init
terraform plan
terrafom apply -auto-approve

paso 2:
cd .\terraform-runner\
terraform init
terraform plan
terrafom apply -auto-approve
