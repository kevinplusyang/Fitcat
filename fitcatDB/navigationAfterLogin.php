<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");
$result = mysql_query("select count(*) from cat where user_id = '".$_GET['user_id']."' ");

$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    echo "0";
}else{
    echo "1";
}


