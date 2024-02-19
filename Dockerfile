FROM ubuntu:20.04
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt install default-jdk tomcat9 maven git -y
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN mvn -f /boxfuse-sample-java-war-hello/pom.xml package
RUN mkdir /usr/local/tomcat/webapps/
RUN cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/ #/var/lib/tomcat9/webapps/
RUN cp -R /boxfuse-sample-java-war-hello/target/hello-1.0 /usr/local/tomcat/webapps/ #/var/lib/tomcat9/webapps/
EXPOSE 8080
RUN ls -l /usr/local/tomcat/webapps/
ENV JAVA_HOME /usr/lib/jvm/default-java
RUN mkdir /usr/share/tomcat9/conf
RUN cp /usr/share/tomcat9/etc/server.xml /usr/share/tomcat9/conf
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]