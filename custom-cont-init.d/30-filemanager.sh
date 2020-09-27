#!/bin/bash

# Set default rutorrent lsio path
rutorrent_path="/app/rutorrent"

echo "*** Installing utilities to support plugins ***"
apk add --no-cache --upgrade zip unzip findutils php-sockets

echo "*** Checking for rar ***"
if [ ! -f /usr/bin/rar ]
then
        echo "*** Downloading rar ***"
        cd /tmp
        if [ `getconf LONG_BIT` = "64" ]
                then
                        wget -O rarlinux.tar.gz https://www.rarlab.com/rar/rarlinux-x64-5.9.1.tar.gz
                else
                        wget -O rarlinux.tar.gz https://www.rarlab.com/rar/rarlinux-5.9.1.tar.gz
                fi
        echo "*** Installing rar ***"
        tar -xzf rarlinux.tar.gz
        rm rarlinux.tar.gz
        mv rar/rar /usr/bin/rar
        rm -rf rar
        chmod 755 /usr/bin/rar
        cd /
else
        echo "*** Rar already installed ***"
fi

echo "*** Checking for filemanager config ***"
if [ ! -f $rutorrent_path/plugins/filemanager/conf.php ]
then
        echo "*** Installing filemanager ***"
        cd $rutorrent_path/plugins/
        git clone https://github.com/STX2k/rutorrent-filemanager.git filemanager

        chown -R abc:abc $rutorrent_path/plugins/filemanager
        chmod -R 775 $rutorrent_path/plugins/filemanager/scripts

else
        echo "*** Updating filemanager ***"
        cd $rutorrent_path/plugins/filemanager
        git pull
fi
