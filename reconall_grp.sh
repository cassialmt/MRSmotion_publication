#!/bin/bash
export SUBJECTS_DIR=/autofs/space/ketone_002/users/Cassia/ketone/recon-all
script_path="/autofs/space/ketone_002/users/Cassia/ketone/scripts/"
subjects=( `cat ${script_path}subjects_list.txt ` )
#SUBJECT=LMP_KECK_092_7T_GLC

for SUBJECT in "${subjects[@]}";do
	echo "Processing subject: $subject"
	cd /autofs/space/ketone_002/users/Cassia/ketone/data/$SUBJECT
	recon-all -subjid $SUBJECT -i mT1_pre.nii -openmp 24 && \
	recon-all -subjid $SUBJECT -all -openmp 24			
done
