##
# geodata/mapserver
#
# Mapserver compiled with ChefDK, Microsoft Truetype Fonts, and ODBC drivers.
#

FROM geodata/mapserver

MAINTAINER Alan Aytbaev <aaytbaevedr@edrnet.com>

USER root

RUN sudo apt-get update -yq --force-yes
RUN sudo apt-get install -yq --force-yes apt-transport-https
RUN sudo apt-get install -yq --force-yes curl
RUN sudo apt-get install -yq --force-yes vim

RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -c stable -v 2.5.3
RUN mkdir -p /root/chef-repo/cookbooks
WORKDIR /root/chef-repo
RUN chef generate cookbook cookbooks/mssql
WORKDIR /root/chef-repo/cookbooks/mssql/recipes
RUN sudo rm default.rb
COPY ./ableToConnectToMSSQL.rb /root/chef-repo/cookbooks/mssql/recipes
RUN mv ableToConnectToMSSQL.rb default.rb

RUN chef-client --local-mode --runlist 'recipe[mssql]'

EXPOSE 80

# Start the fcgi and web servers.
CMD /usr/local/bin/run.sh

#ogrinfo -so "MSSQL:server=GisDataDev;driver=ODBC Driver 17 for SQL Server;database=Mne1503;tables=dbo.County;UID=NodeClient;PWD=NodeClient;" | head -n5