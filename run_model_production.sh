# variable
data=$(date +'%Y-%m-%dT%H-%M-%S')

# paths
set path='/home/ubuntu/insiders'
set path_to_envs='/home/ubuntu/.pyenv/versions/3.10.10/envs/insiders/bin'

$path_to_envs/papermill $path/src/models/c10.0-pgdm-deploy.ipynb $path/reports/c10.0-pgdm-deploy_$data.ipynb && echo "Done!" || echo "Papermill not executed"