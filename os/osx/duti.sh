###############################################################################
# Application defaults with duti
###############################################################################

if [ "$USER" = "kfinlay" ]
then
	# gem install xcode-installer

	if test ! $(which duti); then
	  echo "Installing duti..."
	  brew install duti
	fi

	duti -s net.sourceforge.skim-app.skim pdf all
	for EXT in ado cdb css do htm html json log m macosx mata osx php py r rb sh shtm shtml sty tex tm_properties txt xml
	do
		duti -s com.sublimetext.3 $EXT all
	done
	for EXT in csv dat
	do
		duti -s com.barebones.TextWrangler.TextWrangler $EXT all
	done
fi

exit 0
