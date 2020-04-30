FROM tomcat:7
COPY target/addressbook.war  /usr/local/tomcat/webapps/addressbook.war
CMD ["catalina.sh","run"]
