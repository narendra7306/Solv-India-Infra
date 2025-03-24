pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = credentials('aws-region')
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        EKS_CLUSTER_NAME = credentials('eks-cluster-name') 
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
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=solv-india-infra.tfplan'
                }
            }
        }

       /*  stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve solv-india-infra.tfplan'
                }
            }
        }

        stage('Configure Kubeconfig') {
            steps {
                script {
                    sh 'aws eks --region ${AWS_DEFAULT_REGION} update-kubeconfig --name ${EKS_CLUSTER_NAME}'
                }
            }
        } */

        
    }

    
}
