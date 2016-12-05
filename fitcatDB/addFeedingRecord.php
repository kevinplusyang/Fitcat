<?php
//-----------------------------
require_once "dbaccess.php";
date_default_timezone_set("America/New_York");
$now = time();
$num = date("w");
if ($num == 0)
{ $sub = 6; }
else { $sub = ($num-1); }
$WeekMon  = mktime(0, 0, 0, date("m", $now)  , date("d", $now)-$sub, date("Y", $now));    //monday week begin calculation
$todayh = getdate(date("U")); //monday week begin reconvert

$d = $todayh[mday];
$m = $todayh[mon];
$y = $todayh[year];
$dateFormated =  "$y-$m-$d"; //getdate converted day





$timeNow =  date("G:i:s"); //24 hour



mysql_query("insert into feed_record (cat_id,date,time,food_id,calories,volume) values('".$_GET['a1']."','".$dateFormated."','".$timeNow."','".$_GET['a2']."','".$_GET['a3']."','".$_GET['a4']."')");

?>