pipeline {
    agent  any 

    stages {
        
        stage('Delete workspace before build starts') {
            steps {
                echo 'Deleting workspace'
                deleteDir()
            }
        }


        stage('Checkout repository') {
            steps{
                git branch:'main',
                    url: 'https://github.com/StanislavRud/vue-ts-realword-app-test.git'
                }
        }

        stage('Test') {
            steps {
                sh "ls -la"
            }
        }
        
        stage('Build image') {
            steps {
                // scripts {
                //     myapp = docker.build("stanislav/frontend:${env.BUILD_ID}")
                // }
                
                sh "docker build -t stanislav/frontend:v4 ."
            }
        }

        stage('Push image to DockerHub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub-cred-rudstanislav', url: 'https://index.docker.io/v1/') {
                    
                    sh '''
                        docker push rudstanislav/realworldapp:v4
                     '''

                }
            }
        }

    }
}