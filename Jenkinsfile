pipeline {
    agent any

    stages {

        stage ('Checkout do Código') {

            steps {

                git url: 'https://github.com/rodrigowafonso/learn-terraform-aws-instance.git', branch: 'main'
                sh 'ls -la'
                sh 'pwd'
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

        stage ('Garantindo que o Setup esta OK') {
            environment {

                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                SSH_PRIVATE_KEY=credentials('SSH_PRIVATE_KEY')

            }
            steps {
                script {
                    // Garantindo que as configurações do Python estejam ok
                    sh 'pip install boto3 botocore'
                    // garantindo que o plugin Ansible AWS_EC2 esteja instalado
                    sh 'ansible-galaxy collection install amazon.aws'
                }
            }
        }

        stage ('Realizando um Check no Inventory Dinâmico do Ansible') {
            steps {
                script {
                    sh 'ansible-inventory -i ./inventory_aws_ec2.yml --graph'
                }
            }
        }

        stage ('Provisionando o Webserver NGNIX') {
            steps {
                script {
                    sh 'ansible-playbook -i ./inventory_aws_ec2.yml ./ansible/playblook/nginx.yml'
                }
            }
        }

    }
}