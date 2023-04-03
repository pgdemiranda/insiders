# # variable
# data=$(date +'%Y-%m-%dT%H:%M:%S')
# path='c:\\Users\\pgdem\\repos\\insiders\\'
# path_to_envs='c:\\Users\\pgdem\\anaconda3\\envs\\insiders\\Scripts'
# 
# $path_to_envs/papermill $path/src/models/c10.0-pgdm-deploy.ipynb $path/reports/c10-mdfl-deploy_$data.ipynb

#!/bin/bash

# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')
path='c:\\Users\\pgdem\\repos\\insiders\\'
path_to_envs='c:\\Users\\pgdem\\anaconda3\\envs\\insiders\\Scripts'

# activate the Anaconda environment and run the notebook using papermill
source activate $path_to_envs && $path_to_envs/papermill $path/src/models/c10.0-pgdm-deploy.ipynb $path/reports/c10-mdfl-deploy_$data.ipynb
