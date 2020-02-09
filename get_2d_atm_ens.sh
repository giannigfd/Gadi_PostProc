#!/bin/bash


#------------- EDIT THIS BLOCK ---------------------#

#outdir=/g/data1/v45/gab563/PostProc/a10_hist_SOPM_Clm
outdir=/g/data3/k10/gli565/PostProc/AtPM_IOclm_ens
outdir=/g/data3/k10/gli565/PostProc/AtCLM_ens
outdir=/g/data3/k10/gli565/PostProc/AtPM_2xTrend_ens
outdir=/g/data3/k10/gli565/PostProc/AtPM_Trend_ens

varlist=( psl pr uas vas ts tas )

# Exp name (folder) without "_r01"
#basenameEXP=a10_hist_SOPM_Clm
#basenameEXP=a10_hist_AtPM_IOclmA10
basenameEXP=a10_rcp_AtPM_IOclmA10
basenameEXP=a10_hist_AtObsCLM
basenameEXP=a10_hist_AtPM_2xTrend
basenameEXP=a10_hist_AtPM_Trend


GRDfile=/home/565/gl4801/PostProc/aux/atm_newg.grd

# please edit manually the number of members in the "for" loop

#--------------- END EDIT BLOCK ---------------------#


for var in ${varlist[*]}; do
echo VAR: $var

for memb in 01 02 03 04 05 06 07 08 09 10; do

#for memb in `seq -w 1 3` ; do

    mkdir -p ${outdir}/${var}/r${memb}

    FLDR=${outdir}/NC_ATM_r${memb}

for filename in ${FLDR}/${basenameEXP}_r${memb}.pa-??????????.nc ; do
       echo test GL
       echo $filename
       ff=${filename##*-}
       fecha=${ff%.nc}
      echo $fecha
 
       if [ ! -f ${outdir}/${var}/r${memb}/${var}_${fecha}.nc ]; then
       cdo selname,${var} "$filename" ${outdir}/${var}/r${memb}/${var}_${fecha}.nc
       echo ${fecha}
       fi
done

INIYR=`ls -rl ${outdir}/${var}/r${memb}  | tail -n 1 | tail -c 14 | cut -c1-4`
FINYR=`ls -l ${outdir}/${var}/r${memb}  | tail -n 1 | tail -c 14 | cut -c1-4`

echo Member: $memb  ${INIYR}-${FINYR}

#rm -f tmp/${varlist}.nc

if [ ! -f ${outdir}/${var}/${var}_r${memb}_${INIYR}-${FINYR}.nc ]; then
echo Merging $var $memb
cdo mergetime ${outdir}/${var}/r${memb}/${var}_??????????.nc ${outdir}/${var}/${var}_r${memb}_${INIYR}-${FINYR}.nc
rm -f ${outdir}/${var}/${var}_r${memb}_${INIYR}-${FINYR}_newg.nc
cdo remapbil,${GRDfile} ${outdir}/${var}/${var}_r${memb}_${INIYR}-${FINYR}.nc ${outdir}/${var}/${var}_r${memb}_${INIYR}-${FINYR}_newg.nc 
fi


done

done

