<?php
/**
 * Created by PhpStorm.
 * User: mingyang
 * Date: 12/5/16
 * Time: 1:40 PM
 */

require_once "dbaccess.php";

mysql_query("delete from feed_record where cat_id = '1'");

mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('1','1','2016-11-30','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('2','1','2016-11-29','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('3','1','2016-11-28','10:00:00','1','500','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('4','1','2016-11-27','10:00:00','1','100','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('5','1','2016-11-26','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('6','1','2016-11-25','10:00:00','1','400','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('7','1','2016-11-24','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('8','1','2016-11-23','10:00:00','1','400','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('9','1','2016-11-22','10:00:00','1','500','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('10','1','2016-11-21','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('11','1','2016-11-20','10:00:00','1','100','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('12','1','2016-11-19','10:00:00','1','500','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('13','1','2016-11-18','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('14','1','2016-11-17','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('15','1','2016-11-16','10:00:00','1','100','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('16','1','2016-11-15','10:00:00','1','400','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('17','1','2016-11-14','10:00:00','1','500','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('18','1','2016-11-13','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('19','1','2016-11-12','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('20','1','2016-11-11','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('21','1','2016-11-10','10:00:00','1','400','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('22','1','2016-11-9','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('23','1','2016-11-8','10:00:00','1','100','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('24','1','2016-11-7','10:00:00','1','500','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('25','1','2016-11-6','10:00:00','1','400','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('26','1','2016-11-5','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('27','1','2016-11-4','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('28','1','2016-11-3','10:00:00','1','300','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('29','1','2016-11-2','10:00:00','1','200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('30','1','2016-11-1','10:00:00','1','400','30')");



mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('31','1','2016-12-1','10:00:00','1','9000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('32','1','2016-10-1','10:00:00','1','10000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('33','1','2016-9-1','10:00:00','1','8000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('34','1','2016-8-1','10:00:00','1','11000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('35','1','2016-7-1','10:00:00','1','7000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('36','1','2016-6-1','10:00:00','1','9000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('37','1','2016-5-1','10:00:00','1','10000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('38','1','2016-4-1','10:00:00','1','10200','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('39','1','2016-3-1','10:00:00','1','9500','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('40','1','2016-2-1','10:00:00','1','8000','30')");
mysql_query("insert into feed_record (id,cat_id,date,time,food_id,calories,volume) VALUES ('41','1','2016-1-1','10:00:00','1','7000','30')");


mysql_query("insert into weight_record (id,cat_id,date,time,weight) values('1','1','2016-12-05','14:03:25','14') ");
mysql_query("insert into weight_record (id,cat_id,date,time,weight) values('2','1','2016-12-05','14:03:30','14.30') ");
mysql_query("insert into weight_record (id,cat_id,date,time,weight) values('3','1','2016-12-05','14:03:33','13.8') ");
mysql_query("insert into weight_record (id,cat_id,date,time,weight) values('4','1','2016-12-05','14:03:36','12') ");
mysql_query("insert into weight_record (id,cat_id,date,time,weight) values('6','1','2016-12-05','14:03:40','13') ");