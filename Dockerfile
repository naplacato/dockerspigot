# Use an official Python runtime as a parent image
FROM debian:latest

# Set the working directory to /app

# Update whole system to curent version of packages
RUN apt-get update && apt-get upgrade -y 

# Install java and other packages we will need
RUN apt-get install wget curl git openjdk-8-jre-headless -y

# Create user minecraft who will become server operator later
RUN useradd minecraft
# RUN groupadd minecraft
RUN usermod -a -G minecraft minecraft

# Make directory where server.jar will resides and give proposed operator ownership
RUN mkdir /srv/minecraft

# Make and enter directory where server will be build
RUN mkdir /srv/minecraft/buil
RUN mkdir /srv/minecraft/server
RUN chown -R minecraft:minecraft /srv/minecraft

# Change ownership for all visible files
# RUN find . -type f -name '*.*' | xargs chown minecraft:minecraft 

# Enter build directory, download and build server from source (latest stable), 
# copy to production directory
RUN cd /srv/minecraft/build
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar 
RUN java -jar BuildTools.jar
RUN cp ./spigot* ../server/spigot.jar



# Run Server in frontend # so the container doesnt exit
RUN cd /srv/minecraft/server
RUN echo "eula=true" > eula.txt
RUN java -Xms512M -Xmx900M -jar spigot.jar
