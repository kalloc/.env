#!/bin/bash
#bash <(wget --no-check-certificate -q -O - https://raw.github.com/kalloc/dotenv/master/install.sh)

set -e

#some function
function install_pkg() {
    if [[ -f /etc/debian_version ]];then
        echo '[d] install pkg '$*
        apt-get update -qq -yy
        apt-get install -qq -yy $*   
    else
        echo $*" not installed"
    fi
}

if [[ $1 != "" ]];then
    user=$1
elif [[ $0 != "" ]] && [[ $(grep "^$0:" /etc/passwd) != "" ]];then
    user=$0
else
    user=y
fi

if [[ ! -f /etc/debian_version ]]; then
	echo '[E] only Ubuntu or debian supported'
	exit 0
fi

install_pkg git-core mc bash-completion psmisc software-properties-common \
	libffi-dev build-essential python-dev libncursesw5-dev libgdbm-dev libc6-dev \
	zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl \
	bubblewrap mercurial

echo '[i] nick enviroment installer'
#add user
if [ ! "$(id $user 2>/dev/null)" ];then 
	echo '[x] user "'$user'" not found, added'
	useradd -m -s /bin/bash -G sudo $user;
fi

userroot=$(grep ^${user}: /etc/passwd | awk -F: '{print $6}' )
echo "[i] update env for $user ($userroot)"

grep '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers 2>&1 > /dev/null || (
	echo "[i] activate sudo nopasswd mode"
	sed 's/^%sudo.*/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/g' -i /etc/sudoers
)

if [[ ! -e ${userroot}/.nix-profile ]];then
	sudo -H -u y bash -c "bash <(curl https://nixos.org/nix/install)"
fi

sudo -H -u y bash <<EOF
echo install nix
. \$HOME/.nix-profile/etc/profile.d/nix.sh
nix-env -i git neovim mosh exo ripgrep tmux \
	python3.7 python3.7-pip python3.7-pip-tools python3.7-setuptools python3.7-pynvim \
	nodejs \
	 -j8

if [[ ! -e \$HOME/.dotenv ]];then
	git clone https://github.com/kalloc/dotenv \$HOME/.dotenv
else
	(cd \$HOME/.dotenv && git checkout . && git pull)
fi
mkdir -p \$HOME/.ssh; 
chmod 700 \$HOME/.ssh;
mkdir -p \$HOME/.config/coc/extensions;
mkdir -p \$HOME/.config/nvim;
cp \$HOME/.dotenv/authorized_keys \$HOME/.ssh/ && chmod 600 \$HOME/.ssh/authorized_keys
ln -sf \$HOME/.dotenv/.bashrc \$HOME/
ln -sf \$HOME/.dotenv/.bash_export \$HOME/
ln -sf \$HOME/.dotenv/.profile \$HOME/
ln -sf \$HOME/.dotenv/.screenrc \$HOME/
ln -sf \$HOME/.dotenv/.config/coc/extensions/package.json \$HOME/.config/coc/extensions/
ln -sf \$HOME/.dotenv/.config/nvim/coc-settings.json \$HOME/.config/nvim/
ln -sf \$HOME/.dotenv/.config/nvim/init.vim \$HOME/.config/nvim/
ln -sf \$HOME/.dotenv/.tmux.conf \$HOME/
ln -sf \$HOME/.dotenv/.bashrc \$HOME/
ln -sf \$HOME/.dotenv/.bash_aliases \$HOME/
EOF

test $USE_NODEJS && sudo -H -u y bash <<EOF
if [[ ! -r \$HOME/.nvm ]]; then 
echo install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash;
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"
cd && nvm install node
fi

EOF


test $USE_PYTHON && sudo -H -u y bash <<EOF
if [[ ! -r \$HOME/.pyenv ]]; then 
echo install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
export PATH="\$HOME/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
pyenv install 3.7.4
pyenv global 3.7.4
fi
EOF

test $USE_GO && sudo -H -u y bash <<EOF
if [[ ! -r \$HOME/.gvm ]]; then 
echo install gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
. /home/y/.gvm/scripts/gvm
gvm install go1.12.7
gvm use go1.12.7 --default
fi
EOF

test $USE_OCAML && sudo -H -u y bash <<EOF
if [[ ! -r \$HOME/.opam ]]; then 
echo install opam
echo "check_certificate = off" > ~/.wgetrc
sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)
rm -rf ~/.wgetrc
opam init
fi
EOF

test $USE_ELIXIR && sudo -H -u y bash <<EOF
if [[ ! -r \$HOME/.exenv ]]; then 
echo install elixir
git clone git://github.com/mururu/exenv.git ~/.exenv
export PATH="\$HOME/.exenv/bin:\$PATH"
eval "\$(exenv init -)"
wget -O /tmp/elixir.zip https://github.com/elixir-lang/elixir/releases/download/v1.9.1/Precompiled.zip
mkdir  ~/.exenv/versions/1.9.1 -p
cd ~/.exenv/versions/1.9.1 && unzip -qx /tmp/elixir.zip
exenv rehash
exenv global 1.9.1
fi
EOF

test $USE_RUST && sudo -H -u y bash <<EOF
if [[ ! -r \$HOME/.cargo ]]; then 
echo install cargo
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
fi
EOF

sudo -H -u y bash <<EOF

echo install nvim plug

. \$HOME/.nix-profile/etc/profile.d/nix.sh

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -eS -c ":PlugInstall" -c ":xa"
EOF