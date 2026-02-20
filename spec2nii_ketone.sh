#!/bin/bash
script_path=/autofs/space/ketone_002/users/Cassia/ketone/scripts
subjects=( `cat ${script_path}/subjects_list.txt ` )

for subject in "${subjects[@]}";do
	#subject=LMP_KECK_099_7T_GLC
	echo "Processing subject: $subject"
	MRS_path=/autofs/space/ketone_002/users/Cassia/ketone/data/$subject
	cd $MRS_path &&
	spec2nii dicom fid.IMA
done
