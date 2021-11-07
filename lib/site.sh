#!/bin/bash

# source components/create
# source components/activate
# source components/remove
# source components/deactivate

CURRENT_DIR='./lib/'

site () {
	case $1 in
		"create")
			source "$CURRENT_DIR"components/create.sh;
			create $2 $3;
			$ERR_CODE=$?;
			unset -f create;
			return $ERR_CODE;
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
		*)
			echo "Error 127: unknown command '$1'";
			return 127;
		;;
	esac
}