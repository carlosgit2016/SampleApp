# Building open jdk 8
FROM openjdk:8u242-jdk AS java

# Building Gradle
FROM gradle:latest AS gradle

# Building ionic
FROM beevelop/ionic

ENV JAVA_HOME=/usr/local/openjdk-8 \
	GRADLE_HOME=/opt/gradle 
ENV PATH $JAVA_HOME/bin:$GRADLE_HOME/bin:$PATH

WORKDIR /usr/src/app
COPY src/ resources/ ionic-integration-cordova/ ./*.json config.xml ./
COPY --from=java /usr/local/openjdk-8 /usr/local/openjdk-8
COPY --from=gradle /opt/gradle /opt/gradle
RUN npm install
EXPOSE 8100
CMD ["ionic","serve"]
