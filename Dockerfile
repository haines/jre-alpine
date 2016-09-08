FROM ahaines/alpine-glibc

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=102 \
    JAVA_BUILD=14

ENV JAVA_HOME=/usr/lib/jvm/jre1.${JAVA_VERSION}.0_${JAVA_UPDATE}

RUN apk --no-cache add --virtual=build-dependencies wget ca-certificates \

 && wget http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
         --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
         --directory-prefix=/tmp/ \
         --quiet \

 && mkdir /usr/lib/jvm \

 && tar -xzf /tmp/jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
        -C /usr/lib/jvm \

 && rm -rf $JAVA_HOME/bin/javaws \
           $JAVA_HOME/bin/jjs \
           $JAVA_HOME/bin/keytool \
           $JAVA_HOME/bin/orbd \
           $JAVA_HOME/bin/pack200 \
           $JAVA_HOME/bin/policytool \
           $JAVA_HOME/bin/rmid \
           $JAVA_HOME/bin/rmiregistry \
           $JAVA_HOME/bin/servertool \
           $JAVA_HOME/bin/tnameserv \
           $JAVA_HOME/bin/unpack200 \
           $JAVA_HOME/lib/amd64/libdecora_sse.so \
           $JAVA_HOME/lib/amd64/libprism_*.so \
           $JAVA_HOME/lib/amd64/libfxplugins.so \
           $JAVA_HOME/lib/amd64/libglass.so \
           $JAVA_HOME/lib/amd64/libgstreamer-lite.so \
           $JAVA_HOME/lib/amd64/libjavafx*.so \
           $JAVA_HOME/lib/amd64/libjfx*.so \
           $JAVA_HOME/lib/deploy* \
           $JAVA_HOME/lib/desktop \
           $JAVA_HOME/lib/ext/nashorn.jar \
           $JAVA_HOME/lib/ext/jfxrt.jar \
           $JAVA_HOME/lib/*javafx* \
           $JAVA_HOME/lib/javaws.jar \
           $JAVA_HOME/lib/jfr.jar \
           $JAVA_HOME/lib/jfr \
           $JAVA_HOME/lib/*jfx* \
           $JAVA_HOME/lib/oblique-fonts \
           $JAVA_HOME/lib/plugin.jar \
           $JAVA_HOME/plugin \

 && ln -s $JAVA_HOME/bin/* /usr/bin/ \

 && apk del build-dependencies \
 && rm /tmp/*
