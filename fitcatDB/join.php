<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");
echo mysql_query("insert into user (username,password) values('".$_GET['username']."','".$_GET['password']."')");



