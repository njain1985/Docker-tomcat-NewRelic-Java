FROM tomcat:latest

MAINTAINER Nik Jain<njain@newrelic.com>

LABEL name="tomcat/java-agent" \
      maintainer="njain@newrelic.com" \
      vendor="NewRelic" \
      version="1.0" \
      release="1" \
      summary="Newrelic's Java agent starter image with tomcat" \
      description="Newrelic's Java agent starter image with tomcat" \
      url="https://newrelic.com"

# Create a user and group to launch processes - not used in this dockerfile

# The user ID - not used in this dockerfile

WORKDIR /usr/local/tomcat/

RUN curl -O "http://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip"

RUN ["apt-get", "install", "unzip"]

RUN ["unzip", "newrelic-java.zip", "-d", "/usr/local/tomcat"]

# change working directory to Tomcat
#WORKDIR /usr/local/tomcat/bin

# run the Tomcat Server
CMD ["/usr/local/tomcat/bin/startup.sh", "run"]
