pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-golang-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Clone repository') {
            steps {
                git branch: 'master', url: 'https://github.com/trongpham99-cpu/golang-jenkins.git'
            }
        }

        stage('Test Docker') {
            steps {
                sh 'docker --version'
            }
        }

        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
        //         }
        //     }
        // }

        // stage('Run Tests') {
        //     steps {
        //         sh 'docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} go test ./...'
        //     }
        // }

        // stage('Push to Docker Hub') {
        //     steps {
        //         withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_HUB_PASSWORD')]) {
        //             sh 'echo $DOCKER_HUB_PASSWORD | docker login -u your-dockerhub-username --password-stdin'
        //             sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
        //         }
        //     }
        // }

        // stage('Deploy') {
        //     steps {
        //         echo 'Deployment stage (customize as needed)'
        //     }
        // }
    }

    post {
        always {
            cleanWs()
        }
    }
}
