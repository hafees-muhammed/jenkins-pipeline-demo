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
    }
}
