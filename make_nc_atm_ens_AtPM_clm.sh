#!/bin/bash



set -e


module purge
module use ~access/modules
module load pythonlib/ScientificPython
module load pythonlib/cdat-lite

UM2CDF=/projects/access/bin/um2netcdf.py


ensFLDR=/short/v45/gl4801/archive

outdir=/g/data3/k10/gli565/PostProc/AtCLM_ens

mkdir -p ${outdir}

for memb in 01 ; do


mkdir -p ${outdir}/NC_ATM_r${memb}

FLDR=${ensFLDR}/a10_hist_AtObsCLM_r${memb}/history/atm

for file in ${FLDR}/a10_hist_AtObsCLM_r${memb}.pa-??????????; do
       echo $file
       filename="$(basename -- $file)"
       
       if [ ! -f ${outdir}/NC_ATM_r${memb}/${filename}.nc ]; then
       $UM2CDF -i $file -o ${outdir}/NC_ATM_r${memb}/${filename}.nc
       fi

done


done

