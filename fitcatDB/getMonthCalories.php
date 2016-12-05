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

////a
//
$d = 30;
$m = 11;
$y = 2016;

$dateFormated =  "$y-$m-$d"; //getdate converted day





$timeNow =  date("G:i:s"); //24 hour



$dayNumber = date("t");

//echo $m;
//$i = 1;
//while ($i <= $dayNumber){
//    $newDateFormated = "$y-$m-$i";
//    echo $newDateFormated;
//    $i++;
//
//
//}

?>{"dayNumber":"<?php echo $d?>",<?php

?>"date":"<?php echo $dateFormated?>",<?php


?>"calData":[<?php

for($i = 1; $i <= $d; $i++){
    $newDateFormated = "$y-$m-$i";
    $result = mysql_query("select * from feed_record where cat_id = '".$_GET['a1']."' and date = '".$newDateFormated."' ");
    $calCount = 0;
    while ($row = mysql_fetch_array($result)){
        $calCount = $calCount + $row['calories'];
    }

    ?>{"data":"<?php echo $calCount;?>"<?php
    if($i != $d){
        ?>},<?php
    }else{
        ?>}<?php
    }
}
?>]}<?php


?>