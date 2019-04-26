# Build the WAR (multistage-build)
FROM maven:3.6.1-jdk-8 AS MAVEN_TOOL_CHAIN
WORKDIR /build/

COPY pom.xml /build/pom.xml
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.0.2:go-offline

COPY src/ /build/src/
RUN mvn -B -e -o -T 1C package

# -----------

# Run the WAR in a tomcat 
FROM tomcat:8.5.40-jre8
RUN rm -rf $CATALINA_HOME/webapps/*
COPY --from=MAVEN_TOOL_CHAIN /build/target/*.war $CATALINA_HOME/webapps/ROOT.war


