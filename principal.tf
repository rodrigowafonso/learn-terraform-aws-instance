data "aws_ami" "aim_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}

resource "aws_security_group" "sg_learn_terraform" {
  name = var.sg_terraform_learn

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

data "aws_key_pair" "key_devops_rodrigoafonso" {
  key_name           = "key_devops_rodrigoafonso"
  include_public_key = true

}

resource "aws_instance" "srv_ubuntu_canonical" {
  ami                    = data.aws_ami.aim_ubuntu.id
  instance_type          = var.instance_tipo
  vpc_security_group_ids = [aws_security_group.sg_learn_terraform.id]
  key_name               = data.aws_key_pair.key_devops_rodrigoafonso.key_name

#   user_data = <<-EOF
#     #!/bin/bash
#     apt update
#     apt install -y software-properties-common
#     add-apt-repository -y ppa:ondrej/php
#     apt update
#     apt install --no-install-recommends php8.1 php8.1-fpm php8.1-mysql php8.1-xml php8.1-mbstring php8.1-curl php8.1-gd php8.1-bcmath php8.1-cgi php8.1-zip php8.1-xml -y
#     apt install -y mysql-server
#     apt install -y mysql-client-core-8.0
#     apt install -y nginx
    
#     cd /tmp
#     wget -c http://wordpress.org/latest.tar.gz
#     tar -xzvf latest.tar.gz
    
#     mv wordpress /var/www/html/wordpress.focopontovirtual.com.br
    
#     find /var/www/html/wordpress.focopontovirtual.com.br/ -type f ! -perm 644 -exec chmod 644 {} \;
#     find /var/www/html/wordpress.focopontovirtual.com.br/ -type d ! -perm 755 -exec chmod 755 {} \;
    
#     chown -R www-data:www-data /var/www/html/wordpress.focopontovirtual.com.br/
    
#     cp -p /etc/nginx/sites-available/default ${var.path_portal_wordpress}
    
#     sed -i 's/80/8080/g' ${var.path_portal_wordpress}
#     sed -i 's/\/var\/www\/html;/\/var\/www\/html\/wordpress.focopontovirtual.com.br;/g' ${var.path_portal_wordpress}
#     sed -i -e 's/index.html/index.php &/' ${var.path_portal_wordpress}
#     sed -i 's/# server_tokens off;/server_tokens on;/g' /etc/nginx/nginx.conf
#     sed -i '56s/#//;57s/#//;60s/#//;63s/#//' ${var.path_portal_wordpress}
#     sed -i 's/\/var\/run\/php\/php7.4-fpm.sock/\/run\/php\/php8.1-fpm.sock/g' ${var.path_portal_wordpress}

#     cd /etc/nginx/sites-enabled
#     ln -s ../sites-available/wordpress.focopontovirtual.com.br.conf .
#     nginx -t

#     systemctl restart nginx

#     mysql -e "create database rwa_wordpress;"
#     mysql -e "create user 'rwa_devops'@'localhost' identified by 'rwa_wordpress';"
#     mysql -e "grant all privileges on rwa_wordpress.* to 'rwa_devops'@'localhost';"
#     mysql -e "flush privileges;"

#     systemctl restart mysql

#     EOF

  tags = {
    Name = var.instance_nome_canonical
  }

 
  provisioner "local-exec" {

    command = <<EOT

        echo "[WERSERVER]" > inventario.ini
        echo "${aws_instance.srv_ubuntu_canonical.name} ansible_host=${aws_instance.srv_ubuntu_canonical.public_ip} ansible_user=ubuntu" >> inventario.ini

    EOT
    
  }
}