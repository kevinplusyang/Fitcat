<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");
$result = mysql_query("select count(*) from user where email = '".$_POST['useremail']."' and password = '".$_POST['password']."' ");

$row_count = mysql_fetch_array( $result );

if($row_count[0]==0) {
    echo "0";
}else{
    $result = mysql_query("select * from user where email = '".$_POST['useremail']."' and password = '".$_POST['password']."' ");
    $row = mysql_fetch_array( $result );
    echo $row['id'];
}


