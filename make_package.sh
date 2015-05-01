#!/bin/sh
zip -r gapps_unsigned.zip Core GApps GMSCore META-INF Optional PlayGames SetupWizerd bkup_tail.sh g.prop gapps-remove.txt installer.data sizes.prop
java -Xmx2048m -jar signapk.jar -w testkey.x509.pem testkey.pk8 gapps_unsigned.zip pa_gapps.zip
rm gapps_unsigned.zip
