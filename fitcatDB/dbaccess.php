<?php
$link = mysql_connect('localhost', 'fitcatPublic', 'Cornellfitcat')
or die('Could not connect: ' . mysql_error());
mysql_select_db('fitcat') or die('Could not select database');
mysql_query("SET NAMES 'utf8'");
