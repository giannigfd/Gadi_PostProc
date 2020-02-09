#!/bin/bash



set -e


module purge
module use ~access/modules
module load pythonlib/ScientificPython
module load pythonlib/cdat-lite
UM2CDF=/projects/access/bin/um2netcdf.py

#-------EDIT BLOCK ------
ensFLDR=/short/k10/gl4801/archive

outdir=/g/data3/k10/gli565/PostProc/AtPM_Trend_ens

expname=a10_hist_AtPM_Trend

#----- END EDIT BLOCK ------


mkdir -p ${outdir} 

for memb in 01 02 03 04 05 06 07 08 09 10; do


mkdir -p ${outdir}/NC_ATM_r${memb}

FLDR=${ensFLDR}/${expname}_r${memb}/history/atm

for file in ${FLDR}/${expname}_r${memb}.pa-??????????; do

       echo $file
       filename="$(basename -- $file)"
       if [ ! -f ${outdir}/NC_ATM_r${memb}/${filename}.nc ]; then
       $UM2CDF -i $file -o ${outdir}/NC_ATM_r${memb}/${filename}.nc
       fi

done


done

