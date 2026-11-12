select var in "ubuntu" "Redhat"
do 
done 
: '
# Install essential tools
sudo apt update
sudo apt install -y build-essential gdb cmake

# Install optional tools
sudo apt install -y valgrind cppcheck doxygen graphviz

clear
echo ""
echo "======================================="
echo "Development environment ready!"
echo "Tools installed:"
echo "- GCC/G++: $(g++ --version | head -1)"
echo "- GDB: $(gdb --version | head -1)" 
echo "- CMake: $(cmake --version | head -1)"
echo "======================================="
'
#==================Redhat========================#
: '

Key Differences on Red Hat:

    build-essential does not exist on RHEL; instead, use sudo dnf groupinstall "Development Tools", which installs GCC, G++, make, and other core compilation utilities.

    EPEL Repository: Packages like cppcheck are often hosted in the Extra Packages for Enterprise Linux (EPEL) repository. If dnf cannot find cppcheck, run sudo dnf install -y epel-release first.
'

: ' 

# Update system packages
sudo dnf upgrade -y

# Install the Development Tools group (equivalent to build-essential)
sudo dnf groupinstall -y "Development Tools"

# Install CMake and GDB
sudo dnf install -y cmake gdb

# Install optional tools
# Note: If cppcheck or other packages are not found, make sure EPEL repository is enabled:
# sudo dnf install -y epel-release
sudo dnf install -y valgrind cppcheck doxygen graphviz

echo "Development environment ready!"
echo "Tools installed:"
echo "- GCC/G++: $(g++ --version | head -1)"
echo "- GDB: $(gdb --version | head -1)" 
echo "- CMake: $(cmake --version | head -1)"
'
