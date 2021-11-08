function deactivate_site () {
	if ! [[ -L "/etc/nginx/sites-enabled/${1}.conf" ]];
	then
		echo 'Error 1: site not activated / created';
		return;
	fi

	sudo unlink "/etc/nginx/sites-enabled/${1}.conf"

	echo "Site has been deactivated!";
	return 0;
}