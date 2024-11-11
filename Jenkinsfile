pipeline {
    agent any

    tools {
        go 'golang'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_IMAGE = 'trongpham99/golang-demo-ci-cd'
        GITHUB_CREDENTIALS = credentials('git-secret')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out repo"
                git url: 'https://github.com/trongpham99-cpu/golang-demo-ci-cd.git', branch: 'master'
            }
        }

        stage('Run Docker Build') {
            steps {
                script {
                    echo "Starting Docker build"
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                    echo "Docker built successfully"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "Pushing to Docker Hub"
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                    }
                }
                echo "Done"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}