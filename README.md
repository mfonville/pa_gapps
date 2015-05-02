# pa_gapps
Paranoid Android Google Apps

This is the continuation of the Paranoid Android Google Apps that was started by @TKruzze

As big fan of the original package, I continued his effort. I recognized that most of the people trying to take over his work, had the problem that it took too much time to manually update all the scripts and property files. That is why I have developed some scripts to do this automatically.

# extract_sources
This script searchs the SourceAPKs directory for the latest version of the apps. The directory where they are stored do not matter, it searches recursively for the latest version. It is important though to keep the identifying name within the filename of the apk.

# make_gprop.sh
The goal of this file is to generate a g.prop file with the correct properties

# make_installerdata.sh
The goal of this file is to generate the installer.data file with correct sizes about the Google Play Services and other mandatory packages.

# make_sizesprop.sh
The goal of this file is to genarate the size.prop file with correct sizes about the optionally installable packages

# make_package.sh
If you have extracted the sources and have ran all the other make-scripts, you can create a signed package using this script.

