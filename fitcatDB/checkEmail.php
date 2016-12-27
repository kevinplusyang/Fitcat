<?php
require_once "dbaccess.php";


$email = $_POST['a1'];


$result = mysql_query("select count(*) from user where email = '".$email."' ");
$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    echo "0";
} else {
    echo "1";
}




