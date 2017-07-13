FROM ahaines/glibc-alpine:2.25-r0_on_3.6

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=131 \
    JAVA_BUILD=11 \
    JAVA_URL_HASH=d54c1d3a095b4ff2b6607d096fa80163 \
    JAVA_SHA256_CHECKSUM=355e5cdb066d4cada1f9f16f358b6fa6280ff5caf7470cf0d5cdd43083408d35

ENV JAVA_HOME=/usr/lib/jvm/jre1.${JAVA_VERSION}.0_${JAVA_UPDATE}

RUN apk --no-cache add --virtual=build-dependencies wget ca-certificates \

 && wget http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_URL_HASH}/jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
         --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
         --directory-prefix=/tmp/ \
         --quiet \

 && echo "${JAVA_SHA256_CHECKSUM}  /tmp/jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" | sha256sum -c - \

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
