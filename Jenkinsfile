pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'trongpham99/golang-jenkins'
        DOCKER_TAG = 'latest'
        DOCKER_HUB_USERNAME = 'trong.phamtranduc@gmail.com'
        DOCKER_HUB_PASSWORD = 'Amg3123456'
        TELEGRAM_BOT_TOKEN = '7939301771:AAEw4T70jSq7d6JzamJJmPNmBigcExKw3Pk'
        TELEGRAM_CHAT_ID = '-1002394833136'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/trongpham99-cpu/golang-jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Run Tests') {
            steps {
                // Replace with actual test commands
                sh 'docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} go test ./...'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                script {
                    // Add deployment commands here
                    sh 'echo "Deploying to Production"'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }

        success {
            sendTelegramMessage("✅ Build #${BUILD_NUMBER} was successful! ✅")
        }

        failure {
            sendTelegramMessage("❌ Build #${BUILD_NUMBER} failed. ❌")
        }
    }
}

def sendTelegramMessage(String message) {
    sh """
    curl -s -X POST https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage \
    -d chat_id=${TELEGRAM_CHAT_ID} \
    -d text="${message}"
    """
}
