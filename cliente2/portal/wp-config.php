<?php
/* That's all, stop editing! Happy publishing. */
define('WP_HOME','http://localhost/cms');
define('WP_SITEURL','http://localhost/cms');


/* That's all, stop editing! Happy publishing. */

define('DB_NAME', 'example');
define('DB_USER', 'example');
define('DB_PASSWORD', 'example');
define('DB_HOST', 'db');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

/**#@+
 * Chaves únicas de autenticação e salts.
 * Gere em: https://api.wordpress.org/secret-key/1.1/salt/
 */
define('AUTH_KEY',         'y+Ivj/>Z5<i8LBd|=l4p.RL.CT,-~rPU(rNiMwNoMdR%RX}g7-0<#;y8>[<Hr#/Z');
define('SECURE_AUTH_KEY',  '*MKJ->?2 WI9_Dlh.,$( M0S%ls_-4++F^aS0^m]iIMltKumOD/tJ4|`J1T`@w}+');
define('LOGGED_IN_KEY',    'TuTOX_Z)oc*S2d2sHW00t7<[h,lVT1Y69Z_JY#DUeTB`)Fr9wP+8dN1z$k-q__Ip');
define('NONCE_KEY',        'n>l/|n3o>9cp8-cI<T1=VgPQCWZ`+t9x:NfGxw7Hhn#_rZ;t7Aml7,-oV1c&.4YC');
define('AUTH_SALT',        '9?jRS(R6n;P<lZhZ/SeaF)M>&J4`p.ar!1Om&BRjx^|]o8X^bds 4X?4LijW,38t');
define('SECURE_AUTH_SALT', '-0.%-IN|5#+fE.it3aQvh.FFNfO^8O]9Z5h||,Fm+/j<0P|4}Djaj1yk61k>jji6');
define('LOGGED_IN_SALT',   'F&Rs4L8X[NUjGx.N+!p;NKXg/kLb30psZ-n+ =N!~_ATuPM0LtRzc1KHX+Y=2i=m');
define('NONCE_SALT',       'b[a%(3b~h?i9i dMJDg$6(,En+)vu_-#:--6++ZF;X={toQ6q1Y:O7!R-<jg/o$W');

/**#@-*/

$table_prefix = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');

