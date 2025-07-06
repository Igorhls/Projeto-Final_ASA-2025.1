<?php

$config = array();

// Database connection string (DSN) for read+write operations
$config['db_dsnw'] = 'sqlite:////var/www/html/db/sqlite.db';

// The mail host chosen to perform the log-in.
$config['default_host'] = 'dovecot';

// SMTP server host (for sending mails).
$config['smtp_server'] = 'postfix';

// SMTP port (default is 25; use 587 for STARTTLS or 465 for the
// deprecated SSL over SMTP (aka SMTPS))
$config['smtp_port'] = 25;

// SMTP username (if required) if you use %u as the username Roundcube
// will use the current username for login
$config['smtp_user'] = '%u';

// SMTP password (if required) if you use %p as the password Roundcube
// will use the current user's password for login
$config['smtp_pass'] = '%p';

// provide an URL where a user can get support for this Roundcube installation
// PLEASE DO NOT LINK TO THE ROUNDCUBE.NET WEBSITE HERE!
$config['support_url'] = '';

// Name your service. This is displayed on the login screen and in the window title
$config['product_name'] = 'Webmail ASA.BR';

// this key is used to encrypt the users imap password which is stored
// in the session record (and the client cookie if remember password is enabled).
// please provide a string of exactly 24 chars.
$config['des_key'] = 'rcmail-!24ByteDESkey*Str';

// List of active plugins (in plugins/ directory)
$config['plugins'] = array();

// skin name: folder from skins/
$config['skin'] = 'elastic';

// Disable spellchecker
$config['enable_spellcheck'] = false;

// Set the username domain
$config['username_domain'] = 'asa.br';

// Auto-create user on first login
$config['auto_create_user'] = true;

// IMAP connection options
$config['imap_conn_options'] = array(
    'ssl' => array(
        'verify_peer'  => false,
        'verify_peer_name' => false,
    ),
);

// SMTP connection options
$config['smtp_conn_options'] = array(
    'ssl' => array(
        'verify_peer'      => false,
        'verify_peer_name' => false,
    ),
);

include(__DIR__ . '/config.docker.inc.php');
