FROM image-registry.openshift-image-registry.svc:5000/openshift/jenkins@sha256:81dc3755056f60a34693121d0da1e93deaaf00d86a72a6a2e5e259a7a09c881c as jenkins

USER root
COPY run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /usr/lib/jenkins/
RUN ls -lst jenkins.war && \
    rm -f jenkins.war && \
    wget --quiet --no-check-certificate https://updates.jenkins.io/download/war/2.303.2/jenkins.war && \
    ls -lst jenkins.war

VOLUME ["/var/lib/jenkins"]

USER 1001
#ENTRYPOINT ["/usr/bin/go-init", "-main", "/usr/libexec/s2i/run"]
CMD /usr/local/bin/run.sh
