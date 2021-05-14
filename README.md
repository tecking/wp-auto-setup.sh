# wp-auto-setup.sh

## What's this?

"wp-auto-setup.sh" is a shell script to install and activate WordPress into common hosting servers using [WP-CLI](https://wp-cli.org/).

Installation and activation process will be interactive.

* Related repositry  
[wp-cli.setup.sh](https://github.com/tecking/wp-cli.setup.sh)

## Requires

A hosting server that SSH access is allowed and is activated WP-CLI.

## Installation and usage

1. Connect to hosting server via SSH
2. Run ``wget --no-check-certificate https://raw.githubusercontent.com/tecking/wp-auto-setup/master/wp-auto-setup.sh``  
(you can download the script)
3. Run ``chmod +x wp-auto-setup.sh``
4. Open the script, set ``PLUGIN`` value
5. Run ``./wp-auto-setup.sh``
6. Following the prompts, enter some values

## Values

* locale (default = en-US)
* DB host (default = localhost)
* DB name
* DB user
* DB password
* site URL
* site title
* admin name
* admin password
* admin email
* importing theme unit test data(Japanese only)

## Notice

* Please use At Your Own Risk
* Tested environment (hosting servers)
  * [X SERVER](https://www.xserver.ne.jp/) (Japan)
* [Hello Dolly](https://ja.wordpress.org/plugins/hello-dolly/) plugin is automatically deleted.
* If you enter "ja" as the locale, the script installs and activates automatically [WP Multibyte Patch](https://ja.wordpress.org/plugins/wp-multibyte-patch/) plugin.


## Changelog

* 0.1.0 (2021-05-12)
  * Opening to the public

## License

[MIT License](http://opensource.org/licenses/mit-license.php)
