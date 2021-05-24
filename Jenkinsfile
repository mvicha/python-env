pipeline {
  agent any

  stages {
    stage('Clean') {
      steps {
        deleteDir()
        sh 'printenv'
      }
    }
  
    stage('Checkout') {
      steps {
        echo 'Checkout SCM'
        checkout scm
      }
    }

    stage('Build docker image') {
      steps {
        sh 'docker image build -t 750489264097.dkr.ecr.us-east-1.amazonaws.com/mvicha-ecr-python-env:latest .'
        sh 'docker image push 750489264097.dkr.ecr.us-east-1.amazonaws.com/mvicha-ecr-python-env:latest'
      }
    }
  }
}


