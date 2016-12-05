<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 12/1/16
 * Time: 9:35 AM
 */


require_once "dbaccess.php";


$result = mysql_query("select count(*) from weight_record where cat_id = '".$_GET['a1']."' ");

$row_count = mysql_fetch_array( $result );
$num = $row_count[0];

$result = mysql_query("select * from weight_record where cat_id = '".$_GET['a1']."' order by date,time asc");

?>{"num":"<?php echo $num?>",<?php




?>"weight":[<?php
$i = 1;
while ($row = mysql_fetch_array($result)){


    ?>{"data":"<?php echo $row['weight'];?>"<?php
    if($i != $num){
        ?>},<?php
    }else{
        ?>}<?php
    }

    $i++;
}
?>]}<?php


?>

