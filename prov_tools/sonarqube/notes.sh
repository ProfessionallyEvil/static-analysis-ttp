#!/usr/bin/env bash


set -euo pipefail
# set -x

# docker run -d --name sonarqube -p 9000:9000 sonarqube && docker logs -f $_
sleep 5
docker pull sonarqube
sudo apt-get install -y \
    bsdtar

sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w fs.file-max=65536
sudo ulimit -n 65536
sudo ulimit -u 4096

printf '\ndownloading the sonarqube software, this can take a while.\n'
sudo mkdir -p /opt/sonar-scanner && curl -fsSL 'https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip' | sudo bsdtar -xf - --strip-components=1 -C /opt/sonar-scanner
sudo chmod +x /opt/sonar-scanner/bin/* /opt/sonar-scanner/jre/bin/*
sudo ln -s /opt/sonar-scanner/bin/sonar-scanner{,-debug} /usr/local/bin/
sudo ln -s /opt/sonar-scanner/jre/bin/java /usr/local/bin/
sudo sed -i.orig 's/^[#|]sonar.host.url/sonar.host.url/' /opt/sonar-scanner/conf/sonar-scanner.properties


printf '\nYou can now do the following command to start sonarqube and  watch the logs:\n%s\n\n' 'docker run -d --name sonarqube -p 9000:9000 sonarqube && docker logs -f $'
printf 'Once you have started sonarqube it will be available at 192.168.33.10:9000. You can hit Ctrl+c to stop viewing logs.\n'
