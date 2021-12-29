// def BUILD_NUMBER
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

        stage('Build image') {
            steps {
                // script{
                //     BUILD_NUMBER = 123
                // }
                // sh "echo ${BUILD_NUMBER}"
                // sh "echo \${BUILD_NUMBER}"
                sh 'echo ${BUILD_NUMBER}'
                sh "docker build -t rudstanislav/realworldapp:v${BUILD_NUMBER} ."
                // sh "docker tag rudstanislav/realworldapp:v${BUILD_NUMBER} rudstanislav/realworldapp:latest"
            }
        }

        stage('Push image to DockerHub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub-cred-rudstanislav', url: 'https://index.docker.io/v1/') {
                    
                    // printenv
                    sh '''
                        docker push rudstanislav/realworldapp:v${BUILD_NUMBER}

                     '''

                }
            }
        }
        
        
        stage('Helm install') {
            steps {
                    sh '''
                    curl -LO https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
                    tar -zxvf helm-v3.5.2-linux-amd64.tar.gz
                    sudo mv linux-amd64/helm /usr/local/bin/helm3
                '''
            }
        }
        
        stage('check auth to kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'mykubeconfig']) {
                    sh 'kubectl get pods'
                }
            }
        }
        
        
        stage('clone helm templates') {
            steps {
                sh ' git clone https://github.com/StanislavRud/my-k8s-helm.git '
            }
        }
        
        stage('helm upgrade') {
            steps {
                withKubeConfig(credentialsId: 'mykubeconfig', serverUrl: '') {
                    
                    sh '''
                        cd my-k8s-helm
                        helm upgrade --install app --set container.frontendImage=rudstanislav/realworldapp:v${BUILD_NUMBER} ./
                    '''
                }
            }
        }

        stage('Delete docker image localy') {
            steps {
                sh '''docker rmi rudstanislav/realworldapp:v${BUILD_NUMBER} node:12'''
            }
        }
    }
}