# Use an official Python runtime as a parent image
FROM debian:latest

# Set the working directory to /app

RUN apt-get update && apt-get upgrade -y 

RUN useradd minecraft

RUN apt-get install curl wget git -y

RUN apt-get install openjdk-8-jre-headless -y



RUN mkdir /srv/minecraft

RUN cd /srv/minecraft


RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar 
RUN java -jar BuildTools.jar

RUN java -Xms512M -Xmx900M -jar spigot-1.12.2.jar
