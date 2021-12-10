pipeline {
    agent  any 

    stages {
        stage('Checkout repository') {
            steps{
                git url:'https://github.com/StanislavRud/vue-ts-realword-app-test.git', branch:'main'
            }
        }
        
        stage('Build image') {
            steps {
                scripts {
                    myapp = docker.build("stanislav/frontend:${env.BUILD_ID}")
                }
                
                //sh "docker build -t stanislav/frontend:latest ."
            }
        }
    }
}