pipeline{

    agent any

    parameters {
        choice choices: ['chrome', 'firefox'], description: 'Select the browser', name: 'BROWSER'
        string defaultValue: 'flight-reservation.xml', description: 'Enter test suite name', name: 'TEST_SUITE', trim: true
    }


    stages{

        stage('Start Grid'){
            steps{
                bat "docker-compose -f grid.yaml up --scale ${params.BROWSER}=2 -d"
            }
        }

        stage('Run Test'){
            steps{
                bat "docker-compose -f test-suites.yaml up --pull=always"
                script {
                    if(fileExists('test-output/testng-failed.xml')){
                        error('failed tests found')
                    }
                }
            }
        }

    }

    post {
        always {
            bat "docker-compose -f grid.yaml down"
            bat "docker-compose -f test-suites.yaml down"
            archiveArtifacts artifacts: 'test-output/emailable-report.html', followSymlinks: false
        }
    }

}