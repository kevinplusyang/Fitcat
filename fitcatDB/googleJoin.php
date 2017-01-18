<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");
echo mysql_query("insert into user (email,givenName,familyName,googleId,googleImage) values('".$_POST['useremail']."','".$_POST['userGivenName']."', '".$_POST['userFamilyName']."', '".$_POST['userGoogleID']."','".$_POST['userGoogleImageID']."')");



