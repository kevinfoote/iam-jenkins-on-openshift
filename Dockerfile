FROM image-registry.openshift-image-registry.svc:5000/oai-public/jenkins@sha256:fa285cf340afa239cc4a1723384f3e1060a9915458952cc6d0b737bbb1ac3984 as jenkins

USER root
COPY run /usr/libexec/s2i/run

WORKDIR /usr/lib/jenkins/
RUN ls -lst jenkins.war && \
    rm -f jenkins.war && \
    wget --quiet --no-check-certificate https://updates.jenkins.io/download/war/2.303.2/jenkins.war && \
    ls -lst jenkins.war

VOLUME ["/var/lib/jenkins"]

USER 1001
ENTRYPOINT ["/usr/bin/go-init", "-main", "/usr/libexec/s2i/run"]
