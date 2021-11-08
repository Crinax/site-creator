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
			source "${com_dir}/activate.sh";
			activate_site $2;
			$_ERR_CODE=$?;
			unset -f activate_site;
		;;
		"remove")
			source "${com_dir}/remove.sh";
			remove_site $2;
			$_ERR_CODE=$?;
			unset -f remove_site;
		;;
		"deactivate")
			source "${com_dir}/deactivate.sh";
			deactivate_site $2;
			$_ERR_CODE=$?;
			unset -f deactivate_site;
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

	if [ $_ERR_CODE -ne 0 ];
	then
		exit $_ERR_CODE;
	fi
	exit 0;
}