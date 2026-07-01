pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {

                    def scannerHome = tool 'SonarScanner'

                    withSonarQubeEnv('Sonarqube') {

                        sh """
                            ${scannerHome}/bin/sonar-scanner
                        """

                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

    }

    post {
        success {
            echo "✅ SonarQube Quality Gate Passed."
        }

        failure {
            echo "❌ Quality Gate Failed. Pipeline aborted."
        }
    }
}
