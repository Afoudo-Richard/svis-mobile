pipeline {
    environment {
        def scannerHome = tool 'sonarqube'
    }
    agent any

    options {
        gitLabConnection('gitlab')
        gitlabCommitStatus('Jenkins')
        // gitlabStages(enabled: true)
    }

    triggers {
        gitlab(triggerOnPush: true, triggerOnMergeRequest: true, branchFilterType: 'All')
    }

    stages {

        /*stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }*/
        stage('Build') {
            agent {
                docker {
                    image 'cirrusci/flutter:stable'
//                    args '-v ${PWD}/build:/build -v ${HOME}/.config/flutter/:/.config/flutter/ --workdir /build'
                }
            }
            steps {
                sh '/home/cirrus/sdks/flutter/bin/flutter --version'
                sh '/home/cirrus/sdks/flutter/bin/flutter build apk'
            }
        }
        stage("Acceptance test") {
            steps {
                sh "echo 'Acceptance test'"

            }
        }
    }
    post {
        always {
            sh "echo 'Acceptance test'"
            sh "docker image prune -a -f --filter label=stage=output"
        }
    }
}
