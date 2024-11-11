pipeline {
    agent any
    stages {
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
                // Add deployment steps here if needed
            }
        }
    }
}
