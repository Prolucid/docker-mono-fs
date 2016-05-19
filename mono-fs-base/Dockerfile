FROM prolucid/mono-base
MAINTAINER Daniel Covello 
ENV DEBIAN_FRONTEND noninteractive

# The versions (github branches) that should be pulled and compiled
ENV FS_VERSION=4.0.1.1

# Install  F# from source
ENV FS_SETUP_TOOLS="autoconf libtool pkg-config make git automake"
WORKDIR /deploy
RUN apt-get update -y && apt-get install -y $FS_SETUP_TOOLS \
	&& mozroots --import --sync \
	&& git clone https://github.com/fsharp/fsharp $FS_VERSION \
	&& cd $FS_VERSION \ 
	&& ./autogen.sh --prefix /usr/local \
	&& make \
        && sudo make install \
	&& apt-get remove -y --purge $FS_SETUP_TOOLS \
	&& apt-get autoremove -y \
	&& rm -rf /deploy
