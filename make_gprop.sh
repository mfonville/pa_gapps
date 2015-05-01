#!/bin/sh
now=$(date +"%Y%m%d")
echo "# begin addon properties
ro.addon.type=gapps
ro.addon.platform=51
ro.addon.pa_type=stock
ro.addon.pa_version="$now"
# end addon properties" > g.prop
