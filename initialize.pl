use warnings;
use strict;
my $output =  `docker ps -a`;
print ("OUTPUT: $output");
if(index($output, 'MAPSERVER') != -1) {
    system("docker stop MAPSERVER");
    print("MAPSERVER stopped.\n");
    system("docker rm MAPSERVER");
    print("MAPSERVER removed.\n");
} 
system("docker run -it -d -p 8080:80 -v\"/MapFiles:/data\" --name MAPSERVER geodata/mapserver");
print("New MAPSERVER created.\n");