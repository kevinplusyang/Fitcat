<?php
require_once "dbaccess.php";


$user_id = $_GET['a1'];
$food_id = $_GET['a2'];

$result = mysql_query("select count(*) from favorite_food where user_id = '".$user_id."' and food_id = '".$food_id."' ");
$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    mysql_query("insert into favorite_food (user_id,food_id) values('".$user_id."','".$food_id."')  ");
    echo "Added a new one";
} else {
    mysql_query("delete from favorite_food where user_id = '".$user_id."' and food_id = '".$food_id."'  ");
    echo "Deleted a tuple";
}




