#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# Author: Naacal
# Date: 19 March 2016

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Usage: ./install.sh

# ---------------------------------------------------------------------------

timestamp=`/bin/date +s%s`

target_file="$HOME/.bash_profile"
backup_file="${target_file}.pk.bck-saved-${timestamp}"

# Print a message to the console.
log() { printf "$*\n" ; return $? ; }

# Print an error message to the console and bail out of the script.
fail() { log "\nERROR: $*\n" ; exit 1 ; }

welcome() {
	echo "This is going to install your new bash profile."
	sleep 2

	echo ""
}

backup() {
	if [ -f "${target_file}" ]
	then
		echo "Backing up the existin .bash_profile file."
		sleep 1
		cp ${target_file} ${backup_file} || fail "The backup for ${target_file} was not created! Please make sure this directory is writable!"
		echo "The backup location is: ${backup_file}"

		sleep 2

		echo ""
	else
		touch "${target_file}"
		backup
	fi
}

download() {
	curl -sSL https://github.com/naacal/.bash_profile/blob/master/.bash_profile > ${target_file} || fail "Could not download bash_profile"
	sleep 2

	source $target_file

	echo ""
	echo "Please restart the terminal for the changes to take effect"
	echo ""

	sleep 1
}
welcome
backup
download
