<?php

/* Local configuration for Roundcube Webmail */

// ----------------------------------
// IMAP
// ----------------------------------
// The IMAP host (and optionally port number) chosen to perform the log-in.
// Leave blank to show a textbox at login, give a list of hosts
// to display a pulldown menu or set one host as string.
// Enter hostname with prefix ssl:// to use Implicit TLS, or use
// prefix tls:// to use STARTTLS.
// If port number is omitted it will be set to 993 (for ssl://) or 143 otherwise.
// Supported replacement variables:
// %n - hostname ($_SERVER['SERVER_NAME'])
// %t - hostname without the first part
// %d - domain (http hostname $_SERVER['HTTP_HOST'] without the first part)
// %s - domain name after the '@' from e-mail address provided at login screen
// For example %n = mail.domain.tld, %t = domain.tld
// WARNING: After hostname change update of mail_host column in users table is
//          required to match old user data records with the new host.
$config['imap_host'] = 'dovecot';

// ----------------------------------
// SMTP
// ----------------------------------
// SMTP server host (and optional port number) for sending mails.
// Enter hostname with prefix ssl:// to use Implicit TLS, or use
// prefix tls:// to use STARTTLS.
// If port number is omitted it will be set to 465 (for ssl://) or 587 otherwise.
// Supported replacement variables:
// %h - user's IMAP hostname
// %n - hostname ($_SERVER['SERVER_NAME'])
// %t - hostname without the first part
// %d - domain (http hostname $_SERVER['HTTP_HOST'] without the first part)
// %z - IMAP domain (IMAP hostname without the first part)
// For example %n = mail.domain.tld, %t = domain.tld
// To specify different SMTP servers for different IMAP hosts provide an array
// of IMAP host (no prefix or port) and SMTP server e.g. ['imap.example.com' => 'smtp.example.net']
$config['smtp_host'] = 'postfix:25';

// Database connection string (DSN) for read+write operations
$config['db_dsnw'] = 'sqlite:////var/roundcube/db/sqlite.db?mode=0646';

// IMAP connection options
$config['imap_conn_options'] = array (
  'ssl' => 
  array (
    'verify_peer' => false,
    'verify_peer_name' => false,
  ),
);

// SMTP connection options
$config['smtp_conn_options'] = array (
  'ssl' => 
  array (
    'verify_peer' => false,
    'verify_peer_name' => false,
  ),
);

// provide an URL where a user can get support for this Roundcube installation
// PLEASE DO NOT LINK TO THE ROUNDCUBE.NET WEBSITE HERE!
$config['support_url'] = '';

// Location of temporary saved files such as attachments and cache files
// must be writeable for the user who runs PHP process (Apache user if mod_php is being used)
$config['temp_dir'] = '/tmp/roundcube-temp';

// this key is used to encrypt the users imap password which is stored
// in the session record (and the client cookie if remember password is enabled).
// please provide a string of exactly 24 chars.
$config['des_key'] = 'f8ognWyfu3GD2yANjtYMKKjk';

// Name your service. This is displayed on the login screen and in the window title
$config['product_name'] = 'Webmail ASA.BR';

// Specifies the full path of the original HTTP request, either as a real path or
// $_SERVER field name. This might be useful when Roundcube runs behind a reverse
// proxy using a subpath. This is a path part of the URL, not the full URL!
// The reverse proxy config can specify a custom header (e.g. X-Forwarded-Path) containing
// the path under which Roundcube is exposed to the outside world (e.g. /rcube/).
// This header value is then available in PHP with $_SERVER['HTTP_X_FORWARDED_PATH'].
// By default the path comes from  'REDIRECT_SCRIPT_URL', 'SCRIPT_NAME' or 'REQUEST_URI',
// whichever is set (in this order).
$config['request_path'] = '/';

// List of active plugins (in plugins/ directory)
$config['plugins'] = ['archive', 'zipdownload'];

include(__DIR__ . '/config.docker.inc.php');
