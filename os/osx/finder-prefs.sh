###############################################################################
# Finder defaults: change sidebar list
###############################################################################

if [ "$USER" = "kfinlay" ]
	then

	if test ! $(which Change_Sidebar_List.py); then
	  echo "Installing Change_Sidebar_List.py..."
	  curl -O https://raw.githubusercontent.com/matt4836/changeSidebarLists/master/Change_Sidebar_List.py
	  chmod +x Change_Sidebar_List.py
	fi

	./Change_Sidebar_List.py list

	for SIDEBARITEM in "HOMEDIR/Library" "HOMEDIR" "HOMEDIR/Dropbox/projects" "HOMEDIR/git" "HOMEDIR/Dropbox"
	do
		./Change_Sidebar_List.py first $SIDEBARITEM
	done

	for SIDEBARITEM in "All My Files" "iCloud" "AirDrop"
	do
		./Change_Sidebar_List.py remove $SIDEBARITEM
	done

	./Change_Sidebar_List.py list
	
fi

exit 0
