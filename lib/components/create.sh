CURRENT_DIR='./lib/components/'
create () {

	PATH_TO_SITE='/usr/share/nginx/';

	# Was user set 3-rd argument?
	if [[ $2 != "" ]];
	then
		PATH_TO_SITE=$2;
	fi

	# Is path to site exists?
	if ! [[ -d $PATH_TO_SITE ]];
	then
		echo "Error 128: no such file or directory \"$PATH_TO_SITE\"";
		return 128;
	fi

	# Is path to configs exists?
	if ! [[ -d /etc/nginx/sites-available ]];
	then
		mkdir /etc/nginx/sites-available;
	fi

	# Replace all "/" to "\/"
	PATH_TO_SITE=$(echo $PATH_TO_SITE | sed -e 's/\//\\\//g');

	cp "$CURRENT_DIR"sources/example.conf /etc/nginx/sites-available/$1.conf;
	sed -i -e "s/|=domen=|/$1/; s/|=path=|/$PATH_TO_SITE/" /etc/nginx/sites-available/$1.conf;
}