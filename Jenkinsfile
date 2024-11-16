pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'trongpham99/golang-jenkins'
        DOCKER_TAG = 'latest'
        TELEGRAM_BOT_TOKEN = credentials('TELEGRAM_BOT_TOKEN')
        TELEGRAM_CHAT_ID = credentials('TELEGRAM_CHAT_ID')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/trongpham99-cpu/golang-jenkins.git'
            }
        }

        stage('Prepare Environment') {
            steps {
                echo 'Cleaning up old Docker images and containers...'
                sh "docker rmi -f ${DOCKER_IMAGE}:${DOCKER_TAG} || echo 'No existing image to remove'"
                sh 'docker container prune -f || echo "No containers to remove"'
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
                echo 'Running tests...'
                sh 'docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} go test ./...'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Deploy to DEV') {
            steps {
                echo 'Deploying to DEV environment...'
                sh 'docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}'
                sh 'docker container stop server-golang || echo "Container not running"'
                sh 'docker container rm server-golang || echo "Container does not exist"'
                sh 'docker network create dev || echo "Network already exists"'
                sh 'docker container run -d --name server-golang -p 4000:3000 --network dev ${DOCKER_IMAGE}:${DOCKER_TAG}'
            }
        }
    }

    post {
        always {
            cleanWs()
        }

        success {
            sendTelegramMessage("✅ Production build #${BUILD_NUMBER} succeeded! ✅")
        }

        failure {
            sendTelegramMessage("❌ Production build #${BUILD_NUMBER} failed. ❌")
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
