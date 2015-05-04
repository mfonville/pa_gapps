#!/bin/sh
#This file is part of The PA GApps script of @mfonville.
#
#    The PA GApps scripts are free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    These scripts are distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#####---------CHECK FOR EXISTANCE OF SOME BINARIES---------
command -v zip >/dev/null 2>&1 || { echo "zip is required but it's not installed.  Aborting." >&2; exit 1; }

#Delete irritating temporary files
#find ./ -name '*~' | xargs rm

if [ -f "gapps_unsigned.zip" ]
then
	rm gapps_unsigned.zip
fi

#Zip quietly, recursive BUT WITHOUT THE DIRECTORIES (or flashing wil fail), with maximum compression, and exclude those irritating temporary files
zip -q -r -D -X -9 gapps_unsigned.zip Core GApps GMSCore Optional PlayGames META-INF bkup_tail.sh g.prop gapps-remove.txt installer.data sizes.prop -x\*~

now=$(date +"%Y%m%d")
if [ -f "pa_gapps-5.1-$now.zip" ]
then
	rm pa_gapps-5.1-$now.zip
fi
./signapk.sh sign gapps_unsigned.zip pa_gapps-5.1-$now.zip
if [ $? -eq 0 ]; then #if signing did succeed
    rm gapps_unsigned.zip
fi

