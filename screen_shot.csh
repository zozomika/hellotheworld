#!/bin/csh
setenv DATE `date '+%y%m%d_%H%M'`
import -window root -crop 454x394+69+269 -quality 200 /common/work/haulamhuynh/screenshot_${DATE}.png
