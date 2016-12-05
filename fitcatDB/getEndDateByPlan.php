<?php

require_once "dbaccess.php";

$result = mysql_query("select * from plan where id = '".$_GET['a1']."' ");
$row = mysql_fetch_array( $result );

echo $row['end_date'];