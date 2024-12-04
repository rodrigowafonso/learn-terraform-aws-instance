variable "instance_nome" {
  type        = string
  description = "Define o nome da instância AWS"
  default     = "srv-learn-terraform-aws"
}

variable "instance_nome_canonical" {
  type        = string
  description = "Define o nome da instância AWS"
  default     = "srv-learn-terraform-canonical"
}


variable "instance_tipo" {
  type        = string
  description = "Define o tipo da Instância AWS"
  default     = "t2.micro"
}

variable "regiao_projeto" {
  type        = string
  description = "Define a Região Padrão deste Projeto"
  default     = "us-east-1"
}

variable "sg_terraform_learn" {
  type        = string
  description = "Nome do Security Group Learn Terraform"
  default     = "sg_terraform_learn"
}

variable "path_portal_wordpress" {
    type = string
    description = "Path do Portal Wordpress"
    default = "/etc/nginx/sites-available/wordpress.focopontovirtual.com.br.conf"
  
}