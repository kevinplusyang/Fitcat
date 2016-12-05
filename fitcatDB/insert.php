<?php
require_once "dbaccess.php";


mysql_query("insert into test values ('".$_GET['id']."')");


echo "Now Here";
