#!/bin/bash

# demo: cd /root/local-src/VMM-enabling-workspace/kconfig-track;bash apply.sh /root/local-src/VMM-enabling-workspace/kconfig-track /root/nfs/linux;cd /root/nfs/linux


CICD=$1
SRC=$2
STRUCTURE=feature-structure.txt

cd $SRC
echo "" > $CICD/$STRUCTURE
ls *Kconfig >> $CICD/$STRUCTURE
ls */Kconfig >> $CICD/$STRUCTURE
ls */*/Kconfig >> $CICD/$STRUCTURE
ls */*/*/Kconfig >> $CICD/$STRUCTURE
ls */*/*/*/Kconfig >> $CICD/$STRUCTURE
ls */*/*/*/*/Kconfig >> $CICD/$STRUCTURE
ls */*/*/*/*/*/Kconfig >> $CICD/$STRUCTURE
ls */*/*/*/*/*/*/Kconfig >> $CICD/$STRUCTURE

cat $CICD/$STRUCTURE | sort | uniq | tee $CICD/$STRUCTURE > /dev/null

declare -a codes=()

cd $SRC

echo -e "\n[START] synchronizing files...\n"
cat $CICD/$STRUCTURE | while read var
do
    if [ ! -f "$CICD/${var}" ]; then
        echo "acquire ${var}"
        cp --parents ${var} $CICD/
    else
        echo "update ${var}"
        cp $CICD/${var} $SRC/${var}
    fi
done
cd $CICD

echo -e "\n[DONE] synchronizing files \n"