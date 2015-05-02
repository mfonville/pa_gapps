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
zip -r -Z store gapps_unsigned.zip Core GApps GMSCore META-INF Optional PlayGames SetupWizard bkup_tail.sh g.prop gapps-remove.txt installer.data sizes.prop
now=$(date +"%Y%m%d")
java -Xmx3072m -jar signapk.jar -w testkey.x509.pem testkey.pk8 gapps_unsigned.zip pa_gapps-5.1-$now.zip
rm gapps_unsigned.zip
