#!/bin/bash

# package install
. ./sh/const.sh
for PKG in ${PKGS[@]}
do
    # remove hyphen(-)
    PKGVAR=$(echo $PKG | sed s/-//g)
    if ! type $PKG >/dev/null 2>&1; then
        $PKGMGRSUDO $PKGMGR $PKGMGROPT install $PKG $(eval 'echo $OPT'$PKGMGR$PKGVAR)
    else
        for OPKG in ${OPKGS[@]}
        do
            if [ $PKG = $OPKG ]; then
                $PKGMGRSUDO $PKGMGR $PKGMGROPT install $PKG $(eval 'echo $OPT'$PKGMGR$PKGVAR)
            fi
        done
    fi
done

# package installation of each package manager
case $PKGMGR in
    brew)
        $PKGMGR cask install atom
        apm install package-sync
        ;;
esac

# go
export GOPATH=~/work/go
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/nsf/gocode
go get -u -v github.com/tokuhirom/git-xlsx-textconv
go get -u -v github.com/jingweno/ccat

# emacs
NOW_EMACS_VER=(`emacs --version`)
echo "emacs version ${NOW_EMACS_VER[2]}"

if ! echo ${NOW_EMACS_VER[2]} | grep $INSTALL_EMACS_VER >/dev/null; then
    . ./sh/emacs24_$PKGMGR.sh
fi

emacs -script ~/.emacs.d/setup/setup.el

# neobundle(vim)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)"

# download
mkdir -pv $DF/dl/sh $DF/dl/bin
curl -fsSL -o $DF/dl/sh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -fsSL -o $DF/dl/sh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -fsSL -o $DF/dl/bin/diff-highlight https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight
chmod -v a+x $DF/dl/bin/diff-highlight
