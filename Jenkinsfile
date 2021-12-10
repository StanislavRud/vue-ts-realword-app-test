pipeline {
    agent { 
        any 
    }

    stages {
        stage('Build image') {
            steps {
                docker build -t frontend .
            }
        }
    }
}
