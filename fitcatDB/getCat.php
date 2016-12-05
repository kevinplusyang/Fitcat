<?php

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







//!!!!! This Line Wasted My two Hours!!!!!
require_once "dbaccess.php";
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

$userId = $_GET['a1'];


$result = mysql_query("select count(*) from cat where user_id = '".$userId."' ");

$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    ?>

    {
    "count": "0"
    }

    <?php
}else{


    ?>{"catID":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $cat_id = $row['id'];
        ?>{"id":"<?php echo $cat_id;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php

    ?>"catName":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $cat_name = $row['name'];
        ?>{"id":"<?php echo $cat_name;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php


    ?>"imgID":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $img = $row['image_id'];
        ?>{"id":"<?php echo $img;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php



    ?>"calTotal":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $cat_id = $row['id'];

        $result2 = mysql_query("select * from plan where cat_id = '".$cat_id."' ");
        $row2 = mysql_fetch_array($result2);
        $calTotal = $row2['calories_to_lose_per_day'];

        ?>{"cal":"<?php echo $calTotal;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php



    ?>"calCurrent":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");

    for($i = 0; $i < $row_count[0]; $i++){

        $row = mysql_fetch_array($result);
        $cat_id = $row['id'];



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

        $calResult = mysql_query("select * from feed_record where cat_id = '".$cat_id."' and date = '".$dateFormated."' ");
        $calCount = 0;
        while ($calRow = mysql_fetch_array($calResult)){
            $calCount = $calRow['calories'] + $calCount;
        }




        ?>{"cal":"<?php echo $calCount;?>"<?php
        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php


    ?>"foodTotal":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");
    for($i = 0; $i < $row_count[0]; $i++){
        $row = mysql_fetch_array($result);
        $cat_id = $row['id'];

        $result2 = mysql_query("select * from plan where cat_id = '".$cat_id."' ");
        $row2 = mysql_fetch_array($result2);
        $calTotal = $row2['food_volume_required'];

        ?>{"cal":"100"<?php

        if($i != $row_count[0] - 1){
            ?>},<?php
        }else{
            ?>}<?php
        }
    }
    ?>],<?php

    ?>"foodCurrent":[<?php
    $result = mysql_query("select * from cat where user_id = '".$userId."'");
    for($i = 0; $i < $row_count[0]; $i++){

        $row = mysql_fetch_array($result);
        $cat_id = $row['id'];


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

        $foodResult = mysql_query("select * from feed_record where cat_id = '".$cat_id."' and date = '".$dateFormated."' ");
        $foodCount = 0;
        while ($foodRow = mysql_fetch_array($foodResult)){
            $foodCount = $foodRow['volume'] + $foodCount;
        }




        ?>{"cal":"<?php echo $foodCount?>"<?php
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

