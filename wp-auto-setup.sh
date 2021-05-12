#!/bin/sh


#
# Enter arguments.
#
echo "Enter some arguments for installation."

while true; do

	echo -n "Target directory? (e.g., /path/to/wordpress) : "
	read TARGET_DIR
	
	if [ ! -d $TARGET_DIR ]; then
		echo "Target directory doesn't exist! Try again."
	else
		break
	fi

done

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
TARGET_DIR=${TARGET_DIR%/}
DOCUMENT_ROOT=${TARGET_DIR##*/}
SITE_URL=${SITE_URL%/}
SERVER_NAME=${SITE_URL#http*//}

if [ ! $DB_HOST ]; then
	DB_HOST="localhost"
fi


#
# Setup WordPress.
#
cd $TARGET_DIR
echo ""
wp core download --locale=ja
wp core config --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --locale=ja
wp core install --url=$SITE_URL --title="$SITE_TITLE" --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL
wp plugin activate wp-multibyte-patch


#
# Download and activate plugins.
#
PLUGIN="wp-multibyte-patch"
for I in $PLUGIN
do
	wp plugin install $I --activate
done


#
# Download and import theme unit data.
#
if [ "$IMPORT_DATA" = "y" -o "$IMPORT_DATA" = "yes" ]; then
	wget --no-check-certificate https://raw.githubusercontent.com/jawordpressorg/theme-test-data-ja/master/wordpress-theme-test-data-ja.xml
	wp import --authors=skip wordpress-theme-test-date-ja.xml
	rm -f wordpress-theme-test-date-ja.xml
fi


echo "Installation completed successfully. Have fun :)"
exit
