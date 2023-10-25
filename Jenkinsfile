pipeline {
    agent any
    environment{
        //REGISTRY = 'roxsross12'
        REPOSITORY = 'servidorweb'
        TAG = '1.0.14'
        DOCKER_HUB_LOGIN = credentials('docker-hub')
    }

    stages {
        stage('build') {
            steps {
                sh 'docker build -t $REPOSITORY:$TAG .'
                sh 'docker images'


            }
        }   
        stage('push_to_hub') {
            steps {
                sh 'docker tag $REPOSITORY:$TAG $REGISTRY/$REPOSITORY:$TAG'
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$REPOSITORY:$TAG'
                sh 'docker image prune --force'
   
            }
        } 
        stage('update_compose') {
            steps {
                sh ("sed -i -- 's/REPLACE/$TAG/g' docker-compose.yml")
                sh 'cat docker-compose.yml'

            }
        } 
        stage('deploy_to_prod') {
            input {
                message 'Deploy a produccion'
                ok 'validar'
                parameters {
                    string (name: 'ENVIRONMENT', defaultValue: 'PROD', description: 'despliegue en produccion')
                }
            }
            steps {
                echo "Se despliega el release $TAG en el ambiente $ENVIRONMENT"
                sh 'ssh -o StrictHostKeyChecking=no $SSHIP ls -lrt'
            }
        }                          
    }
}