# docker build -t sbt/life .
# docker run -a stdin -a stdout -i -t sbt/life /bin/bash
# sbt debian:package-bin
# docker run -v $HOME/.sbt:/root/.sbt -v $HOME/ivy2:/root/.ivy2 -v (pwd):/app sbt/life clean package-bin

FROM ubuntu:14.04

RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y install \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    fakeroot \
    apt-file

# Fix upstart - http://stackoverflow.com/a/31134244/1216965
RUN rm -rf /sbin/initctl && ln -s /sbin/initctl.distrib /sbin/initctl

# Install Java. - https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install SBT - http://www.scala-sbt.org/release/docs/Installing-sbt-on-Linux.html
RUN \
  echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
  apt-get update && \
  apt-get -y install sbt && \
  sbt

RUN mkdir /app
VOLUME [ "/app" ]
WORKDIR "/app"

# Define default command.
ENTRYPOINT ["sbt"]
CMD ["--version"]


# Define working directory.
#WORKDIR /data
#ADD . /data


