#!/bin/sh

#issues:
#my AppRun uses mkdir so if build system mkdir uses different libc.. error. I have copied build system mkdir to AppImage to 'fix'
#same if part of app runs bin/sh

clear
HEADERSCRIPT="AppImageHeader.txt"
EXEC="${FOLDERTOSQUASH}/usr/bin/*"
FOLDERTOSQUASH="Your.AppDir"
TEMPSQUASHFS="Temp.squashfs "
APPIMAGENAME="Your.AppImage"

#get required lib(s)
export AppDirAWK="$AppDir"
ldd ${EXEC} | awk -v AppDir=$FOLDERTOSQUASH 'NF == 4 { echo system("cp " $3 " " ENVIRON["AppDirAWK"] "/usr/lib/") }'echo "Start AppImage build of ${APPIMAGENAME} "

#my AppRun uses mkdir so if build system mkdir uses different libc than yours, error. I have copied build system mkdir to AppImage to 'fix'
#package an internal mkdir to fix libc issues
mkdir $FOLDERTOSQUASH/bin
cp /bin/mkdir $FOLDERTOSQUASH/bin
chmod +x $FOLDERTOSQUASH/bin/mkdir

TEMPSTRING=`cat ${HEADERSCRIPT}`  #load file to string
TEMPSTRING=echo ${TEMPSTRING} | sed '$d'  #remove last whitespace?

NUMBEROFLINEFEEDS=$(echo "${TEMPSTRING}" | wc -l )
NUMBEROFLINES=$((NUMBEROFLINEFEEDS+1))

#replace string ${NUMBEROFLINES} with value of '${NUMBEROFLINES} then save it to ${APPIMAGENAME}
echo "${TEMPSTRING}" | awk -v find='${NUMBEROFLINES}' -v repl=${NUMBEROFLINES} '{
    while (i=index($0,find)) 
        $0 = substr($0,1,i-1) repl substr($0,i+length(find))
    print
}'  > ${APPIMAGENAME}

mksquashfs ${FOLDERTOSQUASH} ${TEMPSQUASHFS} -root-owned -noappend
cat ${TEMPSQUASHFS} >> ${APPIMAGENAME}
chmod a+x ${APPIMAGENAME}
rm ${TEMPSQUASHFS}
