#!/bin/bash
cd /autofs/space/ketone_002/users/Cassia/ketone/data
#HSpre=headscout_pre.nii
#HSpost=headscout_post.nii
# Iterate through each subdirectory in the current directory
for dir in */; do
    echo "Entering directory: $dir"
    (cd "$dir" && \
	mri_robust_register --mov headscout_pre.nii --dst headscout_post.nii --lta hspre2post.lta --satit --affine && \
	mri_vol2vol --mov mT1_pre.nii --targ mT1_pre.nii --o T1_simpostnear.nii --lta hspre2post.lta --interp nearest)

done


