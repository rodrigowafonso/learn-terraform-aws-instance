pipeline {
    agent any

    stages {

        stage ('Checkout do Código') {

            steps {

                git url: 'https://github.com/rodrigowafonso/learn-terraform-aws-instance.git', branch: 'main'
                sh 'ls -la'
                echo 'Repositório Clonado com Sucesso'


            }
        }

        stage ('Provisionando o Ambiente com #Terraform') {

            environment {

                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                AWS_REGION = credentials('AWS_REGION')
                AWS_NAME_BUCKET = credentials('AWS_NAME_BUCKET')
                AWS_TFSTATE_TF_AN = credentials('AWS_TFSTATE_TF_AN')

            }

            steps {

                script {

                    sh 'terraform fmt'
                    sh 'terraform init -backend-config="bucket=$AWS_NAME_BUCKET" -backend-config="key=$AWS_TFSTATE_TF_AN" -backend-config="region=$AWS_REGION"'
                    sh 'terraform plan'
                    sh 'terraform apply --auto-approve'
                    //sh 'terraform destroy --auto-approve'

                }

            }
        }

        stage ('Criando o inventário Dinâmico com #Ansible') {

            environment {
                SSH_PRIVATE_KEY=credentials('SSH_PRIVATE_KEY')
            }

            steps {

                script {

                    // echo 'Listando os recursos com sucesso'
                    // sh 'ansible -i ./ec2.yml --graph'
                    // sh 'ansible --version'
                    // sh 'ansible-playbook --version'
                    // sh 'ansible-galaxy --version'
                    // sh 'ssh-keygen -f /home/ubuntu/.ssh/known_hosts -R 34.227.26.242'
                    sh 'ansible-playbook -i ./ansible/inventario.ini --private-key="$SSH_PRIVATE_KEY" ./ansible/playblook/nginx.yml'
                    sh 'ansible -m command -a "python3 ./ec2.py --list" -i ./ansible/inventario.ini --private-key="$SSH_PRIVATE_KEY"' 

                }

                
            }
        }

    }
}