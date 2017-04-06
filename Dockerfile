# Java Development Environment Server
# Setup SSH and a Development User
# Install Oracle Java Development Kit 64 bit 
# Install Maven  
# Install git  

# Use a Redhat derivative 
FROM centos:centos7

LABEL maintaner "Jim Bentley (http://miramtechnology.com, bentleyj68@gmail.com)" 
ENV REFRESHED_AT 2017-04-06

ARG user=java-dev

# Maven Setup
ADD apache-maven-*.gz /opt
ADD jdk-*.gz /opt/java-oracle

RUN yum update -y &&\ 
  ln -s /opt/apache-maven-* /opt/maven && \
  ln -s /opt/maven/bin/mvn /usr/local/bin && \
  rm -f /opt/apache-maven-*.gz && \
  ln -s /opt/java-oracle/jdk* /opt/java-oracle/jdk && \
  export uid=1000 gid=1000 && \
  mkdir -p /home/$user && \
  echo "${user}:x:${uid}:${gid}:${user},,,:/home/${user}:/bin/bash" >> /etc/passwd && \
  echo "${user}:x:${uid}:" >> /etc/group && \
  chown ${uid}:${gid} -R /home/$user && \
  yum install install -y git &&\ 
  yum clean all

# set shell variables 
ENV MAVEN_HOME /opt/maven
ENV JAVA_HOME /opt/java-oracle/jdk
ENV PATH $MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH 

#  mkdir /opt/java-oracle && tar -zxf /tmp/$filename -C /opt/java-oracle/ && \
#  update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

# Ports being exposed 
EXPOSE 22

USER $user
ENV HOME /home/$user
WORKDIR $HOME

# Start asadmin console and the domain 
CMD ["bash"]
