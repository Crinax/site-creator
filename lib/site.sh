#!/bin/bash

site () {
	local com_dir="${_SITE_CREATOR_SRC_DIR}/lib/components"

	case $1 in
		"create")
			source "${com_dir}/create.sh";
			create_site $2 $3;
			$_ERR_CODE=$?;
			unset -f create_site;
		;;
		"activate")
			echo 'activate';
		;;
		"remove")
			echo 'remove';
		;;
		"deactivate")
			echo 'deactivate';
		;;
		"list")
			source "${com_dir}/list.sh";
			site_list;
			$_ERR_CODE=$?;
			unset -f site_list;
		;;
		*)
			echo "Error 127: unknown command '$1'";
			return 127;
		;;
	esac
	unset com_dir;
	return $_ERR_CODE;
}