# AppImage creation using shell


Alternate shell version to create an AppImage. 
It uses squashfs.

It has a simplistic find and place lib files routine.

1. Create an Appropriate AppDir folder with icon, AppRun, app.desktop files and appropriate folder structure
- See: https://docs.appimage.org/reference/appdir.html

2. Download:
- AppImageBuilder.sh
- AppImageHeader.txt

3. Edit variables in:
- AppImageBuilder.sh

4. chmod +x AppImageBuilder.sh

5. Run AppImageBuilder.sh

These can work too:
https://makeself.io/
git clone https://github.com/megastep/makeself.git
eg: makeself/makeself.sh --threads=0 AppDir myimage.sh label ./AppRun
