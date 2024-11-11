pipeline {
    agent any
    stages {
        stage('Test Docker') {
            steps {
                script {
                    sh "docker --version"
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.build("golang-cicd-demo:latest")
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    docker.image("golang-cicd-demo:latest").inside {
                        sh "go test ./..."
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Thêm các bước triển khai ở đây nếu cần
            }
        }
    }
}
