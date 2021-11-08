function remove_site () {
	source "${_SITE_CREATOR_SRC_DIR}/lib/components/deactivate.sh";
	
	if ! [[ -f "/etc/nginx/sites-available/${1}.conf" ]];
	then
		echo "Error 1: site not found";
		return 1;
	fi

	if [[ -L "/etc/nginx/sites-enabled/${1}.conf" ]];
	then
		echo $(deactivate_site $1);
		$_ERR_CODE=$?;

		echo $msg;
		unset msg;

		if [ $_ERR_CODE -ne 0 ];
		then
			unset -f deactivate_site;
			return $_ERR_CODE;
		fi
	fi

	local path_to_site=$(grep "root" "/etc/nginx/sites-available/${file}" | sed "s/root //; s/;//; s/ *//");

	sudo rm -f "/etc/nginx/sites-available/${1}.conf";

	echo -n "Remove site folder (Y/N)? ";
	read -r $answer;

	if [[ $answer == 'Y' ]];
	then
		if ! [[ -d $path_to_site ]];
		then
			echo "Error 1: site folder not found";
			return 1;
		fi
		sudo rm -rfd $path_to_site;
	fi

	unset $path_to_site $answer;
	unset -f deactivate_site;
	return 0;
}