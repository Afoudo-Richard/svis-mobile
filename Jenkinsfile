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

        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "npm install"
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'irrusci/flutter:stable'
                    args '-v ${PWD}/build:/build --workdir /build'
                }
            }
            steps {
                sh 'mvn --version'
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
