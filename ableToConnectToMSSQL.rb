execute 'update packages' do
	command 'sudo apt-get -yq update'
end

initial_packages = ['apt-transport-https', 'libcurl3', 'php5-curl', 'curl']
initial_packages.each do |package|
	apt_package package do
		action :install
	end
end

execute 'install microsoft.asc keys for ubuntu 14.04' do
	command 'sudo curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -'
	command 'sudo curl https://packages.microsoft.com/config/ubuntu/14.04/prod.list > /etc/apt/sources.list.d/mssql-release.list'
end

execute 'install prod.list keys for ubuntu 14.04' do
	command 'sudo curl https://packages.microsoft.com/config/ubuntu/14.04/prod.list > /etc/apt/sources.list.d/mssql-release.list'
end

execute 'update packages' do
	command 'sudo apt-get -yq update'
end

execute 'install msodbcsql17' do
	command 'sudo ACCEPT_EULA=y apt-get install -yq --force-yes msodbcsql17'	
end

execute 'msql-tools' do
	command 'sudo ACCEPT_EULA=y apt-get install -yq --force-yes mssql-tools'
end

execute 'update path for ~/.bash_profile' do
	command 'echo export PATH="$PATH:/opt/mssql-tools/bin" >> ~/.bash_profile'
end

execute 'update path for ~/.bashrc' do
	command 'echo export PATH="$PATH:/opt/mssql-tools/bin" >> ~/.bashrc'
end

# The following code block is commented-out because sourcing does not work in chef's default user ROOT
#execute 'sourcing ~/.bashrc' do
#	command 'source ~/.bashrc'
#end
