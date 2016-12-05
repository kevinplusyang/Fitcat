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

echo $dateFormated;

echo "The time is " . date("h:i:sa");

$timeNow =  date("G:i:s"); //24 hour

echo $timeNow;

echo date("t");

mysql_query("insert into feed_record (cat_id,date,time,food_id,calories,volume) values('2','".$dateFormated."','".$timeNow."','2','200','200')");

?>