#!/bin/sh
clear
HEADERSCRIPT="AppImageHeader.txt"
FOLDERTOSQUASH="Your.AppDir"
TEMPSQUASHFS="Temp.squashfs "
APPIMAGENAME="Your.AppImage"
#get required lib(s)
ldd ~/${FOLDERTOSQUASH}/usr/bin/bin/* | awk -v AppDir=${FOLDERTOSQUASH}/ 'NF == 4 { system("cp " $3 " " AppDir"/usr/lib/") }'
echo "Start AppImage build of ${APPIMAGENAME} "

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
