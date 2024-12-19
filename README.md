# AppImageShell

Alternate shell version. However it does not find and place lib files

This works too:
https://makeself.io/
git clone https://github.com/megastep/makeself.git
eg: makeself/makeself.sh --threads=0 AppDir myimage.sh label ./AppRun

I am trying to make my own, simpler, all shell version.
It uses squashfs.

I still need to find and copy lib files

ldd 0_FULL_GAME | awk 'NF == 4 { system("echo cp " $3 " destdir") }'
Replace destdir with your directory of choice. Once the displayed commands look OK, remove the echo to actually copy, eg:
ldd 0_FULL_GAME | awk 'NF == 4 { system("cp " $3 " chosen-dir") }'
