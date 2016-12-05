<?php




//!!!!! This Line Wasted My two Hours!!!!!
require_once "dbaccess.php";
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

date_default_timezone_set("America/New_York");


$catId = $_GET['catId'];

$result =  mysql_query("select * from cat where id = '".$catId."' ");
$row = mysql_fetch_array($result);
$catName = $row['name'];

$result =  mysql_query("select * from plan where cat_id = '".$catId."' ");
$row = mysql_fetch_array($result);
$caloriesTotal = $row['calories_to_lose_per_day'];

$result =  mysql_query("select * from plan where cat_id = '".$catId."' ");
$row = mysql_fetch_array($result);
$foodTotal = $row['food_volume_required'];

$result =  mysql_query("select * from plan where cat_id = '".$catId."' ");
$row = mysql_fetch_array($result);
$weightToLoss = $row['weight_lose'];

$result =  mysql_query("select * from cat where id = '".$catId."' ");
$row = mysql_fetch_array($result);
$initialWeight = $row['initial_weight'];

$goalWeight = $initialWeight - $weightToLoss;

$result =  mysql_query("select * from cat where id = '".$catId."' ");
$row = mysql_fetch_array($result);
$currentWeight = $row['current_weight'];

$result =  mysql_query("select * from cat where id = '".$catId."' ");
$row = mysql_fetch_array($result);
$initial_bcs = $row['initial_bcs'];


$goalBCS =5;

$result =  mysql_query("select * from cat where id = '".$catId."' ");
$row = mysql_fetch_array($result);
$photoID = $row['image_id'];




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

$calResult = mysql_query("select * from feed_record where cat_id = '".$catId."' and date = '".$dateFormated."' ");
$calCount = 0;
while ($calRow = mysql_fetch_array($calResult)){
    $calCount = $calRow['calories'] + $calCount;
}


$foodResult = mysql_query("select * from feed_record where cat_id = '".$catId."' and date = '".$dateFormated."' ");
$foodCount = 0;
while ($foodRow = mysql_fetch_array($foodResult)){
    $foodCount = $foodRow['volume'] + $foodCount;
}



?>


{
"catId": "<?php echo $catId?>",
"catName": "<?php echo $catName?>",
"calories_total": "<?php echo $caloriesTotal?>",
"calories_today": "<?php echo $calCount;?>",
"food_total": "100",
"food_today": "<?php  echo $foodCount?>>",
"goal_weight": "<?php echo $goalWeight?>",
"current_weight": "<?php echo $currentWeight?>",
"current_bcs": "<?php echo $initial_bcs?>",
"goal_bcs": "<?php echo $goalBCS?>",
"weight_lose": "<?php echo $weightToLoss?>",
"initial_weight": "<?php echo $initialWeight?>",
"img_ID": "<?php echo $photoID?>"
}
