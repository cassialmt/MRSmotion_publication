#!/bin/bash
export SUBJECTS_DIR=/autofs/space/ketone_002/users/Cassia/ketone/recon-all
script_path="/autofs/space/ketone_002/users/Cassia/ketone/scripts"
subjects=( `cat ${script_path}/subjects_list.txt ` )

for subject in "${subjects[@]}";do
	echo "Processing subject: $subject"
	cd $SUBJECTS_DIR/$subject/mri/
	MRS_path=/autofs/space/ketone_002/users/Cassia/ketone/data/$subject

	# Align wmparc.mgz & aparc.a2009s+aseg.mgz labels to original MMPRAGE dimensions
	mri_label2vol --seg wmparc.mgz --temp $MRS_path/mT1_pre.nii --o wmparc176.mgz --regheader wmparc.mgz	
	
	# Extract VOI labels (Hippo/Tha/STG/PFC)
	mri_binarize --i wmparc176.mgz --match 10 49 --o tha.nii
	mri_binarize --i wmparc176.mgz --match 1030 1034 3030 3034 --o Lstg.nii	
	mri_binarize --i wmparc176.mgz --match 1034 --o Lpac.nii	
