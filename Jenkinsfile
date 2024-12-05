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
    }
}