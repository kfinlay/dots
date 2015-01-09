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

	for EXT in pdf
	do
		duti -s net.sourceforge.skim-app.skim $EXT all
	done
	for EXT in bib cdb css htm html json log m macosx md mdown markdown osx php py r rb ris sh shtm shtml statalog sty tex tm_properties txt xml
	do
		duti -s com.sublimetext.3 $EXT all
	done
	for EXT in csv dat
	do
		duti -s com.barebones.TextWrangler.TextWrangler $EXT all
	done
	for EXT in ado do mata
	do
		duti -s com.stata.stata13 $EXT all
	done
	for EXT in avi wav
	do
		duti -s org.videolan.vlc $EXT all
	done

fi

exit 0
