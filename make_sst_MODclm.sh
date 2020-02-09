



for file in /g/data1/p66/ACCESSDIR/har599/ACCESS/output/hg2-r11Mhd/history/ocn/ocean_month.nc-19[6-9]?????
       echo $file

cdo selname,sst $file $file_sst

done

