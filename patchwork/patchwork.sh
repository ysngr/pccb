#!/bin/bash

# parse args
if [ $# -ne 3 ]; then
    echo "Invaid number of arguments."
    echo "Usage: ${0} folder start end"
    exit 1
fi
folder=${1}
start=${2}
end=${3}
sketch=`pwd`/patchwork
imgdir=${sketch}/data

# make dir for images
if [ -d ${imgdir} ]; then
    rm -r ${imgdir}
fi
mkdir ${imgdir}

# copy images
for (( i = ${start}; i <= ${end}; i++ )); do
    zpi=`printf "%03d" ${i}`
    cp ${folder}/*/${zpi}.png ${imgdir}/${zpi}.png
done

expimgn=$((${end} - ${start} + 1))
actimgn=`ls ${imgdir} -U1 | wc -l`
if [ ${expimgn} -ne ${actimgn} ]; then
    echo "Invalid number of images."
    echo "Expected ${expimgn} images but found ${actimgn} images."
    exit 1
fi

# execute
processing-java --sketch=${sketch} --run ${start} ${end}

# remove images
# rm -r ${imgdir}  # TODO
