FROM adoptopenjdk/openjdk13
ENV LANG C.UTF-8

WORKDIR /usr/src
COPY target/ycsb-0.18.0-SNAPSHOT.tar.gz .
RUN tar xfvz ycsb-0.18.0-SNAPSHOT.tar.gz
RUN rm ycsb-0.18.0-SNAPSHOT.tar.gz
RUN mv ycsb-0.18.0-SNAPSHOT ycsb
WORKDIR /usr/src/ycsb
COPY lib/postgresql-42.2.16.jar lib/postgresql-42.2.16.jar
COPY scripts/useful_commands.sh .
RUN echo "source useful_commands.sh" >> ~/.bashrc
CMD "/bin/bash"
