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



mysql_query("insert into weight_record (cat_id,date,time,weight) values('".$_GET['a1']."','".$dateFormated."','".$timeNow."','".$_GET['a2']."')");
mysql_query("update cat set current_weight = '".$_GET['a2']."' where id = '".$_GET['a1']."' ");

?>