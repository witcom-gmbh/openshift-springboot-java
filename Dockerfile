FROM openjdk:8-jre-alpine3.9
MAINTAINER Carsten Buchberger c.buchberger@witcom.de

LABEL io.k8s.description="Platform for running Spring Boot applications" \
      io.k8s.display-name="Spring Boot Runner 1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="Java,Springboot"

#Add certificates
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY ca-trust/*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

#Add executables
RUN mkdir /usr/libexec/springboot
COPY ./bin/ /usr/libexec/springboot
RUN chmod -R 777 /usr/libexec/springboot

#Add User & Group to run applications as
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && mkdir /opt/openshift && chown -R appuser:appgroup /opt/openshift && chmod -R 777 /opt/openshift

#Switch to non-root-user
USER appuser

WORKDIR "/opt/openshift"
EXPOSE 8080
CMD ["/usr/libexec/springboot/usage"]

