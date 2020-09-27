#!/bin/bash

# Set default rutorrent lsio path
rutorrent_path="/app/rutorrent"

echo "*** Installing NFO Plugin ***"
if [ ! -d $rutorrent_path/plugins/nfo ]
then
        echo "*** Installing NFO Plugin ***"
        cd $rutorrent_path/plugins/
        git clone https://github.com/phracker/ruTorrent-nfo.git nfo

        chown -R abc:abc $rutorrent_path/plugins/nfo
        chmod -R 775 $rutorrent_path/plugins/nfo

else
        echo "*** Updating NFO Plugin ***"
        cd $rutorrent_path/plugins/nfo
        git pull
fi
