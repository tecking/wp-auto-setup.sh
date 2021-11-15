#!/bin/sh

#
# Initialize.
# - Set value that slug of the plugin(s) you want to install.
#
PLUGIN=""


#
# Enter arguments.
#
echo "Enter some values for installation."

while true; do

	echo -n "Target directory? (e.g., /path/to/wordpress) : "
	read TARGET_DIR
	
	if [ ! -d $TARGET_DIR ]; then
		echo "Target directory doesn't exist! Try again."
	else
		break
	fi

done

echo -n "Locale? (default = en-US) : "
read LOCALE

echo -n "DB host? (default = localhost) : "
read DB_HOST

echo -n "DB name? : "
read DB_NAME

echo -n "DB user? : "
read DB_USER

echo -n "DB password? : "
read DB_PASSWORD

echo -n "Site URL? (e.g., https://www.example.com) : "
read SITE_URL

echo -n "Site title? : "
read SITE_TITLE

echo -n "Admin name? : "
read ADMIN_NAME

echo -n "Admin password? : "
read ADMIN_PASSWORD

echo -n "Admin email? : "
read ADMIN_EMAIL

echo -n "Import theme unit test data(ja)? (y/n) : "
read IMPORT_DATA


#
# Replace strings and assign variables.
#
SITE_URL=${SITE_URL%/}

if [ ! $DB_HOST ]; then
	DB_HOST="localhost"
fi

if [ $LOCALE ]; then
	OPTION_LOCALE="--locale=$LOCALE"
else
	OPTION_LOCALE=""
fi


#
# Setup WordPress.
#
cd $TARGET_DIR
echo ""
wp core download $OPTION_LOCALE
wp core config --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD $OPTION_LOCALE
wp core install --url=$SITE_URL --title="$SITE_TITLE" --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL


#
# Download and activate plugins.
#
if [ "$LOCALE" = "ja" ]; then
	PLUGIN="$PLUGIN wp-multibyte-patch"
fi
for I in PLUGIN
do
	wp plugin install $I --activate
done
wp plugin delete hello-dolly


#
# Download and import theme unit data.
#
if [ "$IMPORT_DATA" = "y" -o "$IMPORT_DATA" = "yes" ]; then
	wp plugin install wordpress-importer --activate
	wget --no-check-certificate https://raw.githubusercontent.com/jawordpressorg/theme-test-data-ja/master/wordpress-theme-test-data-ja.xml
	wp import wordpress-theme-test-data-ja.xml --authors=skip
	rm -f wordpress-theme-test-date-ja.xml
fi


echo "Installation completed successfully. Have fun :)"
exit
