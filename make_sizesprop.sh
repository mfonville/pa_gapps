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
echo "bksync_size=0" > sizes.prop
echo "books_size="`du -s --apparent-size GApps/books | cut -f 1` >> sizes.prop
echo "calendargoogle_size="`du -s --apparent-size GApps/calendargoogle | cut -f 1` >> sizes.prop
echo "calsync_size="`du -s --apparent-size GApps/calsync | cut -f 1` >> sizes.prop
echo "cameragoogle_size="`du -s --apparent-size GApps/cameragoogle | cut -f 1` >> sizes.prop
echo "chrome_size="`du -s --apparent-size GApps/chrome | cut -f 1` >> sizes.prop
echo "cloudprint_size="`du -s --apparent-size GApps/cloudprint | cut -f 1` >> sizes.prop
echo "docs_size="`du -s --apparent-size GApps/docs | cut -f 1` >> sizes.prop
echo "drive_size="`du -s --apparent-size GApps/drive | cut -f 1` >> sizes.prop
echo "ears_size="`du -s --apparent-size GApps/ears | cut -f 1` >> sizes.prop
echo "earth_size="`du -s --apparent-size GApps/earth | cut -f 1` >> sizes.prop
echo "exchangegoogle_size="`du -s --apparent-size GApps/exchangegoogle | cut -f 1` >> sizes.prop
echo "faceunlock_size="`du -s --apparent-size GApps/faceunlock | cut -f 1` >> sizes.prop
echo "gmail_size="`du -s --apparent-size GApps/gmail | cut -f 1` >> sizes.prop
echo "googlenow_size="`du -s --apparent-size GApps/googlenow | cut -f 1` >> sizes.prop
echo "googleplus_size="`du -s --apparent-size GApps/googleplus | cut -f 1` >> sizes.prop
echo "googletts_size="`du -s --apparent-size GApps/googletts | cut -f 1` >> sizes.prop
echo "hangouts_size="`du -s --apparent-size GApps/hangouts | cut -f 1` >> sizes.prop
echo "keep_size="`du -s --apparent-size GApps/keep | cut -f 1` >> sizes.prop
echo "keyboardgoogle_size="`du -s --apparent-size GApps/keyboardgoogle | cut -f 1` >> sizes.prop
echo "maps_size="`du -s --apparent-size GApps/maps | cut -f 1` >> sizes.prop
echo "messenger_size="`du -s --apparent-size GApps/messenger | cut -f 1` >> sizes.prop
echo "movies_size="`du -s --apparent-size GApps/movies | cut -f 1` >> sizes.prop
echo "music_size="`du -s --apparent-size GApps/music | cut -f 1` >> sizes.prop
echo "newsstand_size="`du -s --apparent-size GApps/newsstand | cut -f 1` >> sizes.prop
echo "newswidget_size="`du -s --apparent-size GApps/newswidget | cut -f 1` >> sizes.prop
echo "search_size="`du -s --apparent-size GApps/search | cut -f 1` >> sizes.prop
echo "sheets_size="`du -s --apparent-size GApps/sheets | cut -f 1` >> sizes.prop
echo "slides_size="`du -s --apparent-size GApps/slides | cut -f 1` >> sizes.prop
echo "speech_size="`du -s --apparent-size GApps/speech | cut -f 1` >> sizes.prop
echo "street_size="`du -s --apparent-size GApps/street | cut -f 1` >> sizes.prop
echo "sunbeam_size="`du -s --apparent-size GApps/sunbeam | cut -f 1` >> sizes.prop
echo "talkback_size="`du -s --apparent-size GApps/talkback | cut -f 1` >> sizes.prop
echo "wallet_size="`du -s --apparent-size GApps/wallet | cut -f 1` >> sizes.prop
echo "youtube_size="`du -s --apparent-size GApps/youtube | cut -f 1` >> sizes.prop
