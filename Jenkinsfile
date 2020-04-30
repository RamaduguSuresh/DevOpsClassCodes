node{
     def maven=tool name: 'maven-3', type: 'maven'
     def bn=BUILD_NUMBER
    stage("Git checkout"){
        git "https://github.com/manojr-lab/DevOpsClassCodes.git"
    }
    stage("code build"){
        sh "${maven}/bin/mvn clean package"
    }
    stage("Archive artifacts"){
        archiveArtifacts artifacts: 'target/addressbook.war', onlyIfSuccessful: true
    }
    stage("Build docker image"){
        sh "docker build -t manoj523/addressbook-app:${bn} ."
    }
    stage("Docker push"){
        withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'DH_PWD')]) {
       sh "docker login -u manoj523 -p ${DH_PWD}"
     }
       sh "docker push manoj523/addressbook-app:${bn}"
    }
    stage("Remove Local Image"){
        sh "docker rmi -f manoj523/addressbook-app:${bn}"
    }
    stage("Deploy to swarm cluster"){
        sshagent(['Docker_Swarm']) {
        sh "ssh -o StrictHostKeyChecking=no ubuntu@10.1.2.46 docker service rm addressbookapp || true"
        sh "ssh -o StrictHostKeyChecking=no ubuntu@10.1.2.46 docker service create --name addressbookapp -p 8080:8080 --replicas 2 manoj523/addressbook-app:${bn}"

            
        }
    }
}
