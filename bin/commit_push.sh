#!/usr/bin/php
<?php 

$dir = dirname(dirname(__FILE__)) . '/';
chdir($dir);

system('git add -f ./');
system('git commit -a -m `date \'+%Y-%m-%d-%H-%M-%S\'`');
system('git push -u origin master');


