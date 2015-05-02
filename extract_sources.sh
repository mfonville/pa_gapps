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

zip -U $gms0 -O GMSCore/0/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
zip -U $gms4 -O GMSCore/4/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
zip -U $gms6 -O GMSCore/6/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
zip -U $gms8 -O GMSCore/8/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $gmscommon -d GMSCore/common/priv-app/PrebuiltGmsCore/lib/arm lib*

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

zip -U $pg0 -O PlayGames/0/app/PlayGames/PlayGames.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
zip -U $pg4 -O PlayGames/4/app/PlayGames/PlayGames.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
zip -U $pg6 -O PlayGames/6/app/PlayGames/PlayGames.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
zip -U $pg8 -O PlayGames/8/app/PlayGames/PlayGames.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

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

#####---------NOW THE GENERIC PACKAGES---------
#Books
books=`find SourceAPKs/ -iname '*com.google.android.apps.books*' | sort -r | head -1`
rm GApps/books/app/Books/Books.apk
zip -U $books -O GApps/books/app/Books/Books.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Calendar
calendar=`find SourceAPKs/ -iname '*com.google.android.calendar*' | sort -r | head -1`
rm GApps/calendargoogle/app/CalendarGooglePrebuilt/CalendarGooglePrebuilt.apk
zip -U $calendar -O GApps/calendargoogle/app/CalendarGooglePrebuilt/CalendarGooglePrebuilt.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#GoogleCalendarSyncAdapter (calsync) is not updated anymore(!) This is just a trivial line though
calsync=`find SourceAPKs/ -iname 'GoogleCalendarSyncAdapter.apk' | sort -r | head -1`
rm GApps/calsync/app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
zip -U $calendar -O GApps/calsync/app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Camera
camera=`find SourceAPKs/ -iname '*com.google.android.googlecamera*' | sort -r | head -1`
rm GApps/cameragoogle/app/GoogleCamera/GoogleCamera.apk
zip -U $camera -O GApps/cameragoogle/app/GoogleCamera/GoogleCamera.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $camera -d GApps/cameragoogle/app/GoogleCamera/lib/arm lib*

#Chrome
chrome=`find SourceAPKs/ -iname '*com.android.chrome*' | sort -r | head -1`
rm GApps/chrome/app/Chrome/Chrome.apk
zip -U $chrome -O GApps/chrome/app/Chrome/Chrome.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $chrome -d GApps/chrome/app/Chrome/Chrome/lib/arm lib*

#Cloudprint
cloudprint=`find SourceAPKs/ -iname '*com.google.android.apps.cloudprint*' | sort -r | head -1`
rm GApps/cloudprint/app/CloudPrint2/CloudPrint2.apk
zip -U $cloudprint -O GApps/cloudprint/app/CloudPrint2/CloudPrint2.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Docs
docs=`find SourceAPKs/ -iname '*com.google.android.apps.docs.editors.docs*' | sort -r | head -1`
rm GApps/docs/app/EditorsDocs/EditorsDocs.apk
zip -U $docs -O GApps/docs/app/EditorsDocs/EditorsDocs.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $docs -d GApps/docs/app/EditorsDocs/lib/arm lib*

#Drive CAREFUL, mind the extra dash at the pattern end, to not by accident select docs/sheets/slides
drive=`find SourceAPKs/ -iname '*com.google.android.apps.docs-*' | sort -r | head -1`
rm GApps/drive/app/Drive/Drive.apk
zip -U $drive -O GApps/drive/app/Drive/Drive.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $drive -d GApps/drive/app/Drive/lib/arm lib*

#Ears
ears=`find SourceAPKs/ -iname '*com.google.android.ears*' | sort -r | head -1`
rm GApps/ears/app/GoogleEars/GoogleEars.apk
zip -U $ears -O GApps/ears/app/GoogleEars/GoogleEars.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $ears -d GApps/ears/app/GoogleEars/lib/arm lib*

#Earth
earth=`find SourceAPKs/ -iname '*com.google.earth*' | sort -r | head -1`
rm GApps/earth/app/GoogleEarth/GoogleEarth.apk
zip -U $earth -O GApps/earth/app/GoogleEarth/GoogleEarth.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $earth -d GApps/earth/app/GoogleEarth/lib/arm lib*

#Exchange
exchange=`find SourceAPKs/ -iname '*com.google.android.gm.exchange*' | sort -r | head -1`
rm GApps/exchangegoogle/app/PrebuiltExchange3Google/PrebuiltExchange3Google.apk
zip -U $exchange -O GApps/exchangegoogle/app/PrebuiltExchange3Google/PrebuiltExchange3Google.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

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
zip -U $gmail -O GApps/gmail/app/PrebuiltGmail/PrebuiltGmail.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#GoogleNow
googlenow=`find SourceAPKs/ -iname '*com.google.android.launcher*' | sort -r | head -1`
rm GApps/googlenow/app/GoogleHome/GoogleHome.apk
zip -U $googlenow -O GApps/googlenow/app/GoogleHome/GoogleHome.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#GooglePlus
googleplus=`find SourceAPKs/ -iname '*com.google.android.apps.plus*' | sort -r | head -1`
rm GApps/googleplus/app/PlusOne/PlusOne.apk
zip -U $googleplus -O GApps/googleplus/app/PlusOne/PlusOne.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $googleplus -d GApps/googleplus/app/PlusOne/lib/arm lib*

#GoogleTTS
googletts=`find SourceAPKs/ -iname '*com.google.android.tts*' | sort -r | head -1`
rm GApps/googletts/app/GoogleTTS/GoogleTTS.apk
zip -U $googletts -O GApps/googletts/app/GoogleTTS/GoogleTTS.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $googletts -d GApps/googletts/app/GoogleTTS/lib/arm lib*

