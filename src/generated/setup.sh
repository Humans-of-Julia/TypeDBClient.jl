# get os
if [[ $(uname -s) == "Darwin" ]]
then
    KERNEL="Darwin"
    OS="macos"
elif [[ $(uname -s) == "Linux" ]]
then
    KERNEL="Linux"
    if [[ -f /etc/arch-release ]]
    then
        OS="arch"
    elif [[ -f /etc/debian_version ]]
    then
        OS="debian"
    elif [[ -f /etc/redhat-release ]]
    then
        OS="fedora"
    fi
else
	echo "Could not determine system"
    exit 1
fi

SED_PACKAGE='sed'
JULIA_PACKAGE='julia'

case $OS in
    macos)
		SED_PACKAGE='gnu-sed'
        ;;
    arch)
        ;;
    debian)
        ;;
    fedora)
        ;;
esac

if command -v brew > /dev/null 2>&1
then
    PACMAN='brew install'
    PACSEARCH='brew list --formula'
    PACAPPSEARCH='brew list --cask'
    PACAPP='brew cask install'
else
    declare -A osInfo;
    osInfo[/etc/redhat-release]='sudo dnf --assumeyes install'
    osInfo[/etc/arch-release]='sudo pacman -S --noconfirm'
    osInfo[/etc/gentoo-release]='sudo emerge'
    osInfo[/etc/SuSE-release]='sudo zypper in'
    osInfo[/etc/debian_version]='sudo apt-get --assume-yes install'
    
    declare -A osSearch;
    osSearch[/etc/redhat-release]='dnf list installed'
    osSearch[/etc/arch-release]='pacman -Qq'
    osSearch[/etc/gentoo-release]="cd /var/db/pkg/ && ls -d */*| sed 's/\/$//'"
    osSearch[/etc/SuSE-release]='rpm -qa'
    osSearch[/etc/debian_version]='dpkg -l' # previously `apt list --installed`.  Can use `sudo apt-cache search`.
    
    for f in "${!osInfo[@]}"
    do
        if [[ -f $f ]];then
            PACMAN="${osInfo[$f]}"
            PACAPP="${osInfo[$f]}"
        fi
    done
    
    for s in "${!osSearch[@]}"
    do
        if [[ -f $s ]];then
            PACSEARCH="${osSearch[$s]}"
            PACAPPSEARCH="${osSearch[$s]}"
        fi
    done
fi

notify_user() {
    case ${1} in
        w) echo -e "\u001b[1;34m===>\u001b[0;38m\t\u001b[1;38m${2}\u001b[0;38m" ;;
        g) echo -e "\u001b[1;34m===>\u001b[0;38m\t\u001b[1;38;5;2m${2}\u001b[0;38m" ;;
        y) echo -e "\u001b[1;34m===>\u001b[0;38m\t\u001b[1;33m${2}\u001b[0;38m" ;;
        r) echo -e "\u001b[1;34m===>\u001b[0;38m\t\u001b[1;31m${2}\u001b[0;38m" ;;
        i) echo -e "\u001b[1;34m===>\u001b[0;38m\t\u001b[0;3;38m${2}\u001b[0;38m" ;;
        *) echo -e "\u001b[1;34m===>\u001b[0;38m\t\u001b[1;38m${2}\u001b[0;38m" ;;
    esac
}

# define functions for printing messages
sayisfying_deps() {
    notify_user w 'Satisfying dependencies...'
}

deps_satisfied() {
    notify_user g 'Dependencies satisfied.'
}

error_occurred() {
    if [[ $OS == "arch" ]]
    then
        notify_user r 'It seems an error has occurred in the satiation of your dependencies. You may need to manually download the package using the AUR.'
    else
        notify_user r 'It seems an error has occurred in the satiation of your dependencies.'
    fi
}

installing_package_message() {
    notify_user i "Installing ${1}"
}

