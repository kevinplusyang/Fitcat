<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 11/29/16
 * Time: 6:45 PM
 */



require_once "dbaccess.php";

mysql_query("insert into test (str) VALUES('inonce') ");
mysql_query("update test set str = '".$_POST['uu']."' where id = 0");
mysql_query("insert into test (str) VALUES('".$_POST['uu']."') ");
mysql_query("insert into test (str) VALUES('inonce3') ");
