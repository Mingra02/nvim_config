#session_root "~/Projects/docker_dev" # CHANGE THIS TO PROJECT ROOT FOLDER

if initialize_session "docker_dev"; then # Change docker_dev to the name of your session

	new_window "Docker"
	run_cmd "lazydocker"

	new_window "Coding Env" # Change to project name
	run_cmd "conda activate conda_env" # Change conda_env to your conda env
	split_v 0
	run_cmd "conda activate conda_env" # Change conda_env to your conda env
	split_h 20
	run_cmd "docker compose -f docker-compose.dev.yml up" # Change docker-compose.dev.yml to your docker compose file
	select_pane 1

	new_window "Git"
	run_cmd "lazygit"

	select_window 2

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
