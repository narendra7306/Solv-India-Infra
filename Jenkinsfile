pipeline {
    agent any

    environment {
        TERRAFORM_HOME = '/usr/local/bin/terraform'
        AWS_DEFAULT_REGION = 'ap-south-1' 
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your Terraform configuration repository
                checkout scmGit(branches: [[name: '*/private-subnet']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-creds', url: 'https://github.com/narendra7306/Solv-India-Infra.git']])
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                      credentialsId: 'aws-credentials',  // The ID of the Jenkins AWS credentials
                                      accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                      secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        // Now you can use the AWS environment variables in your Terraform commands
                        sh "set -ex && ${TERRAFORM_HOME} init"
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                      credentialsId: 'aws-credentials',  // The ID of the Jenkins AWS credentials
                                      accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                      secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        // Now you can use the AWS environment variables in your Terraform commands
                        sh "${TERRAFORM_HOME} plan -out=solv-india-infra.tfplan"
                    }
                }
            }
        }
        
    }

    
}
