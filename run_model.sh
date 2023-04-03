# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')
path='c:/Users/pgdem/repos/insiders'
path_to_envs='c:/Users/pgdem/anaconda3/envs/insiders/Scripts'

$path_to_envs/papermill $pathsrc/models/c10.0-pgdm-deploy.ipynb $path/reports/c10-mdfl-deploy_$data.ipynb
