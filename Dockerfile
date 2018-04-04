FROM phusion/baseimage:0.9.22 
MAINTAINER Daniel Covello 
ENV DEBIAN_FRONTEND noninteractive

# The versions (github branches) that should be pulled and compiled
ENV MONO_VERSION=5.2.0
ENV FS_VERSION=4.1.9-0xamarin11+ubuntu1604b1

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
	echo "deb http://download.mono-project.com/repo/debian xenial/snapshots/$MONO_VERSION main" | tee /etc/apt/sources.list.d/mono-xamarin.list && \
	apt-get update && \
	apt-get install -y mono-complete fsharp=$FS_VERSION 

WORKDIR /app
