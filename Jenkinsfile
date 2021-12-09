pipeline {
    agent {
        dockerfile true
    }
    stages ('Cloning Git') {
       steps {
           git 'https://github.com/StanislavRud/vue-ts-realword-app-test.git' 
       }
    }

    stages ('Build image') {
        steps {
            docker build .
        }
    }
}