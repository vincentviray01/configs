sudo dpkg --set-selections < dpkg_package_list.txt
sudo dselect update
sudo apt-get update
sudo apt-get -u dselect-upgrade
sudo apt-get dist-upgrade
