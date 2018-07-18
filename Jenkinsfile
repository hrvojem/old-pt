pipeline {
  agent {
    docker {
      image 'ubuntu:18.04'
    }

  }
  stages {
    stage('test 1') {
      steps {
        sh '''#!/bin/bash
echo "this is test"'''
      }
    }
  }
}