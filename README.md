# DeploymentStrategies

In this repo we will give you a walkthrough of various deployment strategies using Ansible

## Reference
* https://thenewstack.io/deployment-strategies/

## Recreate Deployment Strategy
In this deployment Strategy we will go with a downtime approach,
* LoadBalancer will show a downtime page
* App Server(tomcat) on all the target servers will be shutdown
* WAR file will be deployed to the 3 target servers
* LoadBalancer will start sending traffic to the newly deployed code