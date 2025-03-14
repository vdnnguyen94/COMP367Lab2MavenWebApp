pipeline {
    agent any

    tools {
        // Use the configured Maven version named "Maven" in Jenkins
        maven "Maven"
        docker "Docker"
    }
    environment {
        DOCKER_CREDENTIALS = 'dockerhubpat'      
        DOCKER_IMAGE = 'vdnnguyen94/my-maven-web-app'  
        DOCKER_TAG = 'latest'
    }
    

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vdnnguyen94/COMP367Lab2MavenWebApp.git'
            }
        }

        stage('Build') {
            steps {
				// Run Maven on a Unix agent.
                //sh "mvn -Dmaven.test.failure.ignore=true clean package"
                
                // Run Maven build on Windows
                bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }
        // build docker
        stage('Docker Build') {
            steps {
                script {
                    bat "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
    }

    post {
        // If the build is successful, archive the artifacts and test results
        always {
            // Clean up Docker login after the process
            bat "docker logout"
        }
        success {
            junit '**/target/surefire-reports/TEST-*.xml'
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }

        // If the build fails, mark it as unstable
        failure {
            echo "Build failed! Please check the logs."
        }
    }
}
