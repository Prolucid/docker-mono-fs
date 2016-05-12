FROM phusion/baseimage 
MAINTAINER Daniel Covello 
ENV DEBIAN_FRONTEND noninteractive

# The versions (github branches) that should be pulled and compiled
ENV MONO_VERSION=4.2.3.4

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
	echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/$MONO_VERSION main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list && \
	sudo apt-get update && \
	sudo apt-get install -y mono-complete


# Install  F# from source
ENV FS_SETUP_TOOLS="autoconf libtool pkg-config make git automake"
WORKDIR /deploy
RUN apt-get update -y && apt-get install -y $FS_SETUP_TOOLS \
	&& mozroots --import --sync \
	&& git clone https://github.com/fsharp/fsharp \
	&& cd fsharp \ 
	&& ./autogen.sh --prefix /usr/local \
	&& make \
        && sudo make install \
	&& apt-get remove -y --purge $FS_SETUP_TOOLS \
	&& apt-get autoremove -y \
	&& rm -rf /deploy
WORKDIR /app
