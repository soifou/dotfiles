#!/bin/sh

# get your coordonoates from here: http://www.gpsies.com/coordinate.do#help-findAdress
POSTCODE=69160
LATITUDE=45.7529414
LONGITUDE=4.7770379

/usr/local/bin/xflux -z $POSTCODE -l $LATITUDE -g $LONGITUDE