pipeline {
    agent any

    parameters {

        // Choice parameter for Git branches
        choice(name: 'GIT_BRANCH', choices: ['private-subnet', 'main', 'dev'], description: 'Git branch to checkout')
        
       // Terraform Version (String Parameter)
       string(name: 'TERRAFORM_VERSION', defaultValue: '1.11.2', description: 'Terraform version to use')

        // Terraform Workspace (String Parameter)
        string(name: 'TERRAFORM_WORKSPACE', defaultValue: 'dev-env', description: 'Terraform workspace to use')

        // Plan file name (String Parameter)
        string(name: 'TERRAFORM_PLAN_FILE', defaultValue: 'solv-india-infra.tfplan', description: 'Terraform Plan file name')

        // Boolean parameter to decide whether to apply the Terraform plan
        booleanParam(name: 'APPLY_PLAN', defaultValue: true, description: 'Apply Terraform Plan after creation')

    }

    environment {
        TERRAFORM_HOME = "/usr/local/bin/terraform/${params.TERRAFORM_VERSION}"
        AWS_DEFAULT_REGION = 'ap-south-1' 
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your Terraform configuration repository
                checkout scmGit(branches: [[name: "*/${params.GIT_BRANCH}"]], extensions: [], userRemoteConfigs: [[credentialsId: 'github-creds', url: 'https://github.com/narendra7306/Solv-India-Infra.git']])
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
                        sh "set -ex && ${TERRAFORM_HOME} init -input=false"
                    }
                }
            }
        }


        stage('Terraform Workspace') {
            steps {
                script {
                    // Select or create the Terraform workspace
                    sh "${TERRAFORM_HOME} workspace select ${params.TERRAFORM_WORKSPACE} || ${TERRAFORM_HOME} workspace new ${params.TERRAFORM_WORKSPACE}"
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
                        // Run Terraform plan with a custom plan file name
                        def planCmd = "${TERRAFORM_HOME} plan -out=${params.TERRAFORM_PLAN_FILE}"
                    }
                    sh "set -ex && ${planCmd}"
                }
            }
        }


        stage('Terraform Apply') {
            when {
                expression { return params.APPLY_PLAN }
            }
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                      credentialsId: 'aws-credentials', 
                                      accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                      secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        // Apply the Terraform plan if APPLY_PLAN is true
                        sh "set -ex && ${TERRAFORM_HOME} apply -auto-approve ${params.TERRAFORM_PLAN_FILE}"
                    }
                }
            }
        }
        
    }

    
}
