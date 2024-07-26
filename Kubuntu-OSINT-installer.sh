#!/bin/bash

# Update the system and install necessary dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl git python3 python3-pip build-essential virtualenv pipx

# Ensure pipx is set up correctly
pipx ensurepath

# Create Trace Labs directory in applications menu
mkdir -p ~/.local/share/applications/Trace_Labs

# Function to create desktop entry
create_desktop_entry() {
    local name=$1
    local exec=$2
    local icon=$3
    local category=$4
    local folder=$5

    mkdir -p ~/.local/share/applications/Trace_Labs/$folder

    echo "[Desktop Entry]
Name=$name
Exec=$exec
Icon=$icon
Type=Application
Categories=$category;
" > ~/.local/share/applications/Trace_Labs/$folder/$name.desktop
}

# Install Firefox (regular version since ESR is not available)
sudo apt install -y firefox
create_desktop_entry "Firefox" "/usr/bin/firefox" "firefox" "Network;WebBrowser;" "Browsers"

# Install Tor Browser
TOR_VERSION=$(curl -s https://www.torproject.org/download/ | grep -oP 'tor-browser-linux64-\K[0-9.]+(?=\.tar\.xz)' | head -n 1)
wget "https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux64-${TOR_VERSION}_ALL.tar.xz"
tar -xf "tor-browser-linux64-${TOR_VERSION}_ALL.tar.xz"
~/tor-browser_en-US/start-tor-browser.desktop --register-app
create_desktop_entry "Tor Browser" "$HOME/tor-browser_en-US/start-tor-browser.desktop" "tor-browser" "Network;WebBrowser;" "Browsers"

# Function to install Python packages in a virtual environment
install_python_package() {
    local name=$1
    local repo_url=$2
    local folder=$3

    if [ ! -d ~/$name ]; then
        git clone $repo_url ~/$name
        cd ~/$name
        python3 -m venv venv
        source venv/bin/activate
        if [ -f requirements.txt ]; then
            pip install -r requirements.txt
        else
            echo "No requirements.txt file found for $name"
        fi
        deactivate
        create_desktop_entry "$name" "bash -c 'source ~/\"$name\"/venv/bin/activate && python3 ~/$name/$name.py'" "utilities-terminal" "Utility;" "$folder"
    else
        echo "$name directory already exists, skipping clone."
    fi
}

# Install DumpsterDiver
install_python_package "DumpsterDiver" "https://github.com/securing/DumpsterDiver.git" "Data_Analysis"

# Install Exifprobe
if [ ! -d ~/exifprobe ]; then
    git clone https://github.com/hfiguiere/exifprobe.git ~/exifprobe
    cd ~/exifprobe
    make
    sudo make install
    create_desktop_entry "Exifprobe" "/usr/local/bin/exifprobe" "utilities-terminal" "Utility;" "Data_Analysis"
else
    echo "Exifprobe directory already exists, skipping clone."
fi

# Install Stegosuite
sudo apt install -y stegosuite
create_desktop_entry "Stegosuite" "/usr/bin/stegosuite" "stegosuite" "Utility;" "Data_Analysis"

# Install Domainfy (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Domainfy" "pipx run osrframework domainfy" "utilities-terminal" "Utility;" "Domains"

# Install Sublist3r
install_python_package "Sublist3r" "https://github.com/aboul3la/Sublist3r.git" "Domains"

# Install HTTrack
sudo apt install -y httrack
create_desktop_entry "HTTrack" "/usr/bin/httrack" "httrack" "Network;" "Downloaders"

# Install Metagoofil
install_python_package "metagoofil" "https://github.com/opsdisk/metagoofil.git" "Downloaders"

# Install WebHTTrack
sudo apt install -y webhttrack
create_desktop_entry "WebHTTrack" "/usr/bin/webhttrack" "webhttrack" "Network;" "Downloaders"

# Install Youtube-DL
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
create_desktop_entry "Youtube-DL" "/usr/local/bin/youtube-dl" "youtube-dl" "Network;" "Downloaders"

# Install Checkfy (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Checkfy" "pipx run osrframework checkfy" "utilities-terminal" "Utility;" "Email"

# Install Infoga
install_python_package "Infoga" "https://github.com/m4ll0k/Infoga.git" "Email"

# Install Mailfy (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Mailfy" "pipx run osrframework mailfy" "utilities-terminal" "Utility;" "Email"

# Install theHarvester
install_python_package "theHarvester" "https://github.com/laramies/theHarvester.git" "Email"

# Install h8mail
install_python_package "h8mail" "https://github.com/khast3x/h8mail.git" "Email"

# Install OSRFramework using pipx
pipx install osrframework --force
create_desktop_entry "OSRFramework" "pipx run osrframework" "utilities-terminal" "Utility;" "Frameworks"

# Install sn0int
if [ ! -d ~/sn0int ]; then
    git clone https://github.com/kpcyrd/sn0int.git ~/sn0int
    cd ~/sn0int
    ./build.sh
    create_desktop_entry "sn0int" "~/sn0int/sn0int" "utilities-terminal" "Utility;" "Frameworks"
else
    echo "sn0int directory already exists, skipping clone."
fi

# Install Spiderfoot
install_python_package "Spiderfoot" "https://github.com/smicallef/spiderfoot.git" "Frameworks"

# Install Maltego
wget https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v4.2.17.14553.deb
sudo dpkg -i Maltego.v4.2.17.14553.deb
sudo apt --fix-broken install -y
create_desktop_entry "Maltego" "/usr/bin/maltego" "maltego" "Utility;" "Frameworks"

# Install OnionSearch
install_python_package "OnionSearch" "https://github.com/megadose/OnionSearch.git" "Frameworks"

# Install Phonefy (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Phonefy" "pipx run osrframework phonefy" "utilities-terminal" "Utility;" "Phone_Numbers"

# Install PhoneInfoga
install_python_package "PhoneInfoga" "https://github.com/sundowndev/phoneinfoga.git" "Phone_Numbers"

# Install Instaloader
pip3 install instaloader
create_desktop_entry "Instaloader" "instaloader" "utilities-terminal" "Utility;" "Social_Media"

# Install Searchfy (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Searchfy" "pipx run osrframework searchfy" "utilities-terminal" "Utility;" "Social_Media"

# Install Tiktok Scraper
install_python_package "tiktok-scraper" "https://github.com/drawrowfly/tiktok-scraper.git" "Social_Media"

# Install Twayback
install_python_package "Twayback" "https://github.com/humandecoded/twayback.git" "Social_Media"

# Install Stweet
install_python_package "Stweet" "https://github.com/markowanga/stweet.git" "Social_Media"

# Install Alias Generator (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Alias Generator" "pipx run osrframework alias_generator" "utilities-terminal" "Utility;" "Usernames"

# Install Usufy (OSRFramework) using pipx
pipx install osrframework --force
create_desktop_entry "Usufy" "pipx run osrframework usufy" "utilities-terminal" "Utility;" "Usernames"

# Install Photon
install_python_package "Photon" "https://github.com/s0md3v/Photon.git" "Other_Tools"

# Install Sherlock
install_python_package "Sherlock" "https://github.com/sherlock-project/sherlock.git" "Other_Tools"

echo "Installation of OSINT tools completed!"
