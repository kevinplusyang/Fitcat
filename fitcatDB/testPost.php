<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");

$p1 = $_POST['username'];

mysql_query("insert into test (str) values ('".$p1."') ");
