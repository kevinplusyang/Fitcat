<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 12/5/16
 * Time: 1:59 PM
 */

require_once "dbaccess.php";

mysql_query("truncate cat");
mysql_query("truncate favorite_food ");
mysql_query("truncate feed_record");
mysql_query("truncate plan");
mysql_query("truncate user");
mysql_query("truncate weight_record");