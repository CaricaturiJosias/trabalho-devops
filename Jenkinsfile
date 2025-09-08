pipeline {
    agent any
    stages {
        // Limpar o que foi baixado na ultima build
        stage('Cleanup') {
            steps {
                sh 'rm -rf trabalho-devops'
            }
        }
        stage('Checkout') {
            steps {
                sh 'git clone https://github.com/CaricaturiJosias/trabalho-devops.git'
                dir("trabalho-devops") {
                    sh "pwd"
                    sh 'git status'
                }
                sh 'ls trabalho-devops'
                sh 'docker-compose --version'
            }
        }
        // Builda o código em si
        stage('Build') {
            steps {
                sh 'docker-compose -f ./trabalho-devops/docker-compose.yml up -d'
                sh 'docker ps'
            }
        }
        // Faz o push para o repo
        stage('Deliver') {
            steps {
                dir("trabalho-devops") {
                    sh "git branch -u main/${env.BRANCH_NAME}"
                    sh "git push"
                }
            }
        }
    }
}
