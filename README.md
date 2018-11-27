Docker-tomcat-NewRelic-Java

Use this repository to get New Relic Java Agent integrated with a Tomcat Container

NOTE: This is a simple tutorial that entails a Dockerfile and a docker run command to bake New Relic Java Agent into the latest Tomcat (8.0) container.

You will require the following two things to get started:
1. You will need an official license from New Relic SaaS UI: rpm.newrelic.com/accounts/xxxxxx (If you don't have a New Relic Account, sign up for a trial on https://newrelic.com/signup 
2. Use the official Tomcat docker image from docker hub: https://hub.docker.com/_/tomcat/

Once you have the above two sorted, you can proceed with the following:

STEP 1. Install Docker on your host - I used the free SMP Debian 4.9.130-2 (2018-10-27) x86_64 GNU/Linux for testing purposes
STEP 2. Once Docker is up and running, use the Dockerfile attached in this Github Repo to create a local tomcat image that entails New Relic Java Agent. You may build the container with this command - docker build -t tomcat-newrelic .
STEP 3. Once the container image is ready, you will need to run it with the following two options:

#Distributed tracing enabled - substep 3.1:

docker run -it -p 8888:8080 -e JAVA_OPTS="-javaagent:/usr/local/tomcat/newrelic/newrelic.jar -Dnewrelic.config.license_key=<unique_newrelic_license_key> -Dnewrelic.config.app_name=Tomcat-base-app2 -Dnewrelic.config.distributed_tracing.enabled=true" tomcat-test2

#Without distributed tracing - substep 3.2: 

docker run -it -p 8888:8080 -e JAVA_OPTS="-javaagent:/usr/local/tomcat/newrelic/newrelic.jar -Dnewrelic.config.license_key=<unique_newrelic_license_key>-Dnewrelic.config.app_name=Tomcat-base-app2 -Dnewrelic.config.distributed_tracing.enabled=true" tomcat-test2

P.S. 
Replace the <unique_newrelic_license_key with the license key generated within your New Relic master/sub account, also, you don't need the angle brackets < >
In the aforementioned docker run command, the system properties are customisable to your needs. 

- Assign an app_name that makes most sense for your app (A good name = Prod_eCommerce_AWS_API_Backend, A bad name = ASIG-SFFG-Service). This is the microservice name that will appear in New Relic SaaS UI. You must use the same app_name across all the micro-services that serve the same function, this way you would get a clean multi-container (host) view for that particular microservice. 
- The parameter -Dnewrelic.config.license_key=xxxxxxxxxx is the license key that you can get from New Relic Account Settings page (right-side of the browser) 
- The parameter -Dnewrelic.config.distributed_tracing.enabled accepts boolean values - true or false which can be used to activate or de-activate distributed tracing (it is recommended to keep this enabled OOTB because its super powerful in squashing code-level and latency related issues quickly, essentially reducing MTTR and providing cross-microservice traces with response time for each node and layer that participates in a transaction call)
- In addition, you can also pass -b and -bmanagement flag in the docker run command which accepts an ip address value 0.0.0.0
- In this particular example, I am curling New Relic download.newrelic.com website to download the latest copy of the Java Agent and unzipping it under the tomcat directory. There is nothing stopping you from ADD/COPY-ing into the Dockerfile. I still recommend curling vs ADD/COPY-ing so that you can pre-package the agent and enable monitoring-on-the-go by baking the agent into your final container image
- Full New Relic Agent config details are available on https://docs.newrelic.com/docs/agents/java-agent/configuration/java-agent-configuration-config-file
- The -p parameter is for port mapping that will allow users to access the tomcat sample apps on http://<ip_address>:8888 in this case. You can customise it to any other port available on your host. 
