#!/bin/bash




#Fie path of the file where the site urls are stored
FILE_URL="./.sites-to-grab.txt"

#Directory where the entry versions will be stored
dir="entries"



#Sound which is played when the scripts finds an updated entry
sound="/usr/share/sounds/freedesktop/stereo/dialog-information.oga"

function notify(){
    notify-send "A new update at $1"
    if test -f $sound; then
        paplay $sound
    fi
} 


function add_new_site_entry(){
	echo "$1 DOES NOT EXISTS, CREATING NEW ENTRY"
	update_site "$1" "$2"
}


function update_site(){
	cat $2 > $1
	rm -rf $2
}


readarray -t URLS < "$FILE_URL"




# We need to loop
for url in "${URLS[@]}"
do
    file_id="${url////-}"
	

	old_content="$dir/site-$file_id"
	new_content="$dir/.tmp/site-$file_id"

	touch $new_content	
	
	#echo "CHEKCING FOR UPDATES AT $url"	
	curl -s -L $url > $new_content

	#Check if old content exists

	if test ! -f "$old_content"; then
		add_new_site_entry "$old_content" "$new_content" 	
	else
		DIF=$(diff "$old_content" "$new_content")
		if  [ -n "$DIF" ]; then
		    notify "$url"	
			update_site "$old_content" "$new_content"
		else
			rm -rf $new_content
		fi
	fi
done

