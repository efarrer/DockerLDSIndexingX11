FROM ubuntu:14.04

RUN apt-get update && apt-get -y install \
    openjdk-6-jre \
    patch \
    wget

RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-1.6.0-openjdk-amd64/jre/bin/java" 1

RUN wget -c https://indexing.familysearch.org/downloads/Indexing_unix.sh && chmod o+x /Indexing_unix.sh

COPY . /

RUN patch /Indexing_unix.sh /Indexing_unix.patch
RUN echo | /Indexing_unix.sh || true

CMD ["/usr/share/fs-indexing/indexing.familysearch.org/indexing"]
