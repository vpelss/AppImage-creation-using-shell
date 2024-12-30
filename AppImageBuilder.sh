#!/bin/sh
clear
# set to your properly created and formatted AppDir, complete withh all required files. this script attempts to find and add lib files
FOLDERTOSQUASH="SpaceNerdsInSpaceDir"
# a temp folder to build AppImage with
TEMPSQUASHFS="Temp.squashfs"
# the exe filename to build
APPIMAGENAME="Your.AppImage"
# all the exe files. they will be scanned for lib dependancies
EXEC="${FOLDERTOSQUASH}/usr/bin/*"

# required as the header to boot the AppImage. do not edit it.
HEADERSCRIPT="AppImageHeader.txt"

export AppDirAWK=${FOLDERTOSQUASH}
ldd ${EXEC} | awk 'NF == 4 { echo system("cp " $3 " " ENVIRON["AppDirAWK"] "/usr/lib/") }'
# ldd $AppDir/usr/bin/snis_client | awk  'NF == 4 {  system("echo cp " $3 " " ENVIRON["AppDirAWK"]"/usr/lib/") }'

#remove libc
rm ${EXEC}/usr/lib/libc.*

#set path
export PATH="${FOLDERTOSQUASH}/usr/lib:${FOLDERTOSQUASH}/usr/include:$PATH"

echo "Start AppImage build of ${APPIMAGENAME} "

TEMPSTRING=`cat ${HEADERSCRIPT}`  #load file to string
echo "1"
TEMPSTRING=echo ${TEMPSTRING} | sed '$d'  #remove last whitespace?
echo "2"
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
