#!/usr/bin/env groovy

pipeline {

  agent any

  // Global shell Environment variables which are specific to this particular jenkins job. The variables declared in jenkins
  //global configuration can be overriden here. 
  // BASE_VERSION env var contains the last recent major version of the repo and the version is incremented on top of it
  environment {        
    BASE_VERSION = "0.7"    
  }

  stages {               

    // Checkout git repository
    stage('Build notejam image') {
        
      // Execute this stage only on non-master branches
      when {
        not {
          branch 'master'
        }
      }                  
            
      steps {                      
        script {
          docker.withRegistry('https://hub.docker.com') {                  
            docker.build("notejam:latest", "-f $WORKSPACE/Dockerfile .")                  
          }
        }                          
      }          
      
    }            

    // Launch tests on non-master branches
    stage('Test the built images') {
      
      when {
        not {
          branch 'master'
        }
      }                 

      steps {
        script {         
          docker.image("notejam:latest").inside("-u root"){            
            sh 'python --version'            
            sh 'python /root/db.py'                             
            sh 'python /root/runserver.py &'
            sh 'curl http://127.0.0.1:5000'
          }
        } 
      }                                                                                                 
    }    

    // Publish the artifact created on master branch update/commit to artifact
    // Create a git tag corresponding to the artifact version
    stage('Publish') { 
      // Execute this stage only on master branches           
      when {
        branch 'master'
      }

      steps {
        checkout scm         
        script {
          def newBuild = newBuildVersion(BASE_VERSION)
          String version = newBuild
          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) { 
            docker.withRegistry('https://hub.docker.com', 'artifactory-credentials') {
              def image = docker.build("notejam:${version}", " -f $WORKSPACE/Dockerfile .")
              image.push()
            }                      
          }
        }                                 
      }            
    }    

  }

  // Always cleanup the jenkins workspace
  post {  
    always { 
      cleanWs()
    }
  }

}
