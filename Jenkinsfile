pipeline {
   agent any


   tools {
      go 'golang'
   }
   environment {
       DOCKERHUB_CREDENTIALS = credentials('dockerhub')
       DOCKER_IMAGE = 'trongpham99/golang-demo-ci-cd'
       GITHUB_CREDENTIALS = 'git-secret'
   }


   stages{
       stage('Checkout'){
           steps{
               echo "checking out repo"
               git url: 'https://github.com/trongpham99-cpu/golang-demo-ci-cd.git', branch: 'master',
           }
       }
       stage('Build with Go') {
            steps{
               sh 'go --version'
           }
       }

       stage('Run Docker Build'){
           steps{
               script{
                    echo "starting docker build"
                    sh "docker build build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                    echo "docker built successfully"
               }
           }
       }


       stage('push to docker hub'){
           steps{
               echo "pushing to docker hub"
               script{
                   docker.withRegistry('https://index.docker.io/v1/', 'dockerhub'){
                       docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                   }
               }
               echo "done"
           }
       }
   }


   post {
       always{
           cleanWs()
       }
   }
}
