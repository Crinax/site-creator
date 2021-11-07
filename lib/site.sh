#!/bin/bash

site () {
	local com_dir="${_SITE_CREATOR_SRC_DIR}/lib/components"

	case $1 in
		"create")
			source "${com_dir}/create.sh";
			create $2 $3;
			$_ERR_CODE=$?;
			unset -f create;
			return $_ERR_CODE;
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
			echo 'list';
		;;
		*)
			echo "Error 127: unknown command '$1'";
			return 127;
		;;
	esac
	unset com_dir;
}