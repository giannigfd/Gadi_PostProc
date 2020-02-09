#!/bin/bash
#
#
# ACCESS produces one complete set of restart files every 3 months, which is often much more than what is needed.   
# Use this script to copy restart files for the first month of selected years to a new directory

set -x

#----------------------- EDIT THIS BLOCK --------------------------#

arch=/short/k10/gl4801/archive

# expanamebase assume this naming convention for the experiment name: ${expnamebase}_r${MEMB} (e.g., PacificRun_r01 ) 
expnamebase=a10_rcp_AtPM_IOclmA10
#expnamebase=a10_rcp85_AtPM_Full

savefolder=restart_saved

# Set the range of MEMBERS to process
# from ii to ff; set ii=ff for a single member
ii=4
ff=6

# Set YEARS to save the complete set of restart files
YEARS=( 2002 2006 2010 2014 2016 ) 

#----------------------- END EDIT BLOCK --------------------------#


for MEMB in `seq -f '%02g' ${ii} ${ff}`
do

expname=${expnamebase}_r${MEMB}


restartdir=$arch/$expname/restart
restout=$arch/$expname/${savefolder}

mkdir -p $restout
mkdir -p $restout/atm
mkdir -p $restout/ocn
mkdir -p $restout/ice
mkdir -p $restout/cpl

for yr in ${YEARS[*]} 
do
yrpone=$((yr + 1));

#ATM
ls $restartdir/atm/*.astart-${yrpone}0101
cp $restartdir/atm/*.astart-${yrpone}0101 $restout/atm/

#OCN
cp $restartdir/ocn/ocean_*.res*-${yr}1231 $restout/ocn/ 

#ICE
ls $restartdir/ice/ice.restart_file-${yr}1231
ls $restartdir/ice/mice.nc-${yr}1231
ls $restartdir/ice/iced.${yrpone}0101

cp $restartdir/ice/ice.restart_file-${yr}1231 $restout/ice/
cp $restartdir/ice/mice.nc-${yr}1231 $restout/ice/
cp $restartdir/ice/iced.${yrpone}0101 $restout/ice/ 

#CPL
ls $restartdir/cpl/*.nc-${yr}1231
cp $restartdir/cpl/*.nc-${yr}1231 $restout/cpl


done

done

