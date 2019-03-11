pipeline {
  environment {
    registry = "ratankb/uss-enterprise"
    registryCredential = 'DockerHubID'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/ratanbekal/StarFleet-1b'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build(registry + ":$BUILD_NUMBER" , "./docker/uss-enterprise")
        }
      }
    }
    stage('Docker Repo Push') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('ECR Push') {
      steps{
         script {
            //configure registry
            docker.withRegistry('https://044661814431.dkr.ecr.ap-south-1.amazonaws.com', 'ecr:ap-south-1:aab5d928-39d8-4ce2-92af-ce9635a361e7') {
           
            //build image
            def customImage = docker.build("uss-enterprise:latest")
             
            //push image
            customImage.push()
        }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
       }
    }
  }
}
