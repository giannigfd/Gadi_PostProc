#!/bin/bash


#set -e

expbasename=a10_rcp85_AtPM_Full
expbasename=a10_hist_AtPM_Full

type=atm
#type=ocn


#for memb in 07 08 09 10 ; do
for memb in 01 02 ; do


if [ ${memb} -eq 01 ] || [ ${memb} -eq 02 ] || [ ${memb} -eq 04 ] || [ ${memb} -eq 05 ] ; then
    ensFLDR=/short/v45/gl4801/archive
else
    ensFLDR=/short/k10/gl4801/archive
fi


FLDRa=${ensFLDR}/${expbasename}_r${memb}/history/${type}

mdss mkdir gli565/ACCESS1.0/${expbasename}_r${memb}/history

echo GL 1
echo GL 2 mdss ls gli565/ACCESS1.0/${expbasename}_r${memb}/history/${expbasename}_r${memb}_${type}.tar.gz > /dev/null 2>&1

mdss ls gli565/ACCESS1.0/${expbasename}_r${memb}/history/${expbasename}_r${memb}_${type}.tar.gz > /dev/null 2>&1
exval=$?

if [ ${exval} -eq 0 ] ; then
echo file ${expbasename}_r${memb}_${type}.tar.gz already on massdata
else
echo netcp -C -l other=mdss -z -t ${expbasename}_r${memb}_${type}.tar ${FLDRa}/ gli565/ACCESS1.0/${expbasename}_r${memb}/history/
#netcp -C -l other=mdss -z -t ${expbasename}_r${memb}_${type}.tar ${FLDRa}/ gli565/ACCESS1.0/${expbasename}_r${memb}/history/
fi

now=$(date)
echo first start $now
#sleep 3h

done

