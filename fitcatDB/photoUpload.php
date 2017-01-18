<?php
require_once "dbaccess.php";


//mysql_query("insert into user values ('','".$_GET['username']."','".$_GET['password']."')");



mysql_query("insert into test (str) values ('".$_FILES['testPhoto']['name']."') ");

$basePath = '/home/my434/fitCat/resources/img/';
    if(!is_dir($basePath)) {
        mkdir($basePath, 0777, true);
    }

//echo json_encode(array("success"    => true,
//));


// get picture variables
$file       = $_FILES['file']['tmp_name'];
$fileName   = $_FILES['file']['name'];
$fileType   = $_FILES['file']['type'];

try {
    $file1 = $_FILES['testPhoto'];

    if (is_uploaded_file($file1['tmp_name'])) {
        $photoPath = $basePath.$_FILES['testPhoto']['name'].'.jpg';

        if (move_uploaded_file($file1['tmp_name'], $photoPath)) {
echo json_encode(array("success"    => true,
));
        }
    }

} catch(Exception $ex){
    echo "ERROR:".$ex->GetMessage()."\n";
    exit(1);
}


