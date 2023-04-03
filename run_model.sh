# variable
data=$(date +'%Y-%m-%dT%H-%M-%S')

# paths
set path=C:\Users\pgdem\repos\insiders
set path_to_envs=C:\Users\pgdem\anaconda3\envs\insiders\Scripts

$path_to_envs\papermill $path\src/models/c10.0-pgdm-deploy.ipynb $path\reports/c10.0-pgdm-deploy_$data.ipynb && echo "Done!" || echo "Papermill not executed"