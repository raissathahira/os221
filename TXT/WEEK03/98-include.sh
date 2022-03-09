#!/bin/bash
# REV02: Sun 27 Feb 2022 17:00:42 WIB
# REV01: Mon 21 Feb 2022 07:52:18 WIB
# START: Sun 20 Feb 2022 16:35:08 WIB

WEEK="03"
LFSDIR="/mnt/lfs"
WEEKDIR="$HOME/RESULT/W$WEEK"
CPLIST=""
WHOAMI=$(whoami)
export PATH="$HOME/bin/:$PATH"
error() {
    echo "ZCZC ERROR $@" | tee -a $FILE
    exit 1
}
fecho(){
    echo "ZCZC $@" | tee -a $FILE
}
mkSTAMP() {
   local EXSTAMP=$(printf "%8.8X" $(( $(date +%s) & 16#FFFFFFFF )) )
   local EXCHSUM="XXXXXXXX"
   [ "$(hostname)" = "$WHOAMI" ] && {
       EXCHSUM=$(echo "$USER$EXSTAMP"|sha1sum|tr '[a-z]' '[A-Z]'| cut -c1-8)
   }
   echo  "$EXSTAMP $EXCHSUM $WHOAMI"
}
verdisk() {
    df -h /dev/sd?2|tail -2|awk '{print $2}'
    ls -l /dev/disk/by-uuid|awk '/sd[ab]2/ {print $9}'|tr '[a-z]' '[A-Z]'|cut -d- -f5,5
}
verkernel() {
    cat /proc/version | cut -d' ' -f3,3
}
versum() {
    CFILE=$1
    printf "%X:%s " $(tail -n +3 $CFILE|wc -l) $(tail -n +3 $CFILE|sha1sum|cut -c1-8|tr '[a-z]' '[A-Z]')
    head -2 $CFILE|tail -1|cut -c3-
}

