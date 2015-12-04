FROM ubuntu:15.10

RUN apt-get -y update 

RUN apt-get install -y \
  wget \
  rsync \
  clang \
  libicu-dev \
  libedit-dev \
  libpython2.7-dev
  
ENV SWIFT_VERSION 2.2-SNAPSHOT-2015-12-01-b
ENV SWIFT_PLATFORM ubuntu15.10
ENV SWIFT_PLATFORM_DIR  ubuntu1510
ENV PATH /usr/bin:$PATH  
 
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
  wget https://swift.org/builds/$SWIFT_PLATFORM_DIR/swift-$SWIFT_VERSION/swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz && \
  wget https://swift.org/builds/$SWIFT_PLATFORM_DIR/swift-$SWIFT_VERSION/swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz.sig

RUN gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift && \
  gpg --verify swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz.sig && \
  tar -xvzf swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz  --directory / --strip-components=1 && \
  rm swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz && \
  rm swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz.sig && \
  bash -c "swift <(echo 'print(\"Congratulations! Swift is now installed.\")')"


ENTRYPOINT swift

