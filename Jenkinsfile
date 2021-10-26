pipeline {
    environment {
        def scannerHome = tool 'sonarqube'
        ARTIFACTORY_CREDENTIALS = credentials('artifactory-developer-credentials')
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
                sh 'flutter pub get'
                sh 'flutter -v build apk'
                // sh "curl -v --user $ARTIFACTORY_CREDENTIALS_USR:$ARTIFACTORY_CREDENTIALS_PSW --data-binary @build/app/outputs/flutter-apk/app-release.apk -X PUT 'http://artifactory-1:8081/artifactory/libs-snapshot-local/svis-app/app-release.apk'"
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
