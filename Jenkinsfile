pipeline {
    agent { dockerfile true }

    stages {
        stage('Cloning Git') {
            steps {
                git 'https://github.com/StanislavRud/vue-ts-realword-app-test.git'
            }
        }

        stage('Build image') {
            steps {
                docker build -t frontend:latest .
            }
        }
    }
}
