pipeline {
    agent any
    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'branch to be pushed to main', trim: true)
        
        string(name: 'git_name', defaultValue: 'Someone', description: 'Git user for push', trim: true)
        
        string(name: 'git_email', defaultValue: 'someone@gmail.com', description: 'Git email for push', trim: true)
    }
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
                    sh "git checkout ${params.BRANCH}"
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
                    sh "git config user.name ${params.git_name}"
                    sh "git config user.email ${params.git_email}"
                    sh "git push --set-upstream origin ${params.BRANCH}"
                }
            }
        }
    }
}