satisfy_packages() {
    if [[ $MISSING_DEPENDENCIES == true ]]
    then
        satisfying_deps
    fi
}


are_deps_satisfied() {
    if [[ $DEPS_DOWNLOADED == true ]]
    then
        if [[ $COUNTER_MISSING == $COUNTER_DOWNLOADED ]]
        then
            deps_satisfied
        fi
    else
        if [[ $MISSING_DEPENENCIES == true ]]
        then
            error_occurred
            # exit 1
        fi
    fi
}


install_command() {
    PACINSTALL=false
    
    installing_package_message "${1}"
    $PACMAN "${1}" && \
        PACINSTALL=true
    
    if $PACINSTALL
    then
        return 0
    else
        exit 1
    fi
}


is_command_then_install() {
    # boolean for checking if we need to install commands
    MISSING_DEPENDENCIES=false
    DEPS_DOWNLOADED=false
    COUNTER_MISSING=0
    COUNTER_DOWNLOADED=0
    
    local comm
    
    # check if commands exist and update counter
    for comm in "${@}"
    do
        # check for missing commands
        if ! command -v "${comm}" > /dev/null 2>&1
        then
            MISSING_DEPENDENCIES=true
            COUNTER_MISSING=$((COUNTER_MISSING+1))
        fi
    done
    
    # echo dependencies if needed
    satisfy_packages
    
    # install dependencies if command is not found
    for comm in "${@}"
    do
        if ! command -v "${comm}" > /dev/null 2>&1
        then
            install_command "${comm}" && \
                DEPS_DOWNLOADED=true
                
            if [[ $DEPS_DOWNLOADED == true ]]
            then
                COUNTER_DOWNLOADED=$((COUNTER_DOWNLOADED+1))
            fi
        fi
    done
    
    # echo if dependencies are satisfied
    are_deps_satified
}

is_command_then_install $SED_PACKAGE

notify_user y "Please ensure you are at the root level of your GraknClient directory.  Starting script..."
sleep 5
notify_user w "Attempting to install ProtoBuf"
$PACMAN protobuf > /dev/null
julia -E 'import Pkg; Pkg.add("ProtoBuf")' > /dev/null
git switch protoc-gen > /dev/null
notify_user w "Creating generated directories"
mkdir -p src/generated/protobuf/
notify_user w "Obtaining official GraknLabs protocol files"
git clone https://github.com/graknlabs/protocol.git/ > /dev/null
mv protocol/protobuf/* src/generated/protobuf/ && rm -rf protocol
cd src/generated/
notify_user w "Installing additional ProtoBuf dependencies"
git clone https://github.com/JuliaIO/ProtoBuf.jl/ protobuf/ProtoBuf.jl/ > /dev/null
julia --project=protobuf/ProtoBuf.jl/ -E 'import Pkg; Pkg.instantiate()' > /dev/null
notify_user w "Adding Julia ProtoBuf executable to your path"
echo 'export PATH="$PATH:'$PWD'/protobuf/ProtoBuf.jl/plugin/"' >> $HOME/.bashrc && . $HOME/.bashrc # INSERT DIR PATH HERE
notify_user w "Attempting to install correct version of sed"
if [[ "$(uname -s)" == "Darwin" ]] || [[ "$(uname -s)" == "FreeBSD" ]]; then
	$PACMAN gsed
	SED="gsed"
else
	SED="sed"
fi
notify_user w "Correcting imports in protocol files"
for i in protobuf/*; do # correct imports
	[ "${file##*.}" == "proto" ] || continue
	$SED -i 's|\(import\s\)\"protobuf\/\(.*\.proto\)\"\;|\1\"\2\"\;|g' $i
done
notify_user w "Generating Julia protocol files"
for i in protobuf/*; do # generate files
    [[ -d $i ]] && continue
    [[ $i == "BUILD" ]] || protoc -I=protobuf --julia_out=. $i
done
