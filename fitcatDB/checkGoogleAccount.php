<?php
require_once "dbaccess.php";


$email = $_POST['email'];


$result = mysql_query("select count(*) from user where email = '".$email."' ");
$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    echo "0";
} else {
    $result = mysql_query("select * from user where email = '".$_POST['useremail']."'");
    $row = mysql_fetch_array( $result );
    echo $row['id'];
}




