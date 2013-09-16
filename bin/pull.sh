#!/usr/bin/php
<?php 

$dir = dirname(dirname(__FILE__)) . '/';
chdir($dir);
system('git pull -u origin master');

