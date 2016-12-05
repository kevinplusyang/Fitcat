<?php

require_once "dbaccess.php";

$result = mysql_query("select * from cat where user_id = 1 ");

$row = mysql_fetch_array($result);

$str = $row['name'];

while($row = mysql_fetch_array($result)){
   $str = $str .',' . $row['name'];
}

echo $str;


