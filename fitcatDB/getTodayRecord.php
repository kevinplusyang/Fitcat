<?php




//!!!!! This Line Wasted My two Hours!!!!!
require_once "dbaccess.php";
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

$userId = $_GET['a1'];

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






$result = mysql_query("select count(*) from feed_record where cat_id = '".$_GET['a1']."' and date = '".$dateFormated."' ");

$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    ?>

    {
    "count": "0"
    }

    <?php
}else{


    ?>{"date":[<?php
    $result = mysql_query("select * from feed_record where cat_id = '".$_GET['a1']."' and date = '".$dateFormated."' ");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $date = $row['date'];
        ?>{"num":"<?php echo $date;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php

    ?>"cal":[<?php
    $result = mysql_query("select * from feed_record where cat_id = '".$_GET['a1']."' and date = '".$dateFormated."' ");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $cal = $row['calories'];
        ?>{"num":"<?php echo $cal;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php


    ?>"food":[<?php
    $result = mysql_query("select * from feed_record where cat_id = '".$_GET['a1']."' and date = '".$dateFormated."' ");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $food = $row['volume'];
        ?>{"num":"<?php echo $food;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],



    "count":"<?php echo $row_count[0] ?>"<?php


}
?>
}

