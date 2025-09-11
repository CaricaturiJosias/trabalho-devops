pipeline {
    agent any
    stages {
        stage('Cleanup') {
            steps {
                sh 'rm -rf trabalho-devops'
            }
        }

        stage('Checkout') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-caricaturi', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    sh '''
                        git clone https://$GIT_USER:$GIT_PASS@github.com/CaricaturiJosias/trabalho-devops.git
                    '''
                }
                dir("trabalho-devops") {
                    sh "pwd"
                    sh 'git status'
                }
                sh 'ls trabalho-devops'
                sh 'docker-compose --version'
            }
        }

        stage('Build') {
            steps {
                sh 'docker-compose -f ./trabalho-devops/docker-compose.yml up -d'
                sh 'docker ps'
            }
        }

        stage('Deliver') {
            steps {
                dir("trabalho-devops") {
                    withCredentials([usernamePassword(credentialsId: 'github-caricaturi', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        sh '''
                            git config user.email "smoke.argacezario@gmail.com"
                            git config user.name "CaricaturiJosias"

                            # Make sure remote has credentials
                            git remote set-url origin https://$GIT_USER:$GIT_PASS@github.com/CaricaturiJosias/trabalho-devops.git

                            git add .
                            git commit -m "Automated commit" || true
                            git push origin HEAD:${BRANCH_NAME}
                        '''
                    }
                }
            }
        }
    }
}
