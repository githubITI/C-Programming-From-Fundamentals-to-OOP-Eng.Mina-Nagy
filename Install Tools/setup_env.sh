#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
echo "======================================="
echo "Detecting operating system distribution..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    DISTRO_LIKE=$ID_LIKE
else
    echo "Error: /etc/os-release not found. Cannot detect distribution."
    exit 1
fi

echo "Detected: $DISTRO"

echo "======================================="
sleep 10
# Check if Debian or Ubuntu based
if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" || "$DISTRO_LIKE" == *"debian"* ]]; then
    echo "-> Debian/Ubuntu system detected. Using apt..."
    
    sudo apt update
    sudo apt install -y build-essential gdb cmake
    sudo apt install -y valgrind cppcheck doxygen graphviz

# Check if Red Hat based (Fedora, RHEL, Rocky, Alma, CentOS)
elif [[ "$DISTRO" == "fedora" || "$DISTRO" == "rhel" || "$DISTRO" == "rocky" || "$DISTRO" == "almalinux" || "$DISTRO" == "centos" || "$DISTRO_LIKE" == *"rhel"* || "$DISTRO_LIKE" == *"fedora"* ]]; then
    echo "-> Red Hat-based system detected. Using dnf..."
    
    sudo dnf upgrade -y
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf install -y cmake gdb
    
    # Enable EPEL repository for tools like cppcheck
    sudo dnf install -y epel-release
    sudo dnf install -y valgrind cppcheck doxygen graphviz

else
    echo "Error: Unsupported distribution ($DISTRO)."
    echo "This script supports Debian/Ubuntu and Red Hat-based distributions."
    exit 1
fi

# Clear screen and display success banner with versions
clear
echo ""
echo "======================================="
echo "Development environment ready!"
echo "Tools installed:"
echo "- GCC/G++: $(g++ --version | head -1)"
echo "- GDB: $(gdb --version | head -1)" 
echo "- CMake: $(cmake --version | head -1)"
echo "======================================="
