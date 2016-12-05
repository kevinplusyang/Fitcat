
<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 11/28/16
 * Time: 7:30 PM
 */



//!!!!! This Line Wasted My two Hours!!!!!
require_once "dbaccess.php";
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

$foodId = $_GET['a1'];



$result = mysql_query("select * from food where id = '".$foodId."' ");

$row = mysql_fetch_array($result);


$foodName = $row['name'];
$cal = $row['kcalpercup'];
$ifWet = $row['ifWet'];
$standardCan = $row['standardCan'];



?>

    {
    "foodId":"<?php echo $foodId;?>",
    "foodName":"<?php echo $foodName?>",
    "cal":"<?php echo $cal?>",
    "ifWet":"<?php echo $ifWet?>",
    "standardCan":"<?php echo $standardCan?>"
    }


