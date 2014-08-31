#! /bin/sh
echo "Installing build-essential..."
sudo apt-get install build-essential


echo "Installing the Point Cloud Library..."
read -p "NOTE: This will build PCL from source and can take a real long time. Are you sure you want to do this now? (y/n):" yn
case $yn in
    [Nn]* ) continue;;
    [Yy]* ) wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.1.zip -O ~/Downloads/pcl-1.7.1.zip
            cd ~/Downloads
            unzip pcl-1.7.1.zip -d ~/pcl
            cd ~/pcl/pcl-pcl-1.7.1
            mkdir build
            cd build
            cmake -D CMAKE_INSTALL_PREFIX=/usr ..
            make && sudo make install;;
    * ) echo "Please answer yes or no.";;
esac

if [ ! -f /usr/local/include/sicklms-1.0/SickLIDAR.hh ]; then
    echo "Installing the SICK ToolBox..."
    # Eventually change it to download the pre-modified tarball:
    # https://owncloud.robojackets.org/public.php?service=files&t=f68716a1e61616aab79297cc6f593eb9
    wget http://downloads.sourceforge.net/project/sicktoolbox/sicktoolbox/1.0.1/sicktoolbox-1.0.1.tar.gz ~/Downloads/
    wget http://downloads.sourceforge.net/project/sicktoolbox/sicktoolbox/1.0.1/sicktoolbox-1.0.1.tar.gz -O ~/Downloads/sicktoolbox-1.0.1.tar.gz
    tar -zxvf ~/Downloads/sicktoolbox-1.0.1.tar.gz -C ~/
    cd ~/sicktoolbox-1.0.1/
    ./configure
    # Add includes that prevent the code from building
    sed -i -e '22i#include <unistd.h>\' c++/drivers/base/src/SickBufferMonitor.hh
    sed -i -e '42i#include <unistd.h>\' c++/drivers/base/src/SickLIDAR.hh
    make && sudo make install
else
    echo "SICK ToolBox seems to already be installed, so I'll skip that step."
fi


echo "Installing OpenCV..."
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install libopencv-dev


echo "Installing Qt..."
wget http://download.qt-project.org/official_releases/online_installers/qt-opensource-linux-x64-1.6.0-4-online.run -O ~/Downloads/qt-opensource-linux-x64-1.6.0-4-online.run
cd ~/Downloads
sudo chmod +x qt-opensource-linux-x64-1.6.0-4-online.run
sudo ./qt-opensource-linux-x64-1.6.0-4-online.run


# Evetually add automatic PTGrey installation
sudo apt-get install libglademm-2.4-1c2a libgtkglextmm-x11-1.2-dev
echo "######################################################"
echo "Please download and install FlyCapture from ptgrey.com"
echo "######################################################"

