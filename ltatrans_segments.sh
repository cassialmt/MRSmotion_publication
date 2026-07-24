#!/bin/bash
cd /autofs/space/ketone_002/users/Cassia/ketone/data
# Iterate through each subdirectory in the current directory
for dir in */; do
    echo "Entering directory: $dir"
    (cd "$dir" && \
	for i in {1..6}; do mri_vol2vol --mov c${i}mT1_pre.nii --targ c${i}mT1_pre.nii --o c${i}mT1_simpostnear.nii --lta lta_files/hspre2post.lta --interp nearest; done
	)

done