#Hangouts
hangouts=`find SourceAPKs/ -iname '*com.google.android.talk*' | sort -r | head -1`
rm GApps/hangouts/priv-app/Hangouts/Hangouts.apk
zip -U $hangouts -O GApps/hangouts/priv-app/Hangouts/Hangouts.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $hangouts -d GApps/hangouts/priv-app/Hangouts/lib/arm lib*

#Keep
keep=`find SourceAPKs/ -iname '*com.google.android.keep*' | sort -r | head -1`
rm GApps/keep/app/PrebuiltKeep/PrebuiltKeep.apk
zip -U $keep -O GApps/keep/app/PrebuiltKeep/PrebuiltKeep.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Keyboard
keybd=`find SourceAPKs/ -iname '*com.google.android.inputmethod.latin*' | sort -r | head -1`
rm GApps/keyboardgoogle/app/LatinImeGoogle/LatinImeGoogle.apk
zip -U $keybd -O GApps/keyboardgoogle/app/LatinImeGoogle/LatinImeGoogle.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $keybd -d GApps/keyboardgoogle/app/LatinImeGoogle/lib/arm lib*

#Maps
maps=`find SourceAPKs/ -iname '*com.google.android.apps.maps*' | sort -r | head -1`
rm GApps/maps/app/Maps/Maps.apk
zip -U $maps -O GApps/maps/app/Maps/Maps.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $maps -d GApps/maps/app/Maps/lib/arm lib*

#Messenger
messenger=`find SourceAPKs/ -iname '*com.google.android.apps.messaging*' | sort -r | head -1`
rm GApps/messenger/app/PrebuiltBugle/PrebuiltBugle.apk
zip -U $messenger -O GApps/messenger/app/PrebuiltBugle/PrebuiltBugle.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $messenger -d GApps/messenger/app/PrebuiltBugle/lib/arm lib*

#Movies
movies=`find SourceAPKs/ -iname '*com.google.android.videos*' | sort -r | head -1`
rm GApps/movies/app/Videos/Videos.apk
zip -U $movies -O GApps/movies/app/Videos/Videos.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $movies -d GApps/movies/app/Videos/lib/arm lib*

#Music
music=`find SourceAPKs/ -iname '*com.google.android.music*' | sort -r | head -1`
rm GApps/music/app/Music2/Music2.apk
zip -U $music -O GApps/music/app/Music2/Music2.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Newsstand
newsstand=`find SourceAPKs/ -iname '*com.google.android.apps.magazines*' | sort -r | head -1`
rm GApps/newsstand/app/Newsstand/Newsstand.apk
zip -U $newsstand -O GApps/newsstand/app/Newsstand/Newsstand.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Newswidget
newswidget=`find SourceAPKs/ -iname '*com.google.android.apps.genie.geniewidget*' | sort -r | head -1`
rm GApps/newswidget/app/PrebuiltNewsWeather/PrebuiltNewsWeather.apk
zip -U $newswidget -O GApps/newswidget/app/PrebuiltNewsWeather/PrebuiltNewsWeather.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Search
search=`find SourceAPKs/ -iname '*com.google.android.googlequicksearchbox*' | sort -r | head -1`
rm GApps/search/priv-app/Velvet/Velvet.apk
zip -U $search -O GApps/search/priv-app/Velvet/Velvet.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $search -d GApps/search/priv-app/Velvet/lib/arm lib*

#Sheets
sheets=`find SourceAPKs/ -iname '*com.google.android.apps.docs.editors.sheets*' | sort -r | head -1`
rm GApps/sheets/app/EditorsSheets/EditorsSheets.apk
zip -U $sheets -O GApps/sheets/app/EditorsSheets/EditorsSheets.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $sheets -d GApps/sheets/app/EditorsSheets/lib/arm lib*

#Slides
slides=`find SourceAPKs/ -iname '*com.google.android.apps.docs.editors.slides*' | sort -r | head -1`
rm GApps/slides/app/EditorsSlides/EditorsSlides.apk
zip -U $slides -O GApps/slides/app/EditorsSlides/EditorsSlides.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $slides -d GApps/slides/app/EditorsSlides/lib/arm lib*

#Speech (from Nexus sources)
speech=`find SourceAPKs/ -iname 'srec' | head -1`
copy $speech "GApps/speech/usr/srec"

#Street
street=`find SourceAPKs/ -iname '*com.google.android.street*' | sort -r | head -1`
rm GApps/street/app/Street/Street.apk
zip -U $street -O GApps/street/app/Street/Street.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Talkback
talkback=`find SourceAPKs/ -iname '*com.google.android.marvin.talkback*' | sort -r | head -1`
rm /GApps/talkback/app/talkback/talkback.apk
zip -U $talkback -O /GApps/talkback/app/talkback/talkback.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*

#Wallet
wallet=`find SourceAPKs/ -iname '*com.google.android.apps.walletnfcrel*' | sort -r | head -1`
rm GApps/wallet/priv-app/Wallet/Wallet.apk
zip -U $wallet -O GApps/wallet/priv-app/Wallet/Wallet.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $wallet -d GApps/wallet/priv-app/Wallet/lib/arm lib*

#Youtube
youtube=`find SourceAPKs/ -iname '*com.google.android.youtube*' | sort -r | head -1`
rm GApps/youtube/app/YouTube/YouTube.apk
zip -U $youtube -O GApps/youtube/app/YouTube/YouTube.apk --exclude javax* lib* jsr* third_party/java_src/js*_inject*
unzip -j -o $youtube -d GApps/youtube/app/YouTube/lib/arm lib*
