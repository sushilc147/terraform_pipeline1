// Jenkinsfile
String credentialsId = 'workingaws'

pipeline {   
  agent {
    node {
      label 'master'
    }  
  }
  stages {
    stage('checkout') {
      steps {
        checkout scm
        sh 'docker pull hashicorp/terraform:light'
      }
    }
    /*stage('init') {
      steps {
        sh 'docker run -w /app -v /awsCredentials:/awsCredentials -v `pwd`:/app hashicorp/terraform:light init'
      }
    } */
   stage('plan') {
	   steps {
			withCredentials([[
				$class: 'AmazonWebServicesCredentialsBinding',
				credentialsId: 'workingaws',
				accessKeyVariable: 'AWS_ACCESS_KEY_ID',
				secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
			]]) {
					sh 'echo `date`'
					sh 'docker run -w /app -v /workingaws:/workingaws -v `pwd`:/app hashicorp/terraform:light init'
					sh 'echo hello'
					sh 'docker run -w /app -v /workingaws:/workingaws -v `pwd`:/app hashicorp/terraform:light plan'
					sh 'terraform init -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'	

			}
			
		}
	}
    /*stage('plan') {
      steps {
        sh 'docker run -w /app -v /awsCredentials:/awsCredentials -v `pwd`:/app hashicorp/terraform:light plan'
      }
    }*/
    stage('approval') {
      options {
        timeout(time: 1, unit: 'HOURS') 
      }
      steps {
        input 'approve the plan to proceed and apply'
      }
    }
    /*stage('apply') {
      steps {
        sh 'docker run -w /app -v /awsCredentials:/awsCredentials -v `pwd`:/app hashicorp/terraform:light apply -auto-approve'
        cleanWs()
      }
    }*/
  }
}
