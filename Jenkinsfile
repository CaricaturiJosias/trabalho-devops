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
                sh '''
                    docker exec -i trabalho-devops-web-1 bash -c '
                        exec 3<>/dev/tcp/127.0.0.1/8200
                        echo -e "GET / HTTP/1.1\\r\\nHost: 127.0.0.1\\r\\nConnection: close\\r\\n\\r\\n" >&3
                        cat <&3
                        exec 3>&-'
                '''
            }
        }

        stage('Deliver') {
            steps {
                dir("trabalho-devops") {
                    withCredentials([usernamePassword(credentialsId: 'github-caricaturi', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        sh '''
                            git config user.email "smoke.argacezario@gmail.com"
                            git config user.name "CaricaturiJosias"

                            git add .
                            git commit -m "Automated commit" || true
                            git push origin HEAD:qa
                        '''
                    }
                }
            }
        }
    }
}
