chmod +x git-branch-manager/agt
[ -L /usr/local/bin/agt ] && echo "/usr/local/bin/agt exist, will relink"
ln -sf `pwd`/git-branch-manager/agt /usr/local/bin
