pipeline {
    agent any

  environment {
      tf_version = '0.11.7'
      config_path = 'prasadambasaveswar/tfs3sns'
    }

    parameters {
        booleanParam(defaultValue: false, description: 'Set Value to True to Initiate Destroy Stage', name: 'destroy')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }

    stages {
        stage('TerraRising') {
            steps {
                 load "${config_path}/parameters.groovy"

                 sh '''#!/bin/bash -l

                 # Setting up Terraform in build environment
                 echo "Downloading Terraform ${tf_version}"
                 wget -q https://releases.hashicorp.com/terraform/${tf_version}/terraform_${tf_version}_linux_amd64.zip
                 unzip -qo terraform_${tf_version}_linux_amd64.zip
                 chmod 755 terraform
                 ./terraform --version

                 # Remove previous terraform modules
                 rm -rf .terraform

                 # Setups up Terraform state file and source modules
                 set -x #Turns on screen outputs
                 ./terraform init ./$tf_path

                 '''
            }
        }
        stage('TerraPlanning') {
            when {
                expression { !params.destroy }
            }
            steps {
                echo "Planning $account_moniker in ... $aws_account / $aws_region"

                sh '''#!/bin/bash -l


                  ####
                  # Placeholder if/when we have terraform preinstalled on build agent
                  ####
                  #export PATH=~/TerraformBuild/${JOB_NAME}-${BUILD_NUMBER}-terrabin:$PATH

                  echo "Terraform Plan of $account_moniker Build in ... $aws_account / $aws_region"
                  set -x
                  ./terraform plan -var-file="./${tf_path}/${tf_vars}" -out=current.tfplan ./$tf_path

                  '''

            }
        }

        stage('TerraDestroy') {
            when {
                expression { params.destroy }
            }
            steps {
                echo "Terraform Destroy of $account_moniker in ... $aws_account / $aws_region"

                sh '''#!/bin/bash -l

                  ####
                  # Placeholder if/when we have terraform preinstalled on build agent
                  ####
                  #export PATH=~/TerraformBuild/${JOB_NAME}-${BUILD_NUMBER}-terrabin:$PATH

                  echo "Terraform Destroy of $account_moniker in ... $aws_account / $aws_region"
                  set -x
                  ./terraform destroy -var-file="./${tf_path}/${tf_vars}" -auto-approve ./$tf_path

                  '''

            }
        }

        stage("ValidateBeforeDeploy") {
            when {
                expression { !params.destroy }
            }
            steps {
                input 'Are you sure? Review the output of the previous step before proceeding!'
            }
        }

        stage('TerraApplying') {
            when {
                expression { !params.destroy }
            }
            steps {
                sh '''#!/bin/bash -l

                  ####
                  # Placeholder if/when we have terraform preinstalled on build agent
                  ####
                  #export PATH=~/TerraformBuild/${JOB_NAME}-${BUILD_NUMBER}-terrabin:$PATH

                  echo "Terraform Apply of $account_moniker Build in ... $aws_account / $aws_region"
                  set +x
                  ./terraform apply current.tfplan

                  '''
            }
        }
    }
}
