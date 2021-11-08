SRC_DIR="${SRC_DIR}/components";

create_site () {
	local src_dir="${_SITE_CREATOR_SRC_DIR}/lib/components/sources";
	local path_to_site='/usr/share/nginx/';

	# Was user set 3-rd argument?
	if [[ $2 != "" ]];
	then
		path_to_site=$2;
	fi

	# Is path to site exists?
	if ! [[ -d $path_to_site ]];
	then
		echo "Error 128: no such file or directory \"$path_to_site\"";
		return 128;
	fi

	# Is path to configs exists?
	if ! [[ -d /etc/nginx/sites-available ]];
	then
		sudo mkdir /etc/nginx/sites-available;
	fi

	# Replace all "/" to "\/"
	path_to_site=$(echo $path_to_site | sed -e 's/\//\\\//g');

	sudo cp "${src_dir}/example.conf" "/etc/nginx/sites-available/${1}.conf";
	sudo sed -i -e "s/|=domen=|/${1}/; s/|=path=|/${path_to_site}/" "/etc/nginx/sites-available/${1}.conf";
	unset src_dir path_to_site;

	echo "Site has been created!"
}