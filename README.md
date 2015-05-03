# pa_gapps
Paranoid Android Google Apps by @mfonville

This is the continuation of the Paranoid Android Google Apps that was started by @TKruzze

As big fan of the original package, I continued his effort. I recognized that most of the people trying to take over his work, had the problem that it took too much time to manually update all the scripts and property files. That is why I have developed some scripts to do this automatically.

## extract_sources.sh
This script searchs the SourceAPKs directory for the latest version of the apps. The directory where they are stored do not matter, it searches recursively for the latest version. It is important though to keep the identifying name within the filename of the apk.
It will copy the executables and libraries to their correct location, ready to be packaged. It will also align the APKs.

## make_gprop.sh
The goal of this file is to generate a g.prop file with the correct properties

## make_installerdata.sh
The goal of this file is to generate the installer.data file with correct sizes about the Google Play Services and other mandatory packages.

## make_sizesprop.sh
The goal of this file is to genarate the size.prop file with correct sizes about the optionally installable packages

## make_package.sh
When you have extracted the most recent sources to be put in the package, and have ran all the other make-scripts, you can create a signed flashable ZIP-package using this script.

# Changes in 'options' compared to original package
* Sunbeam has been completely removed from the package
* Bookmarksync (bksync) does not exist anymore, removed then also all its traces from the scripts
* More advanced options for removal:
  * BasicDreams
  * CMAccount
  * CMUpdater
  * Galaxy
  * HoloSpiral
  * LiveWallpapers
  * LockClock
  * NoiseField
  * Phasebeam
  * PhotoPhase
  * PhotoTable
  * Terminal
  * Themes (Will break the link Cyanogen Settings to Themes though)
  * VisualizationWallpapers
  * WhisperPush

##Todo:
Make a script that will automatically update the contents of gapps-remove.txt
