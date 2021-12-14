pipeline {
    agent  any 

    parameters {
        choice choices: [ 'BRANCH', 'TAG', 'BRANCH_and_TAG', 'REVISION'], description: '', name: 'TYPE'

        gitParameter(   branch: '',
                        branchFilter: '.*)',
                        defaultValue: 'main',
                        description: '',
                        name: 'BRANCH',
                        quickFilterEnabled: false,
                        selectedValue: 'NONE',
                        sortMode: 'NONE',
                        // tagFilter: '*',
                        type: 'PT_BRANCH',
                        useRepository: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git')
        gitParameter(   branch: '',
                        branchFilter: '.*',
                        defaultValue: 'main',
                        description: '',
                        name: 'TAG',
                        quickFilterEnabled: false,
                        selectedValue: 'NONE',
                        sortMode: 'NONE',
                        // tagFilter: '*',
                        type: 'PT_TAG',
                        useRepository: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git')
        gitParameter(   branch: '',
                        branchFilter: '.*',
                        defaultValue: 'main',
                        description: '',
                        name: 'BRANCH_and_TAG',
                        quickFilterEnabled: false,
                        selectedValue: 'NONE',
                        sortMode: 'NONE',
                        // tagFilter: '*',
                        type: 'PT_BRANCH_and_TAG',
                        useRepository: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git')
        gitParameter (  branch: '', 
                        branchFilter: '.*', 
                        defaultValue: 'main', 
                        description: '', 
                        name: 'REVISION', 
                        quickFilterEnabled: false, 
                        selectedValue: 'NONE', 
                        sortMode: 'NONE', 
                        // tagFilter: '*', 
                        type: 'PT_REVISION', 
                        useRepository: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git')
    }

    stages {
        
        stage('Delete workspace before build starts') {
            steps {
                echo 'Deleting workspace'
                deleteDir()
            }
        }

        stage('Print Enviroment') {
            steps {
                sh '''
                    echo Selected Type of checkout: $TYPE
                    echo Selected Branch name: $BRANCH
                    echo Selected Tag name: $TAG
                    echo Selected Branch and Tag name: $BRANCH_and_TAG
                    echo Selected Revision name: $REVISION
                '''
            }
        }

        stage('Checkout') {
            parallel {
                stage('BRANCH') {
                    when {
                        expression { params.TYPE == 'BRANCH'}
                    } 
                    steps{
                        checkout(
                            [$class: 'GitSCM', 
                            branches: [[name: "${params.BRANCH}"]], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [],
                            submoduleCfg: [], userRemoteConfigs: 
                            [[credentialsId: 'github-rudstanislav-cred', 
                            url: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git']]]
                            ) 
                        }
                }
                stage('TAG') {
                    when {
                        expression { params.TYPE == 'TAG'}
                    } 
                    steps{
                        checkout(
                            [$class: 'GitSCM', 
                            branches: [[name: "${params.TAG}"]], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [],
                            submoduleCfg: [], userRemoteConfigs: 
                            [[credentialsId: 'github-rudstanislav-cred',
                            url: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git']]]
                            ) 
                        }
                }
                stage('BRANCH_and_TAG') {
                    when {
                        expression { params.TYPE == 'BRANCH_and_TAG'}
                    } 
                    steps{
                        checkout(
                            [$class: 'GitSCM', 
                            branches: [[name: "${params.BRANCH_and_TAG}"]], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [],
                            submoduleCfg: [], userRemoteConfigs: 
                            [[credentialsId: 'github-rudstanislav-cred',
                            url: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git']]]
                            ) 
                        }
                }
                stage('REVISION') {
                    when {
                        expression { params.TYPE == 'REVISION'}
                    } 
                    steps{
                        checkout(
                            [$class: 'GitSCM', 
                            branches: [[name: "${params.REVISION}"]], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [],
                            submoduleCfg: [], userRemoteConfigs: 
                            [[credentialsId: 'github-rudstanislav-cred',
                            url: 'git@github.com:StanislavRud/vue-ts-realword-app-test.git']]]
                            ) 
                        }
                }

            }
            

        }

        //testing webhooks


        stage('Build image') {
            steps {
                
                sh "docker build -t rudstanislav/realworldapp:v4 ."
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

        stage('Delete docker image localy') {
            steps {
                sh 'docker rmi rudstanislav/realworldapp:v4 node:12'
            }
        }

    }
}