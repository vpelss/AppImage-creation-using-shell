# AppImageShell

Alternate shell version. However it does not find and place lib files

This works too:
https://makeself.io/
git clone https://github.com/megastep/makeself.git
eg: makeself/makeself.sh --threads=0 AppDir myimage.sh label ./AppRun

I am trying to make my own, simpler, all shell version.
It uses squashfs.

I still need to find and copy lib files

ldd ~/SpaceNerdsInSpaceDir/usr/bin/snis_client | awk 'NF == 4 { system("echo cp " $3 " ~/SpaceNerdsInSpaceDir/usr/lib/") }'
