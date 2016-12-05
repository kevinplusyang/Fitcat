<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 11/27/16
 * Time: 4:09 PM
 */



require_once "dbaccess.php";


$result = mysql_query("select count(*) from favorite_food where user_id = '".$_GET['a1']."' ");

$row_count = mysql_fetch_array( $result );
if($row_count[0]==0) {
    ?>

    {
    "count": "0"
    }

    <?php
}else{
$result = mysql_query("select * from favorite_food where user_id = '".$_GET['a1']."' ");

$count = 0;

?>{
"foods":[
<?php
$row = mysql_fetch_array($result);
?>{"id":"<?php echo $row["food_id"] - 1?>"}<?php
$count++;
while($row = mysql_fetch_array($result)){
    $count++;
    ?>,{"id":"<?php echo $row["food_id"] - 1?>"}<?php

}
?>],
"count": "<?php echo $count?>"
}
<?php
}
?>









