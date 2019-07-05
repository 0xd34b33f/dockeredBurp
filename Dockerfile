FROM ubuntu:16.04

RUN apt-get update; apt-get -y install  openjdk-8-jre sudo
#setting java envirovments
RUN java -version && echo "JAVA_HOME=$(which java)" |  tee -a /etc/environment && sh .  /etc/environment && echo $JAVA_HOME

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
# write here path to your unpacked burp
COPY burpsuite_pro_v2.0.11beta ./burp
WORKDIR burp
#use is by instruction for informational purposes only.
CMD java -jar burploader.jar