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
#####A helpful recursive copy script to install files to the correct location
copy() {
	if [ -d "$1" ]
		then
		for f in $1/*; do
			copy $f "$2/$(basename $f)"
		done
	fi
	if [ -f "$1" ]
		then
  		install -D -p $1 $2
	fi
}
#####---------CHECK FOR EXISTANCE OF SOME BINARIES---------
command -v install >/dev/null 2>&1 || { echo "coreutils is required but it's not installed.  Aborting." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip is required but it's not installed.  Aborting." >&2; exit 1; }
command -v zip >/dev/null 2>&1 || { echo "zip is required but it's not installed.  Aborting." >&2; exit 1; }
command -v zipalign >/dev/null 2>&1 || { echo "zipalign is required but it's not installed.  Aborting." >&2; exit 1; }
#####---------FIRST THE SPECIAL CASES---------
#GMSCore
#We try to find always the latest version apk that is found in the directory per dpi
gms0=`find SourceAPKs/ -iname '*com.google.android.gms*430)*' | sort -r | head -1`
gms4=`find SourceAPKs/ -iname '*com.google.android.gms*434)*' | sort -r | head -1`
gms6=`find SourceAPKs/ -iname '*com.google.android.gms*436)*' | sort -r | head -1`
gms8=`find SourceAPKs/ -iname '*com.google.android.gms*438)*' | sort -r | head -1`
#For the common parts, we try the latest version available of any dpi
gmscommon=`find SourceAPKs/ -iname '*com.google.android.gms*43*)*' | sort -r | head -1`

rm GMSCore/0/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
rm GMSCore/4/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
rm GMSCore/6/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
rm GMSCore/8/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk

zip -q -U $gms0 -O GMSCore/0/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude lib*
zip -q -U $gms4 -O GMSCore/4/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude lib*
zip -q -U $gms6 -O GMSCore/6/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude lib*
zip -q -U $gms8 -O GMSCore/8/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude lib*
unzip -q -j -o $gmscommon -d GMSCore/common/priv-app/PrebuiltGmsCore/lib/arm lib*

#Keyboard Lib
keybd_lib=`find SourceAPKs/ -iname 'libjni_latinimegoogle.so' | head -1`
copy $keybd_lib "Optional/keybd_lib/lib/"

#PlayGames
#We try to find always the latest version apk that is found in the directory per dpi
pg0=`find SourceAPKs/ -iname '*com.google.android.play.games*000)*' | sort -r | head -1`
pg4=`find SourceAPKs/ -iname '*com.google.android.play.games*004)*' | sort -r | head -1`
pg6=`find SourceAPKs/ -iname '*com.google.android.play.games*006)*' | sort -r | head -1`
pg8=`find SourceAPKs/ -iname '*com.google.android.play.games*008)*' | sort -r | head -1`

rm PlayGames/0/app/PlayGames/PlayGames.apk
rm PlayGames/4/app/PlayGames/PlayGames.apk
rm PlayGames/6/app/PlayGames/PlayGames.apk
rm PlayGames/8/app/PlayGames/PlayGames.apk

zip -q -U $pg0 -O PlayGames/0/app/PlayGames/PlayGames.apk --exclude lib*
zip -q -U $pg4 -O PlayGames/4/app/PlayGames/PlayGames.apk --exclude lib*
zip -q -U $pg6 -O PlayGames/6/app/PlayGames/PlayGames.apk --exclude lib*
zip -q -U $pg8 -O PlayGames/8/app/PlayGames/PlayGames.apk --exclude lib*

#####---------CORE APPLICATIONS---------
contactsync=`find SourceAPKs/ -iname 'GoogleContactsSyncAdapter.apk' | head -1`
copy $contactsync "Core/required/app/GoogleContactsSyncAdapter/"

etcpermissions=`find SourceAPKs/ -iname 'permissions' | head -1`
copy $etcpermissions "Core/required/etc/permissions/"

etcpreferredapps=`find SourceAPKs/ -iname 'preferred-apps' | head -1`
copy $etcpreferredapps "Core/required/etc/preferred-apps/"

framework=`find SourceAPKs/ -iname 'framework' | head -1`
copy $framework "Core/required/framework/"

privapp=`find SourceAPKs/ -iname 'priv-app' | head -1`
copy $privapp "Core/required/priv-app/"

#Android vending, the Play Store, is called PhoneSky if part of the Nexus Image:
#Store
store=`find SourceAPKs/ -iname '*com.android.vending*' | sort -r | head -1`
rm Core/required/priv-app/Phonesky/Phonesky.apk
zip -q -U $store -O Core/required/priv-app/Phonesky/Phonesky.apk --exclude lib*


#####---------NOW THE GENERIC PACKAGES---------
#Books
books=`find SourceAPKs/ -iname '*com.google.android.apps.books*' | sort -r | head -1`
rm GApps/books/app/Books/Books.apk
zip -q -U $books -O GApps/books/app/Books/Books.apk --exclude lib*

#Calendar
calendar=`find SourceAPKs/ -iname '*com.google.android.calendar*' | sort -r | head -1`
rm GApps/calendargoogle/app/CalendarGooglePrebuilt/CalendarGooglePrebuilt.apk
zip -q -U $calendar -O GApps/calendargoogle/app/CalendarGooglePrebuilt/CalendarGooglePrebuilt.apk --exclude lib*

#GoogleCalendarSyncAdapter (calsync) is not updated anymore(!) This is just a trivial line though
calsync=`find SourceAPKs/ -iname 'GoogleCalendarSyncAdapter.apk' | sort -r | head -1`
rm GApps/calsync/app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
zip -q -U $calsync -O GApps/calsync/app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk --exclude lib*

#Camera
camera=`find SourceAPKs/ -iname '*com.google.android.googlecamera*' | sort -r | head -1`
rm GApps/cameragoogle/app/GoogleCamera/GoogleCamera.apk
zip -q -U $camera -O GApps/cameragoogle/app/GoogleCamera/GoogleCamera.apk --exclude lib*
unzip -q -j -o $camera -d GApps/cameragoogle/app/GoogleCamera/lib/arm lib*

#Chrome
chrome=`find SourceAPKs/ -iname '*com.android.chrome*' | sort -r | head -1`
rm GApps/chrome/app/Chrome/Chrome.apk
zip -q -U $chrome -O GApps/chrome/app/Chrome/Chrome.apk --exclude lib*
unzip -q -j -o $chrome -d GApps/chrome/app/Chrome/lib/arm lib*

#Cloudprint
cloudprint=`find SourceAPKs/ -iname '*com.google.android.apps.cloudprint*' | sort -r | head -1`
rm GApps/cloudprint/app/CloudPrint2/CloudPrint2.apk
zip -q -U $cloudprint -O GApps/cloudprint/app/CloudPrint2/CloudPrint2.apk --exclude lib*

#Docs
docs=`find SourceAPKs/ -iname '*com.google.android.apps.docs.editors.docs*' | sort -r | head -1`
rm GApps/docs/app/EditorsDocs/EditorsDocs.apk
zip -q -U $docs -O GApps/docs/app/EditorsDocs/EditorsDocs.apk --exclude lib*
unzip -q -j -o $docs -d GApps/docs/app/EditorsDocs/lib/arm lib*

#Drive CAREFUL, mind the extra dash at the pattern end, to not by accident select docs/sheets/slides
drive=`find SourceAPKs/ -iname '*com.google.android.apps.docs-*' | sort -r | head -1`
rm GApps/drive/app/Drive/Drive.apk
zip -q -U $drive -O GApps/drive/app/Drive/Drive.apk --exclude lib*
unzip -q -j -o $drive -d GApps/drive/app/Drive/lib/arm lib*

#Ears
ears=`find SourceAPKs/ -iname '*com.google.android.ears*' | sort -r | head -1`
rm GApps/ears/app/GoogleEars/GoogleEars.apk
zip -q -U $ears -O GApps/ears/app/GoogleEars/GoogleEars.apk --exclude lib*
unzip -q -j -o $ears -d GApps/ears/app/GoogleEars/lib/arm lib*

#Earth
earth=`find SourceAPKs/ -iname '*com.google.earth*' | sort -r | head -1`
rm GApps/earth/app/GoogleEarth/GoogleEarth.apk
zip -q -U $earth -O GApps/earth/app/GoogleEarth/GoogleEarth.apk --exclude lib*
unzip -q -j -o $earth -d GApps/earth/app/GoogleEarth/lib/arm lib*

#Exchange
exchange=`find SourceAPKs/ -iname '*com.google.android.gm.exchange*' | sort -r | head -1`
rm GApps/exchangegoogle/app/PrebuiltExchange3Google/PrebuiltExchange3Google.apk
zip -q -U $exchange -O GApps/exchangegoogle/app/PrebuiltExchange3Google/PrebuiltExchange3Google.apk --exclude lib*

#FaceLock (from Nexus sources)
facelock=`find SourceAPKs/ -iname 'FaceLock.apk' | head -1`
copy $facelock "GApps/faceunlock/app/FaceLock/"
facelocklib=`find SourceAPKs/ -iname 'libfacelock_jni.so' | head -1`
copy $facelocklib "GApps/faceunlock/lib/"
pittpatt=`find SourceAPKs/ -iname 'pittpatt' | head -1`
copy $pittpatt "GApps/faceunlock/vendor/pittpatt"

#Gmail CAREFUL, mind the extra dash at the pattern end, to not by accident select GMS
gmail=`find SourceAPKs/ -iname '*com.google.android.gm-*' | sort -r | head -1`
rm GApps/gmail/app/PrebuiltGmail/PrebuiltGmail.apk
zip -q -U $gmail -O GApps/gmail/app/PrebuiltGmail/PrebuiltGmail.apk --exclude lib*

#GoogleNow
googlenow=`find SourceAPKs/ -iname '*com.google.android.launcher*' | sort -r | head -1`
rm GApps/googlenow/app/GoogleHome/GoogleHome.apk
zip -q -U $googlenow -O GApps/googlenow/app/GoogleHome/GoogleHome.apk --exclude lib*

#GooglePlus
googleplus=`find SourceAPKs/ -iname '*com.google.android.apps.plus*' | sort -r | head -1`
rm GApps/googleplus/app/PlusOne/PlusOne.apk
zip -q -U $googleplus -O GApps/googleplus/app/PlusOne/PlusOne.apk --exclude lib*
unzip -q -j -o $googleplus -d GApps/googleplus/app/PlusOne/lib/arm lib*

#GoogleTTS
googletts=`find SourceAPKs/ -iname '*com.google.android.tts*' | sort -r | head -1`
rm GApps/googletts/app/GoogleTTS/GoogleTTS.apk
zip -q -U $googletts -O GApps/googletts/app/GoogleTTS/GoogleTTS.apk --exclude lib*
unzip -q -j -o $googletts -d GApps/googletts/app/GoogleTTS/lib/arm lib*

#Hangouts
hangouts=`find SourceAPKs/ -iname '*com.google.android.talk*' | sort -r | head -1`
rm GApps/hangouts/priv-app/Hangouts/Hangouts.apk
zip -q -U $hangouts -O GApps/hangouts/priv-app/Hangouts/Hangouts.apk --exclude lib*
unzip -q -j -o $hangouts -d GApps/hangouts/priv-app/Hangouts/lib/arm lib*

#Keep
keep=`find SourceAPKs/ -iname '*com.google.android.keep*' | sort -r | head -1`
rm GApps/keep/app/PrebuiltKeep/PrebuiltKeep.apk
zip -q -U $keep -O GApps/keep/app/PrebuiltKeep/PrebuiltKeep.apk --exclude lib*

#Keyboard
keybd=`find SourceAPKs/ -iname '*com.google.android.inputmethod.latin*' | sort -r | head -1`
rm GApps/keyboardgoogle/app/LatinImeGoogle/LatinImeGoogle.apk
zip -q -U $keybd -O GApps/keyboardgoogle/app/LatinImeGoogle/LatinImeGoogle.apk --exclude lib*
unzip -q -j -o $keybd -d GApps/keyboardgoogle/app/LatinImeGoogle/lib/arm lib*

#Maps
maps=`find SourceAPKs/ -iname '*com.google.android.apps.maps*' | sort -r | head -1`
rm GApps/maps/app/Maps/Maps.apk
zip -q -U $maps -O GApps/maps/app/Maps/Maps.apk --exclude lib*
unzip -q -j -o $maps -d GApps/maps/app/Maps/lib/arm lib*

#Messenger
messenger=`find SourceAPKs/ -iname '*com.google.android.apps.messaging*' | sort -r | head -1`
rm GApps/messenger/app/PrebuiltBugle/PrebuiltBugle.apk
zip -q -U $messenger -O GApps/messenger/app/PrebuiltBugle/PrebuiltBugle.apk --exclude lib*
unzip -q -j -o $messenger -d GApps/messenger/app/PrebuiltBugle/lib/arm lib*

#Movies
movies=`find SourceAPKs/ -iname '*com.google.android.videos*' | sort -r | head -1`
rm GApps/movies/app/Videos/Videos.apk
zip -q -U $movies -O GApps/movies/app/Videos/Videos.apk --exclude lib*
unzip -q -j -o $movies -d GApps/movies/app/Videos/lib/arm lib*

#Music
music=`find SourceAPKs/ -iname '*com.google.android.music*' | sort -r | head -1`
rm GApps/music/app/Music2/Music2.apk
zip -q -U $music -O GApps/music/app/Music2/Music2.apk --exclude lib*

#Newsstand
newsstand=`find SourceAPKs/ -iname '*com.google.android.apps.magazines*' | sort -r | head -1`
rm GApps/newsstand/app/Newsstand/Newsstand.apk
zip -q -U $newsstand -O GApps/newsstand/app/Newsstand/Newsstand.apk --exclude lib*

#Newswidget
newswidget=`find SourceAPKs/ -iname '*com.google.android.apps.genie.geniewidget*' | sort -r | head -1`
rm GApps/newswidget/app/PrebuiltNewsWeather/PrebuiltNewsWeather.apk
zip -q -U $newswidget -O GApps/newswidget/app/PrebuiltNewsWeather/PrebuiltNewsWeather.apk --exclude lib*

#Search
search=`find SourceAPKs/ -iname '*com.google.android.googlequicksearchbox*' | sort -r | head -1`
rm GApps/search/priv-app/Velvet/Velvet.apk
zip -q -U $search -O GApps/search/priv-app/Velvet/Velvet.apk --exclude lib*
unzip -q -j -o $search -d GApps/search/priv-app/Velvet/lib/arm lib*

#Sheets
sheets=`find SourceAPKs/ -iname '*com.google.android.apps.docs.editors.sheets*' | sort -r | head -1`
rm GApps/sheets/app/EditorsSheets/EditorsSheets.apk
zip -q -U $sheets -O GApps/sheets/app/EditorsSheets/EditorsSheets.apk --exclude lib*
unzip -q -j -o $sheets -d GApps/sheets/app/EditorsSheets/lib/arm lib*

#Slides
slides=`find SourceAPKs/ -iname '*com.google.android.apps.docs.editors.slides*' | sort -r | head -1`
rm GApps/slides/app/EditorsSlides/EditorsSlides.apk
zip -q -U $slides -O GApps/slides/app/EditorsSlides/EditorsSlides.apk --exclude lib*
unzip -q -j -o $slides -d GApps/slides/app/EditorsSlides/lib/arm lib*

#Speech (from Nexus sources)
speech=`find SourceAPKs/ -iname 'srec' | head -1`
copy $speech "GApps/speech/usr/srec"

#Street
street=`find SourceAPKs/ -iname '*com.google.android.street*' | sort -r | head -1`
rm GApps/street/app/Street/Street.apk
zip -q -U $street -O GApps/street/app/Street/Street.apk --exclude lib*

#Talkback
talkback=`find SourceAPKs/ -iname '*com.google.android.marvin.talkback*' | sort -r | head -1`
rm GApps/talkback/app/talkback/talkback.apk
zip -q -U $talkback -O GApps/talkback/app/talkback/talkback.apk --exclude lib*

#Wallet
wallet=`find SourceAPKs/ -iname '*com.google.android.apps.walletnfcrel*' | sort -r | head -1`
rm GApps/wallet/priv-app/Wallet/Wallet.apk
zip -q -U $wallet -O GApps/wallet/priv-app/Wallet/Wallet.apk --exclude lib*
unzip -q -j -o $wallet -d GApps/wallet/priv-app/Wallet/lib/arm lib*

#Youtube
youtube=`find SourceAPKs/ -iname '*com.google.android.youtube*' | sort -r | head -1`
rm GApps/youtube/app/YouTube/YouTube.apk
zip -q -U $youtube -O GApps/youtube/app/YouTube/YouTube.apk --exclude lib*
unzip -q -j -o $youtube -d GApps/youtube/app/YouTube/lib/arm lib*

#####---------ALIGN THE APKS---------
for f in `find ./ -name '*.apk' | grep -v SourceAPKs`; do
        mv $f $f.orig
        zipalign 4 $f.orig $f
        rm $f.orig
done
