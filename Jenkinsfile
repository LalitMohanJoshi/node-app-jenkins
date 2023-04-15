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
                execCommand: "curl -s -L https://raw.githubusercontent.com/LalitMohanJoshi/node-app-jenkins/master/scripts/deploy-script-azure-centos7.sh | bash"
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