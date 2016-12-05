<?php
require_once "dbaccess.php";


$user_id = $_GET['a1'];
$name = $_GET['a2'];
$birthday = $_GET['a3'];
$breed_id = $_GET['a4'];
$initial_weight = $_GET['a5'];
$neutered = $_GET['a6'];
$gender = $_GET['a7'];
$initial_bcs = $_GET['a8'];
$image_id = $_GET['a9'];

mysql_query("insert into cat (user_id,name,birthday,breed_id,initial_weight, current_weight,neutered,gender,initial_bcs,image_id) values('".$_GET['a1']."','".$_GET['a2']."','".$_GET['a3']."','".$_GET['a4']."','".$_GET['a5']."','".$_GET['a5']."','".$_GET['a6']."','".$_GET['a7']."','".$_GET['a8']."','".$_GET['a9']."')");
$result = mysql_query("select * from cat where user_id = '".$_GET['a1']."' and name = '".$_GET['a2']."' and birthday = '".$_GET['a3']."' ");
$row = mysql_fetch_array( $result );
echo $row['id'];


