#!/bin/bash
#
# Installer XFCE-DE
#
clear
#
:'
Notes:
This step for Pretty URL.
write config file like this :
---
$CONFIG = array (
  'overwrite.cli.url' => 'https://cloud.mydomain.com',
  'htaccess.RewriteBase' => '/nc',
---

exec Command like this:
---
sudo -u www-data ./occ maintenance:update:htaccess
---
'
pause 2
exit
