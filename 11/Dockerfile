FROM adoptopenjdk/openjdk11:alpine
MAINTAINER WiTCOM devops@witcom.de

LABEL io.k8s.description="Platform for running Spring Boot applications" \
      io.k8s.display-name="Spring Boot Runner 1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="Java11,Springboot"

RUN apk update && apk add ca-certificates java-cacerts && rm -rf /var/cache/apk/*

#Add executables
RUN mkdir /opt/openshift
ENV HOME=/opt/openshift
COPY ./bin/* /opt/openshift/

#Add User & Group to run applications as
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && chown -R appuser:appgroup /opt/openshift && chmod -R 777 /opt/openshift

#Add Trust-Certificates
COPY ca-trust/* /usr/local/share/ca-certificates/
RUN update-ca-certificates && \
    cp -f /etc/ssl/certs/ca-certificates.crt /etc/ssl/cert.pem && \
    rm $JAVA_HOME/lib/security/cacerts && \
    ln -s /etc/ssl/certs/java/cacerts $JAVA_HOME/lib/security/cacerts

#Switch to non-root-user
USER appuser

WORKDIR "/opt/openshift"
EXPOSE 8080
CMD ["/opt/openshift/usage"]

