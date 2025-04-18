pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1' // Change as needed
        TF_VERSION = '1.5.0'     // Update to your desired Terraform version
        AWS_CREDENTIALS = credentials('dev-aws-creds') // Jenkins AWS credentials ID
    }

    tools {
        terraform-50319
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/narendra7306/Solv-India-Infra.git', branch: 'eks'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS_USR}
                export AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS_PSW}
                terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                terraform plan \
                  -var "region=${AWS_REGION}" \
                  -out=tfplan.out
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Approve Terraform Apply?"
                sh 'terraform apply -auto-approve tfplan.out'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}