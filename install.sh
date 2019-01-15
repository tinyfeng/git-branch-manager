cd ~/agt
chmod +x agt
[ -L /usr/local/bin/agt ] && echo "/usr/local/bin/agt exist, will relink"
ln -sf `pwd`/agt /usr/local/bin
