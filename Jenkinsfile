pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1' // Change as needed
        TF_VERSION = '1.5.0'     // Update to your desired Terraform version
        AWS_CREDENTIALS = credentials('dev-aws-creds') // Jenkins AWS credentials ID
        TERRAFORM_HOME = '/usr/local/bin/terraform'
    }

    tools {
        terraform 'terraform-50319'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'github-cred', url: 'https://github.com/narendra7306/Solv-India-Infra.git', branch: 'eks'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'dev-aws-creds'
                ]]) {
                    sh '/usr/local/bin/terraform init -input=false'
                }
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