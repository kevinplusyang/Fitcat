<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 11/29/16
 * Time: 6:45 PM
 */



require_once "dbaccess.php";


mysql_query("update cat set image_id = '".$_POST['photoID']."' where id = '".$_POST['catID']."' ");
