pipeline {
    agent  any 

    stages {
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
                
                sh "docker build -t stanislav/frontend:latest ."
            }
        }

        // stage('Push image') {
        //     steps {

        //     }
        // }

    }
}