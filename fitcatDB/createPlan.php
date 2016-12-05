<?php
require_once "dbaccess.php";


//$user_id = $_GET['a1'];
//$name = $_GET['a2'];
//$birthday = $_GET['a3'];
//$breed_id = $_GET['a4'];
//$initial_weight = $_GET['a5'];
//$neutered = $_GET['a6'];
//$gender = $_GET['a7'];
//$initial_bcs = $_GET['a8'];
//$image_id = $_GET['a9'];

mysql_query("insert into plan (cat_id, start_date, end_date, weight_lose, weight_lose_per_month, calories_to_lose_per_day,food_volume_required ) values('".$_GET['a1']."','".$_GET['a2']."','".$_GET['a3']."','".$_GET['a4']."','".$_GET['a5']."','".$_GET['a6']."','".$_GET['a7']."')");
$result = mysql_query("select * from plan where cat_id = '".$_GET['a1']."' ");
$row = mysql_fetch_array( $result );
echo $row['id'];


