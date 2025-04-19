pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['init', 'plan', 'apply', 'destroy'], description: 'Choose Terraform operation to perform')
    }


    environment {
        AWS_REGION = 'ap-south-1' // Change as needed
        TF_VERSION = '1.5.0'     // Update to your desired Terraform version
        AWS_CREDENTIALS = credentials('dev-aws-creds') // Jenkins AWS credentials ID
        TERRAFORM_HOME = '/usr/bin/terraform'
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

            when {
                expression { params.ACTION == 'init' || params.ACTION == 'plan' || params.ACTION == 'apply' || params.ACTION == 'destroy' }
            }

            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'dev-aws-creds'
                ]]) {
                    sh "set -ex && ${TERRAFORM_HOME} init -input=false"
                }
            }
        }

        stage('Terraform Validate') {

            when {
                expression { params.ACTION == 'plan' || params.ACTION == 'apply' }
            }

            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {

            when {
                expression { params.ACTION == 'plan' }
            }

            steps {
                sh '''
                terraform plan \
                  -var "region=${AWS_REGION}" \
                  -out=tfplan.out
                '''
            }
        }

        stage('Terraform Apply') {

            when {
                expression { params.ACTION == 'apply' }
            }

            steps {
                input message: "Approve Terraform Apply?"
                sh 'terraform apply -auto-approve tfplan.out'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                input message: "Approve Terraform Destroy?"
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}