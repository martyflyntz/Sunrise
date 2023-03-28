HOME=/home/marty
HB='flatpak run fr.handbrake.HandBrakeCLI'
# HB=$HOME/HandBrakeCLI
INPUTDIR=$HOME/INPUT
OUTPUTDIR=$HOME/OUTPUT
PARAMETERS="-f av_mp4 -e x264 -b 1000 -2 -E ca_aac -B 128 -l 720 -d -x subq=6:partitions=all:8x8dct:me=umh:frameref=5:bframes=3:b_pyramid:weight_b"
HEADER="
..__............._......__...__\n
|__..|..|.|\.|.|_|..|.|__..|_.\n
.__|.|__|.|.\|.|.\..|..__|.|__\n
..\n
___.._..._........__...__..__...__...__.._.\n
.|..|_|.|_|.|\.|.|__..|...|..| |..\.|_..|_|\n
.|..|.\.|.|.|.\|..__|.|__.|__|.|__/.|__.|.\ \n
"
clear
echo $HEADER | tr '.' ' '



clear
echo "file to be transcoded"
IN1=`find ~/Downloads/*.mp4 -mtime -1 -print`
IN="${IN1##*/}"
IN=`echo $IN | sed 's/[^a-zA-Z0-9._-]/_/g'`
echo $IN
echo "use this file? (Y/N)"
read YN

if [[ $YN == "Y" || $YN == "y" ]] ; then
mv "${IN1}" ~/INPUT/"${IN// /_}"
IN=`find ~/INPUT/*.mp4 -mtime -1 -print`
else

clear
echo $HEADER | tr '.' ' '
ls $INPUTDIR
echo  "Enter the file to be Transcoded"
read IN
fi

IN3="${IN##*/}"
OUT=`echo $OUTPUTDIR`"/transcoded_"`echo $IN3 | tr ' ' '_'`
IN=$(printf %q "$IN")
echo $OUT

#clear
echo $HEADER | tr '.' ' '

RUNPROG="`echo $HB` -i `echo $IN` -o `echo $OUT $PARAMETERS`"
echo $RUNPROG
eval $RUNPROG

#clear
echo $HEADER | tr '.' ' '

echo "TRANSCODING COMPLETE"
rm -rf $IN
open $OUTPUTDIR
