#!/bin/bash

# linux-demo: cd /root/local-src/VMM-enabling-workspace/linux.kernel.kconfig;rm -rf `ls -1 -d */`;bash apply.sh /root/local-src/VMM-enabling-workspace/linux.kernel.kconfig /root/nfs/linux-museum/linux;cd /root/nfs/linux-museum/linux
# find . -name "Kconfig*" > demo

CICD=$1
SRC=$2
STRUCTURE=feature-structure.txt

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
