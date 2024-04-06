# Task2

## Task 2: CI/CD Setup

Scenario:
Implement a basic CI/CD pipeline using Jenkins
Automate the deployment of changes to your static website.

## Requirements:

Connect your code repository to Jenkins
Use Jenkins for building and deploying the website.
Demonstrate a successful automated deployment.

### Deliverables:
Provide documentation on the CI/CD pipeline setup.

1. jenkins is installed using the terraform under terraform/jenkins 
2. after installation manually define a pipeline - see screen shots below 

to get credntials ssh to machine sudo cat /home/bitnami/bitnami_credentials"
http://ec2-3-235-20-202.compute-1.amazonaws.com/manage/

#curl http://localhost/jnlpJars/jenkins-cli.jar  -o jenkins-cli.jar 
# seacrh for Pipeline: Declarative , install and restart Jenkins
# the same for Git 
# safeRestart 

http://jenkins_dns/manage/pluginManager/available

git repo: https://github.com/orenevan/nice-exam
script path:  jenkins_pipline/Jenkinsfile

See the following screenshot 
[jenlins-pipeline](screenshots/pipeline_configuration.png)
[pipeline_script_path.png](screenshots/script_path.png)
[install_plugin_declarative](screenshots/install_plugin_declarative.png) 
[install_plugin_git](screenshots/install_plugin_git.png)

