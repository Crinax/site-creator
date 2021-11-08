function activate_site () {
	if [[ -L "/etc/nginx/sites-enabled/${1}.conf" ]];
	then
		echo "Error 1: site already activated";
		return 1;
	fi

	if ! [[ -f "/etc/nginx/sites-available/${1}.conf" ]];
	then
		echo "Error 1: site not found\nCreate new site: site create ${1} path/to/site/folder";
		return 1;
	fi

	sudo ln -s "/etc/nginx/sites-available/${1}.conf" "/etc/nginx/sites-enabled/${1}.conf";

	echo "Site has been activated";
	return 0;
}