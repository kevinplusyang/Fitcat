<?php
require_once "dbaccess.php";


$user_id = $_POST['a1'];
$name = $_POST['a2'];
$birthday = $_POST['a3'];
$breed_id = $_POST['a4'];
$initial_weight = $_POST['a5'];
$neutered = $_POST['a6'];
$gender = $_POST['a7'];
$initial_bcs = $_POST['a8'];
$image_id = $_POST['a9'];

mysql_query("insert into cat (user_id,name,birthday,breed_id,initial_weight, current_weight,neutered,gender,initial_bcs,image_id) values('".$_POST['a1']."','".$_POST['a2']."','".$_POST['a3']."','".$_POST['a4']."','".$_POST['a5']."','".$_POST['a5']."','".$_POST['a6']."','".$_POST['a7']."','".$_POST['a8']."','".$_POST['a9']."')");
$result = mysql_query("select * from cat where user_id = '".$_POST['a1']."' and name = '".$_POST['a2']."' and birthday = '".$_POST['a3']."' ");
$row = mysql_fetch_array( $result );
echo $row['id'];
