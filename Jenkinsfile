pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = "645519535125"
        AWS_REGION     = "ap-south-2"
        ECR_REPO       = "node-demo-app"
        IMAGE_TAG      = "v3"
        ECR_REGISTRY   = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_URI      = "${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Tools') {
            steps {
                sh '''
                    git --version
                    docker --version
                    aws --version
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REGISTRY
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $ECR_REPO:$IMAGE_TAG .
                '''
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh '''
                    docker tag $ECR_REPO:$IMAGE_TAG $IMAGE_URI
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REGISTRY
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                    docker push $IMAGE_URI
                '''
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                        aws ecr get-login-password --region $AWS_REGION | \
                        docker login --username AWS --password-stdin $ECR_REGISTRY

                        docker pull $IMAGE_URI

                        docker stop demo-app || true
                        docker rm demo-app || true

                        docker run -d \
                         --name demo-app \
                         -p 80:3000 \
                         645519535125.dkr.ecr.ap-south-2.amazonaws.com/node-demo-app:$IMAGE_TAG

                '''
            }
        }
    }

    post {
        success {
            echo "Docker image pushed and deployed successfully: ${IMAGE_URI}"
        }

        failure {
            echo "Pipeline failed. Check Jenkins console logs."
        }
    }
}
