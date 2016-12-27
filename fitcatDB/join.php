<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");
echo mysql_query("insert into user (email,password,username) values('".$_POST['useremail']."','".$_POST['password']."', '".$_POST['username']."')");



