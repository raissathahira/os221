#!/bin/bash
# 26:DD70536E
# REV02: Mon 21 Feb 2022 09:30:00 WIA
# REV01: Sun 20 Feb 2022 16:35:08 WIB
# START: Sat 06 Nov 2021 11:47:14 WIB

if   [ -f  98-include.sh ] ; then
    .  98-include.sh
elif [ -f  $HOME/bin/98-include.sh ] ; then
    .  $HOME/bin/98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

# ZCZC START #### #### #### ####
SEQ="00"
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-INSTALL.txt"
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $HOME/bin/ ] || mkdir -pv $HOME/bin/
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/
fecho SCRIPT    $(head -3 $0 | tail -1)
fecho STAMPX    $(mkSTAMP)
fecho VERSUM    $(versum $0)
fecho WEEKXX    $WEEK
fecho VERDSK    $(verdisk)
fecho VERLNX    $(verkernel)
fecho PATHXX    $(echo $PATH|grep -Eo \/home\/$(whoami)\/bin) IS OK
for II in [0-9][0-9]-*.sh ; do
    if [ -f $II ] ; then
       chmod 755  $II
       cp -f $II $HOME/bin/
       CPLIST="$CPLIST$II "
    fi
done
fecho hoBIN $(ls $HOME/bin/)
fecho ===== RESULT IN $FILE =====

exit 0

