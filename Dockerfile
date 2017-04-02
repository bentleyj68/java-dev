# Java Development Environment Server
# Setup SSH and a Development User
# Install Oracle Java Development Kit 64 bit 
# Install Maven  
# Install git  

# Use a Redhat derivative 
FROM centos:centos7

MAINTAINER Jim Bentley (http://miramtechnology.com, bentleyj68@gmail.com) 
ENV REFRESHED_AT 2017-03-29

# Maven Setup
ADD apache-maven-*.gz /opt
ADD jdk-*.gz /opt/java-oracle

# RUN yum update -y 
  RUN ln -s /opt/apache-maven-* /opt/maven && \
  ln -s /opt/maven/bin/mvn /usr/local/bin && \
  rm -f /opt/apache-maven-*.gz && \
  ln -s /opt/java-oracle/jdk-* /opt/java-oracle/jdk && \
  yum install install -y git 
#  yum clean all

# set shell variables 
ENV MAVEN_HOME /opt/maven
ENV JAVA_HOME /opt/java-oracle/jdk
ENV PATH $MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH 

#  mkdir /opt/java-oracle && tar -zxf /tmp/$filename -C /opt/java-oracle/ && \
#  update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

# Ports being exposed 
EXPOSE 22

# Start asadmin console and the domain 
CMD ["bash"]
