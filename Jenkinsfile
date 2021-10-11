pipeline {
    environment {
        def scannerHome = tool 'sonarqube'
    }
    agent {
        docker {
            image 'cirrusci/flutter:stable'
            args '-u="root" -v ${PWD}/build:/build -v ${HOME}/.config/flutter/:/.config/flutter/ --workdir /build'
        }
    }

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
            steps {
                sh 'flutter --version'
                sh 'flutter -v build apk'
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
            archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', onlyIfSuccessful: true
        }
    }
}
