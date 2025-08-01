

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 24 17:57:43 2025

@author: ml1284
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import sem 
import os

dat_path='/autofs/space/ketone_002/users/Cassia/ketone/data';
script_path="/autofs/space/ketone_002/users/Cassia/ketone/scripts";
analysis_path='/autofs/space/ketone_002/users/Cassia/ketone/analysis';

# Function to add jitter
def add_jitter(arr, jitter_strength=0.05):
    return arr + np.random.uniform(-jitter_strength, jitter_strength, size=len(arr))
#%% M1.1 Import Overlap data
os.chdir(analysis_path)
df = pd.read_csv('overlap_table.csv')
df_selected = df.iloc[:, [4, 5, 7, 8, 10, 11]] 

main_categories = ['PFC', 'Th', 'LSTG'] 
sub_categories = ['-','+']
pltdat = [[[] for _ in range(len(sub_categories))]  for _ in range(len(main_categories))]
#prepare data in correct format
for m, mcat in enumerate(main_categories):
    pltdat[m]=[df_selected.iloc[:-3, 2*m].values,df_selected.iloc[:-3, 2*m+1].values] #exclude last 3 rows: mean,variance,SD
    print(2*m,2*m+1)
#%% M1.2 Boxplot Overlap
fig, axes = plt.subplots(1, len(main_categories), figsize=(10, 6))
for i in range(len(main_categories)):    
    for j in range(len(pltdat[i][0])):
       j_x1 = add_jitter(np.array([1]))
       j_x2 = add_jitter(np.array([2]))
       axes[i].plot(j_x1, [pltdat[i][0][j]], 'o', color='gray', alpha=0.5)
       axes[i].plot(j_x2, [pltdat[i][1][j]], 'o', color='gray', alpha=0.5)
       # Connect individual points
       axes[i].plot([j_x1, j_x2], [pltdat[i][0][j], pltdat[i][1][j]], color='gray', alpha=0.5)
    axes[i].boxplot(pltdat[i],widths=0.25,whiskerprops=dict(color='black'), capprops=dict(color='black'), showfliers=False,medianprops={'visible': False})
    # Connect means
    means = [np.mean(pltdat[i][0]), np.mean(pltdat[i][1])]
    axes[i].plot([1, 2], means, marker='o', color='black', linewidth=2)
    axes[i].text(.85, means[0], f'{means[0]:.1f}', fontsize=14, ha='right', va='center')
    axes[i].text(2.15, means[1], f'{means[1]:.1f}', fontsize=14, ha='left', va='center')
    #titles & axes
    axes[i].set_title(f'{main_categories[i]}', fontsize=20)
    axes[i].set_xticklabels(sub_categories,fontsize=14, fontweight='bold')
    axes[i].tick_params(axis='y', labelsize=12)
    if i == 0:
        axes[i].set_ylabel('% Overlap with label', fontsize=14)
# plt.suptitle('Overlap with anatomical label before and after movement correction')

plt.tight_layout()
plt.show()
#%% M2.1 Import Segment data
os.chdir(analysis_path)
filename='tissuevol_fbone.csv' #fCSF/fbone/fGWM.csv'
df = pd.read_csv(filename) 
df_selected = df.iloc[:, [ 4, 5, 7, 8, 10, 11]] 

main_categories = ['PFC', 'Th', 'LSTG']
sub_categories = ['-','+']
pltdat = [[[] for _ in range(len(sub_categories))]  for _ in range(len(main_categories))]
#prepare data in correct format
for m, mcat in enumerate(main_categories):
    pltdat[m]=[df_selected.iloc[:-3, 2*m].values,df_selected.iloc[:-3, 2*m+1].values] #exclude last trree mean, min, SD data
    print(2*m,2*m+1)
#%% M2.2C Barplot with subjects to exclude (red) - USE THIS
redthres=1 #adjust to 1 for fbone
fig, axes = plt.subplots(1, len(main_categories), figsize=(9, 6))


for i in range(len(main_categories)):
    post_vals = pltdat[i][0]
    pre_vals = pltdat[i][1]
    means = [np.mean(post_vals), np.mean(pre_vals)]
    sems = [sem(post_vals), sem(pre_vals)]
    j_x1 = add_jitter(np.full(len(post_vals), 0))
    j_x2 = add_jitter(np.full(len(pre_vals), 1))

    for j in range(len(post_vals)):
        post_color = 'red' if post_vals[j] > redthres else 'gray'
        pre_color = 'red' if pre_vals[j] > redthres else 'gray'
        axes[i].plot(j_x1[j], post_vals[j], 'o', color=post_color, alpha=0.7)
        axes[i].plot(j_x2[j], pre_vals[j], 'o', color=pre_color, alpha=0.7)
        axes[i].plot([j_x1[j], j_x2[j]], [post_vals[j], pre_vals[j]], color='gray', alpha=0.3)

    axes[i].bar([0, 1], means, yerr=sems, capsize=5, width=0.6,color=['#ffffff', '#ffffff'], edgecolor='black')
    # axes[i].set_title(f'{main_categories[i]}, N={len(post_vals)}\nMax: {max(post_vals)} ({sub_categories[0]}) | {max(pre_vals)} ({sub_categories[1]})', fontsize=12)
    if i==0:
        axes[i].set_ylabel('% Volume', fontsize=16)
    axes[i].set_xticks([0, 1])
    axes[i].set_xticklabels(sub_categories,fontsize=16, fontweight='bold')
    axes[i].tick_params(axis='y', labelsize=14)
    # axes[i].set_ylim(30, 100)  #for fGWM only

plt.suptitle(filename + ' in voxel before and after movement correction', fontsize=14)
plt.tight_layout()
plt.show()
