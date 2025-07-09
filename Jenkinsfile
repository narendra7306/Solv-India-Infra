pipeline {
    agent any

<<<<<<< Updated upstream
    parameters {
        choice(name: 'ACTION', choices: ['init', 'plan', 'apply', 'destroy'], description: 'Choose Terraform operation to perform')
    }


=======
>>>>>>> Stashed changes
    environment {
        AWS_REGION = 'ap-south-1' // Change as needed
        TF_VERSION = '1.5.0'     // Update to your desired Terraform version
        AWS_CREDENTIALS = credentials('dev-aws-creds') // Jenkins AWS credentials ID
<<<<<<< Updated upstream
        TERRAFORM_HOME = '/usr/bin/terraform'
    }

    tools {
        terraform 'terraform-50319'
=======
    }

    tools {
        terraform-50319
>>>>>>> Stashed changes
    }

    stages {
        stage('Checkout Code') {
            steps {
<<<<<<< Updated upstream
                git credentialsId: 'github-cred', url: 'https://github.com/narendra7306/Solv-India-Infra.git', branch: 'eks'
=======
                git url: 'https://github.com/narendra7306/Solv-India-Infra.git', branch: 'eks'
>>>>>>> Stashed changes
            }
        }

        stage('Terraform Init') {

            when {
                expression { params.ACTION == 'init' || params.ACTION == 'plan' || params.ACTION == 'apply' || params.ACTION == 'destroy' }
            }

            steps {
<<<<<<< Updated upstream
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'dev-aws-creds'
                ]]) {
                    sh "set -ex && ${TERRAFORM_HOME} init -input=false"
                }
=======
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS_USR}
                export AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS_PSW}
                terraform init
                '''
>>>>>>> Stashed changes
            }
        }

        stage('Terraform Validate') {
<<<<<<< Updated upstream

            when {
                expression { params.ACTION == 'plan' || params.ACTION == 'apply' }
            }

=======
>>>>>>> Stashed changes
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
<<<<<<< Updated upstream

            when {
                expression { params.ACTION == 'plan' }
            }

=======
>>>>>>> Stashed changes
            steps {
                sh '''
                terraform plan \
                  -var "region=${AWS_REGION}" \
                  -out=tfplan.out
                '''
            }
        }

        stage('Terraform Apply') {
<<<<<<< Updated upstream

            when {
                expression { params.ACTION == 'apply' }
            }

            steps {
                sh '''
                terraform plan -var "region=${AWS_REGION}" -out=tfplan.out 
                terraform apply -auto-approve tfplan.out
                '''

            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                sh 'terraform destroy -var "region=${AWS_REGION}" -auto-approve'
=======
            steps {
                input message: "Approve Terraform Apply?"
                sh 'terraform apply -auto-approve tfplan.out'
>>>>>>> Stashed changes
            }
        }
    }

<<<<<<< Updated upstream
=======
    post {
        always {
            cleanWs()
        }
    }
>>>>>>> Stashed changes
}