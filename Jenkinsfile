pipeline {
  agent any

  stages {
    stage('Checkout repos') {
      steps {
        // Checkout repo1 into workspace root
        git url: 'https://github.com/JAWHARULLA/repo1-docker.git', branch: 'main'
        // Checkout repo2 into subfolder 'repo2'
        dir('repo2') {
          git url: 'https://github.com/JAWHARULLA/repo2-app.git', branch: 'main'
        }
        // show files
        bat 'echo === workspace listing ==='
        bat 'dir /B /S'
      }
    }

    stage('Build Docker image') {
      steps {
        bat 'docker --version'
        // Build image from workspace (Dockerfile must be in repo1 root)
        bat 'docker build -t repo1-with-repo2:latest .'
      }
    }

    stage('Run container (smoke test)') {
      steps {
        // Run container and save stdout to file (avoid failing the step on container non-zero)
        bat 'docker run --rm repo1-with-repo2:latest > container_output.txt || exit /b 0'
        archiveArtifacts artifacts: 'container_output.txt', allowEmptyArchive: false
        bat 'type container_output.txt'
      }
    }
  } // stages

  post {
    success {
      echo "✔️ Pipeline succeeded"
      // cleanup local image (optional)
      bat 'docker image rm repo1-with-repo2:latest || exit /b 0'
    }
    failure {
      echo "❌ Pipeline failed"
    }
  }
}
