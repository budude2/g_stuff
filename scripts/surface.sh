#!/bin/bash
wget -O $GEMPAK/data/$(date -u +%Y%m%d)_sao.gem http://motherlode.ucar.edu/decoded/gempak/surface/$(date -u +%Y%m%d)_sao.gem

#Create the postscript file of the map.
sfmap << EOF
restore /home/gempak/script/US.nts
SFFILE = $GEMPAK/data/$(date -u +%Y%m%d)_sao.gem
DATTIM = $(date -u +%y%m%d/%k)00
r
 
EOF

#Add EOF to file, and convert to a pdf
gpend
ps2pdf map /home/gempak/g_stuff/maps/$(date -u +%m%d%Y_%k)00.pdf
rm map

#Upload PDF to github
cd /home/gempak/g_stuff
git add ./maps/$(date -u +%m%d%Y_%k)00.pdf
git commit -m "$(date -u +%m%d%Y_%k)00.pdf"
git push
