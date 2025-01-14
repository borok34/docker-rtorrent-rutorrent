#!/usr/bin/with-contenv bash
# create .autodl config dir and link
[[ ! -d /config/.autodl ]] && (mkdir /config/.autodl && chown -R ${PUID}:${PGID} /config/.autodl)
[[ ! -d /home/abc ]] && (mkdir /home/abc && chown -R abc:abc /home/abc)

# get rutorrent plugin
[[ ! -d /usr/share/webapps/rutorrent/plugins/autodl-irssi/.git ]] && (git clone https://github.com/autodl-community/autodl-rutorrent.git /usr/share/webapps/rutorrent/plugins/autodl-irssi && \
chown -R abc:abc /usr/share/webapps/rutorrent/plugins/autodl-irssi/)

# get autodl script for irssi
[[ ! -d /config/.irssi/scripts/.git ]] && (mkdir -p /config/.irssi/scripts && \
  git clone https://github.com/autodl-community/autodl-irssi.git /config/.irssi/scripts && \
  mkdir /config/.irssi/scripts/autorun && \
  ln -s /config/.irssi/scripts/autodl-irssi.pl /config/.irssi/scripts/autorun/autodl-irssi.pl && \
  chown -R ${PUID}:${PGID} /config/.irssi )

# get updated trackers for irssi-autodl
wget --quiet -O /tmp/trackers.zip https://github.com/autodl-community/autodl-trackers/archive/master.zip && \
[[ ! -d /config/.irssi/scripts/AutodlIrssi/trackers ]] && mkdir -p /config/.irssi/scripts/AutodlIrssi/trackers && \
cd /config/.irssi/scripts/AutodlIrssi/trackers && \
unzip -q -o -j /tmp/trackers.zip && \
rm /tmp/trackers.zip

# update rutorrent plugin
cd /usr/share/webapps/rutorrent/plugins/autodl-irssi/ || exit
git pull
chown -R abc:abc /usr/share/webapps/rutorrent/plugins/autodl-irssi

# make sure perl is in irssi startup
echo "load perl" > /config/.irssi/startup

# symlink autodl/irssi folders to root
ln -s /config/.autodl /root/.autodl
ln -s /config/.irssi /root/.irssi
chown -R abc:abc /root/.autodl
chown -R abc:abc /root/.irssi

# update autodl script for irssi
cd /config/.irssi/scripts || exit
git pull
chown -R abc:abc /config/.irssi
