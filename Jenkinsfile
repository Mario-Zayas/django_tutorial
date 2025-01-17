pipeline {
    agent none
    stages {
        stage ('Testing') { 
            agent { 
                docker { image 'python:3'
                args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'master',url:'https://github.com/Mario-Zayas/django_tutorial.git'
                    }
                }
                stage('Install') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'python3 manage.py test'
                    }
                } 
            }
        }
        stage('Copiar settings') {
            agent any
            stages {
                stage('Copiado del settings') {
                    steps {
                        sh 'cp django_tutorial/settings.bak django_tutorial/settings.py'
                    }
                }
                stage('Build and push') {
                    steps {
                        script {
                            withDockerRegistry([credentialsId: 'DOCKER_HUB', url: '']) {
                            def dockerImage = docker.build("mzaygar034/django_tutorial_jenkins:${env.BUILD_ID}")
                            dockerImage.push()
                            }
                        }
                    }
                }
                stage('Remove image') {
                    steps {
                        script {
                            sh "docker rmi mzaygar034/django_tutorial_jenkins:${env.BUILD_ID}"
                        }
                    }
                }
                stage ('SSH') {
                    steps{
                        sshagent(credentials : ['CLAVE_SSH']) {
			    sh 'ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es rm docker-compose.yaml'
			    sh 'ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es docker rmi -f mzaygar034/django_tutorial_jenkins:67'
                            sh 'ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es wget https://raw.githubusercontent.com/Mario-Zayas/django_tutorial/master/docker-compose.yaml -O docker-compose.yaml'
                            sh 'ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es docker compose up -d --force-recreate'
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            mail to: 'mzaygar034@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
