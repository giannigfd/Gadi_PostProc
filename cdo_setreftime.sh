
VAR=sst

DATADIR=/short/k10/gl4801/archive/PostProc/A1.0_CTRL
FLDR=${DATADIR}/${VAR}

FILEIN=${FLDR}/${VAR}_1920-2019.nc
FILETMP=${FLDR}/${VAR}_1920-2019_tmp.nc
FILEOUT=${FLDR}/${VAR}_1920-2019_newg.nc

cdo setreftime,1970-01-01,00:00:00,day $FILEIN $FILETMP
cdo remapbil,/home/565/gl4801/PostProc/aux/atm_newg.grd $FILETMP $FILEOUT 
rm $FILETMP

