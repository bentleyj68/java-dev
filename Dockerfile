# Java Development Environment Server
# Setup SSH and a Development User
# Install Oracle Java Development Kit 64 bit 
# Install Maven  
# Install git  

# Use a Redhat derivative 
FROM centos:centos7

LABEL maintaner "Jim Bentley (http://miramtechnology.com, bentleyj68@gmail.com)" 
ENV REFRESHED_AT 2017-05-13

ARG user=java-dev 
ARG glassfishzip=glassfish-4.1.2.zip 
ARG gfpassword=glassfish

# set shell variables 
ENV JAVA_HOME /opt/java-oracle/jdk 
ENV MAVEN_HOME /opt/maven 
ENV GLASSFISH_HOME=/opt/glassfish4 
ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$GLASSFISH_HOME/bin:$PATH

# Maven Setup
ADD apache-maven-*.gz /opt
ADD jdk-*.gz /opt/java-oracle
ADD ${glassfishzip} /opt

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
  yum install install -y git unzip &&\ 
  yum clean all &&\
  cd /opt && \
  unzip /opt/${glassfishzip} && \
    rm -f ${glassfishzip} && \
    echo "--- Setup the password file ---" && \
    echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd && \
    echo "AS_ADMIN_NEWPASSWORD=${gfpassword}" >> /tmp/glassfishpwd  && \
    echo "--- Enable DAS, change admin password, and secure admin access ---" && \
    echo $PATH && \ 
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1 && \
    asadmin start-domain && \
    echo "AS_ADMIN_PASSWORD=${gfpassword}" > /tmp/glassfishpwd && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin && \
    asadmin --user=admin stop-domain && \
    chown -R $user.$user /opt/glassfish4 && \
    rm /tmp/glassfishpwd

#  mkdir /opt/java-oracle && tar -zxf /tmp/$filename -C /opt/java-oracle/ && \
#  update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

# Ports being exposed 
EXPOSE 22 4848 8080 8181

ENV HOME /home/$user
WORKDIR $HOME
ADD bash_profile $HOME/.bash_profile
ADD bashrc $HOME/.bashrc
RUN chown -R $user.$user $HOME
USER $user

# Start asadmin console and the domain 
CMD ["asadmin", "start-domain", "-v"]
# CMD ["/bin/bash"]
