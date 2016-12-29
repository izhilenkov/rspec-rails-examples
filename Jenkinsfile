node('docker-node') {
    stage("build docker image") {
        sh "docker build -t rspec-rails-examples ."
    }
    stage("run migrations in parallel") {
        parallel(
            models : {
                sh "docker-compose up -d postgresmodels"
                sh "docker-compose run web_models bundle exec rake db:drop db:create db:migrate db:seed"
            },
            controllers : {
                sh "docker-compose up -d postgrescontrollers"
                sh "docker-compose run web_controllers bundle exec rake db:drop db:create db:migrate db:seed"
            }
        )
    }
    stage("run tests in parallel") {
        parallel(
            controllers : {
                sh "docker-compose up web_controllers"
            },
            models : {
                sh "docker-compose up web_models"
            }
        )
    },
    stage("run tests in parallel") {
      parallel(
          jobs : {
              sh "docker-compose up web_jobs"
          },
          tasks : {
              sh "docker-compose up web_tasks"
          }
      )
    }
    stage("clean up  containers") {
        sh "docker-compose stop"
        sh "docker-compose rm -f"
    }
}
