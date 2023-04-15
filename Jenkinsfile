pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'pipeline is working'
      }
    }

    stage('Pre Deploy') {
      steps {
        echo 'generating build artifact'
        powershell 'Compress-Archive * publish.zip'
        archiveArtifacts(artifacts: 'publish.zip', fingerprint: true)
        echo 'zip artifact generated'
      }
    }

    stage('Deploy') {
      steps {
        sshPublisher(publishers: [
          sshPublisherDesc(
            configName: "jump server",
            verbose: true,
            transfers: [
              sshTransfer(
                sourceFiles: "publish.zip",
                remoteDirectory: "/artifacts/",
                makeEmptyDirs: true,
              )
            ])
        ])
      }
    }

    stage('Post Deploy') {
      steps {
        echo 'Code Deployed Successfully'
      }
    }

  }
}