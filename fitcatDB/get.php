<?php
require_once "dbaccess.php";



$result = mysql_query("select * from test ");
$row = mysql_fetch_array($result);
$decision_id = $row['id'];

echo $decision_id;
