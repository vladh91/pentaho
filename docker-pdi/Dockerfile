FROM java:8-jre

MAINTAINER Vlad Harutyunyan

# Set required environment vars
ENV PDI_RELEASE=7.1 \
    PDI_VERSION=7.1.0.0-12 \
    CARTE_PORT=8181 \
    PENTAHO_JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PENTAHO_HOME=/home/pentaho

# Create user
RUN mkdir ${PENTAHO_HOME} && \
    groupadd -r pentaho && \
    useradd -s /bin/bash -d ${PENTAHO_HOME} -r -g pentaho pentaho && \
    chown pentaho:pentaho ${PENTAHO_HOME}

# Add files
RUN mkdir $PENTAHO_HOME/docker-entrypoint.d

COPY docker-entrypoint.sh $PENTAHO_HOME/scripts/

RUN chown -R pentaho:pentaho $PENTAHO_HOME 

RUN apt-get update && apt-get install -y libwebkitgtk-1.0-0

RUN apt-get update && apt-get install -y dos2unix

RUN dos2unix $PENTAHO_HOME/scripts/docker-entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

# Switch to the pentaho user
USER pentaho

# Download PDI
#RUN /usr/bin/wget \
#    --progress=dot:giga \
#    http://downloads.sourceforge.net/project/pentaho/Data%20Integration/${PDI_RELEASE}/pdi-ce-${PDI_VERSION}.zip \
#    -O /tmp/pdi-ce-${PDI_VERSION}.zip && \
COPY pdi-ce.zip /tmp/pdi-ce.zip
RUN  /usr/bin/unzip -q /tmp/pdi-ce.zip -d  $PENTAHO_HOME


ENV KETTLE_HOME=$PENTAHO_HOME/data-integration \
    PATH=$KETTLE_HOME:$PATH

WORKDIR $KETTLE_HOME

ENTRYPOINT ["../scripts/docker-entrypoint.sh"]
