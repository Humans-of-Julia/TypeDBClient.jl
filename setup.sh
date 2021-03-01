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

notify_user y "Please ensure you are at the root level of your GraknClient directory.  Starting script..."
sleep 5
[[ "$(uname -s)" == "Darwin" ]] && notify_user w "Attempting to install GNU Sed" && $PACMAN gnu-sed > /dev/null 2>&1
notify_user w "Attempting to install ProtoBuf"
$PACMAN protobuf > /dev/null 2>&1
julia -E 'import Pkg; Pkg.add("ProtoBuf")' > /dev/null 2>&1
git switch protoc-gen > /dev/null 2>&1
notify_user w "Creating generated directories"
mkdir -p src/generated/protobuf/
notify_user w "Obtaining official GraknLabs protocol files"
git clone https://github.com/graknlabs/protocol.git/ > /dev/null 2>&1
mv protocol/protobuf/* src/generated/protobuf/ && rm -rf protocol
cd src/generated/
notify_user w "Installing additional ProtoBuf dependencies"
git clone https://github.com/JuliaIO/ProtoBuf.jl/ protobuf/ProtoBuf.jl/ > /dev/null 2>&1
julia --project=protobuf/ProtoBuf.jl/ -E 'import Pkg; Pkg.instantiate()' > /dev/null 2>&1
notify_user w "Adding Julia ProtoBuf executable to your path"
export PATH="$PATH:$PWD/protobuf/ProtoBuf.jl/plugin/"
notify_user w "Attempting to install correct version of sed"
if [[ "$(uname -s)" == "Darwin" ]] || [[ "$(uname -s)" == "FreeBSD" ]]; then
	SED="gsed"
else
	SED="sed"
fi
notify_user w "Correcting imports in protocol files"
ls protobuf/
for i in protobuf/*; do # correct imports
	[ "${i##*.}" == "proto" ] || continue
	$SED -i 's|\(import\s\)\"protobuf\/\(.*\.proto\)\"\;|\1\"\2\"\;|g' $i
done
notify_user w "Generating Julia protocol files"
for i in protobuf/*; do # generate files
    [[ -d $i ]] && continue
    [[ $i == "BUILD" ]] || protoc -I=protobuf --julia_out=. $i
done
