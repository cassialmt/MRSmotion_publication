%% MRS motion voxel-ROI Overlap Analysis
%% Set dir
dat_path='/autofs/space/ketone_002/users/Cassia/ketone/data';
analysis_path='/autofs/space/ketone_002/users/Cassia/ketone/analysis';
script_path='/autofs/space/ketone_002/users/Cassia/ketone/scripts';
recon_path='/autofs/space/ketone_002/users/Cassia/ketone/recon-all';
fmri_path='/autofs/cluster/mujicagp/data/keck_bolus/sourcedata/fmri/';
gan_path='/autofs/cluster/mujicagp/data/keck_bolus/sourcedata/mrs/collected_by_antoine/Gannet';
twix_path='/autofs/cluster/mujicagp/data/keck_bolus/sourcedata/mrs/collected_by_antoine/TWIX';
tem_path='/autofs/space/ketone_002/users/Cassia/ketone/mask_templates';
fig_path='/autofs/space/ketone_002/users/Cassia/ketone/figures';

subjects={
 'LMP_KECK_091_7T_GLC',
 'LMP_KECK_092_7T_GLC',
 'LMP_KECK_093_7T_GLC',
 'LMP_KECK_094_7T_GLC',
 'LMP_KECK_095_7T_GLC',
 'LMP_KECK_098_7T_GLC',
 'LMP_KECK_099_7T_GLC',
 'LMP_KECK_100_7T_GLC',
 'LMP_KECK_101_7T_GLC',
 'LMP_KECK_102_7T_GLC',
 'LMP_KECK_103_7T_GLC',
 'LMP_KECK_104_7T_GLC',
 'LMP_KECK_105_7T_GLC',
 'LMP_KECK_107_7T_GLC',
 'LMP_KECK_108_7T_GLC',
 'LMP_KECK_109_7T_GLC',
 'LMP_KECK_111_7T_GLC',
 'LMP_KECK_112_7T_GLC',
 'LMP_KECK_114_7T_GLC',
 'LMP_KECK_115_7T_GLC',
 'LMP_KECK_116_7T_GLC',
 'LMP_KECK_117_7T_GLC',
 'LMP_KECK_118_7T_GLC',
 'LMP_KECK_119_7T_GLC',
 'LMP_KECK_123_7T_GLC',
 'LMP_KECK_124_7T_GLC',
 'LMP_KECK_126_7T_GLC',
 'LMP_KECK_127_7T_GLC',
 'LMP_KECK_128_7T_GLC',
 'LMP_KECK_130_7T_GLC',
 'LMP_KECK_131_7T_GLC'};
% MRS_path=fullfile(dat_path,subject,'MRS');
% cd(MRS_path)
%% SPM12 Bias-correction - set common parameters
spm('defaults', 'FMRI');
spm_jobman('initcfg');
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001; %regularization
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'/autofs/homes/001/ml1284/spm12/tpm/TPM.nii,1'};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'/autofs/homes/001/ml1284/spm12/tpm/TPM.nii,2'};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'/autofs/homes/001/ml1284/spm12/tpm/TPM.nii,3'};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'/autofs/homes/001/ml1284/spm12/tpm/TPM.nii,4'};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'/autofs/homes/001/ml1284/spm12/tpm/TPM.nii,5'};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'/autofs/homes/001/ml1284/spm12/tpm/TPM.nii,6'};
matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 0;
matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{1}.spm.spatial.preproc.warp.write = [0 0];
%% Bias-correction - run bias-correction with SPM12 segment
for s=1:length(subjects) %subject='LMP_KECK_083_7T_GLC';
    subject=subjects{s};
    disp(subject)
    matlabbatch{1}.spm.spatial.preproc.channel.vols = {fullfile(dat_path,subject,'anat_nobiascorr','T1_pre.nii,1')}; %;fullfile(dat_path,subject,'T1_post.nii,1')
    %add post script
    spm_jobman('run',matlabbatch);
    %move file out
    movefile(fullfile(dat_path,subject,'anat_nobiascorr','mT1_pre.nii'), fullfile(dat_path,subject,'mT1_pre.nii'));
end
%% Compute voxel-label overlap
labnames={'pfc_overlap','tha','Lstg'};
mrsvox_files={'pfc_simask.nii','tha_simask.nii','Lstg_simask.nii'};

for s=1:length(subjects) 
    subject=subjects{s};
    disp(subject)
    MRS_path=fullfile(dat_path,subject);
    cd(MRS_path)
    overlap = struct();
    for la=1:length(labnames)
        labmask=spm_read_vols(spm_vol(fullfile(recon_path,subject,'mri',strcat(labnames{la},'.nii'))));
        labind=find(labmask==1);
        %load 
        lab2mask=spm_read_vols(spm_vol(fullfile(recon_path,subject,'mri',strcat(labnames{la},'_post.nii'))));
        lab2ind=find(lab2mask==1);
        mrsmask=spm_read_vols(spm_vol(fullfile(MRS_path,mrsvox_files{la})));
        % disp(unique(round(mrsmask))) %debug
        mrsind=find(round(mrsmask)==1);
        overlap.(labnames{la})= (length(intersect(mrsind, labind)) / length(mrsind))*100;
        overlap.(strcat(labnames{la},'_post'))= (length(intersect(mrsind, lab2ind)) / length(mrsind))*100;
    end
    save('overlap.mat', 'overlap');
    % disp(overlap)
end
