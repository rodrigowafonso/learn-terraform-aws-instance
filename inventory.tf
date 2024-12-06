resource "local_file" "ansible_inventario" {
    
    content = <<EOF
        [webservers]
        ${aws_instance.srv_ubuntu_canonical.tags[var.instance_nome_canonical]} ansible_host=${aws_instance.srv_ubuntu_canonical.public_ip} ansible_user=ubuntu 
    EOF 
    
    filename = "inventory.ini"
    file_permission = "0600"
    }
 
