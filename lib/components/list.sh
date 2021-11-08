function site_list () {
	local av_files=($(sudo ls '/etc/nginx/sites-available' ));
	# Cursor movement
	local next_column='\033[39C';
	# Colors
	local red='\033[1;31m';
	local green='\033[1;32m';
	local blue='\033[1;34m';
	local nc='\033[0m';
	local yellow='\033[1;33m';
	# Status
	local site_status=("${red}disabled${nc}" "${green}enabled${nc}" "${yellow}directory not found${nc}");

	echo "Domain${next_column}Status"

	for file in "${av_files[@]}";
	do
		local file_status="${site_status[3]}";
		local domen=$(echo $file | sed 's/.conf//');
		local domen_length="${#domen}";
		next_column="\033[$((45 - $domen_length))C";
		local path_to_site=$(grep "root" "/etc/nginx/sites-available/${file}" | sed "s/root //; s/;//; s/ *//");

		# Check site directory
		if [[ -d $path_to_site ]];
		then
			# Check symbolic link
			if [[ -L "/etc/nginx/sites-enabled/${file}" ]];
			then
				file_status="${site_status[2]}";
			else
				file_status="${site_status[1]}";
			fi
		fi

		echo "${blue}${domen}${nc}${next_column}${file_status}";

		unset file_status domen domen_length path_to_site;
	done

	unset av_files index next_column red green nc blue yellow site_status;
	return 1;
}