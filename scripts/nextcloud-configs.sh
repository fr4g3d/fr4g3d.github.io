#!/bin/bash
#
# NextCloud OCC Configs
#
clear
#
#

cd
sudo sh -c "printf \"
<?php
$CONFIG = array (
  'instanceid' => 'oc6rmcfv8k0h',
  'passwordsalt' => 'mSlhPX4dM0qT8EBY8BkPiUWQhFbHy4',
  'secret' => 'fxc7G0l4h1tB++BKpg18hvXTr+a/fGPIChR+oNhjmpCEhElm',
  'trusted_domains' => 
  array (
    0 => 'nxcbmd.lan',
  ),
  'datadirectory' => '/var/www/.nc/data',
  'dbtype' => 'mysql',
  'version' => '23.0.12.2',
  'overwrite.cli.url' => 'http://nxcbmd.lan',
  'htaccess.RewriteBase' => '/',
  'dbname' => 'nextcloud',
  'dbhost' => 'localhost',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'mysql.utf8mb4' => true,
  'dbuser' => 'nextcloud',
  'dbpassword' => 'nextcloud@123',
  'installed' => true,
  'default_timezone' => 'Asia/Jakarta',
  'default_phone_region' => 'ID',
  'enable_previews' => true,
  'preview_concurrency_all' => '16',
  'preview_concurrency_new' => '8',
  'preview_max_scale_factor' => '1.3',
  'preview_max_x' => '1280',
  'preview_max_y' => '720',
  'preview_max_filesize_image' => '32',
  'preview_max_memory' => '128',
  'preview_ffmpeg_path' => '/usr/bin/ffmpeg',
  'enabledPreviewProviders' => 
  array (
    0 => 'OC\\Preview\\Movie',
    1 => 'OC\\Preview\\PNG',
    2 => 'OC\\Preview\\JPEG',
    3 => 'OC\\Preview\\GIF',
    4 => 'OC\\Preview\\BMP',
    5 => 'OC\\Preview\\XBitmap',
    6 => 'OC\\Preview\\MP3',
    7 => 'OC\\Preview\\TXT',
    8 => 'OC\\Preview\\MarkDown',
    9 => 'OC\\Preview\\OpenDocument',
    10 => 'OC\\Preview\\PDF',
    11 => 'OC\\Preview\\Krita',
  ),
  'jpeg_quality' => '69',
);
\" > config.php.txt"
sleep 1
sudo ln -sf /var/www/.nc nxcf
sudo ln -sf /var/www/.nc/config nxcfcf
sleep 2
sudo -u www-data php nxcf/occ config:app:set previewgenerator squareSizes --value="64 128 256"
sleep 1
sudo -u www-data php nxcf/occ config:app:set previewgenerator widthSizes --value="64 128 256"
sleep 1
sudo -u www-data php nxcf/occ config:app:set previewgenerator heightSizes --value="64 128 256"
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_concurrency_all --value=16
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_concurrency_new --value=8
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_max_scale_factor --value=1.3
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_max_x --value 1280
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_max_y --value 720
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_max_filesize_image --value 32
sleep 1
sudo -u www-data php nxcf/occ config:system:set preview_max_memory --value 128
sleep 1
sudo -u www-data php nxcf/occ config:system:set jpeg_quality --value 69
sleep 1
sudo -u www-data php nxcf/occ config:app:set preview jpeg_quality --value=71
sleep 1

sudo -s
find /var/www/.nc/data/appdata_*/preview/ -name \*.*g -type f -delete
exit

sleep 1
sudo -u www-data php nxcf/occ files:scan-app-data
sleep 1
sudo -u www-data php nxcf/occ preview:delete_old
sleep 1
sudo -u www-data php nxcf/occ preview:pre-generate
sleep 1
sudo -u www-data php nxcf/occ preview:generate-all -vvv
sleep 1
sudo -u www-data php nxcf/occ preview:delete_old
sleep 1
sudo -u www-data php nxcf/occ files:scan-app-data

sleep 1
echo Well Done.
sleep 3
clear
