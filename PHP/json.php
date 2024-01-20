<?php

$db = "soiltest";
$server ="localhost";
$username ="root";
$password ="";
// mysqli database info

$link = mysqli_connect($server,$username,$password,$db);
// establishing the db connection

$json["error"]= false;
$json["errmsg"]="";
$json["data"]= array();

// select all information from the database

$sql = "SELECT * FROM nutrients ORDER BY sn ASC ";
$res = mysqli_query($link, $sql);
$numrows = mysqli_num_rows($res);
if($numrows>0){
// check if there is any data
$namelist = array();

while($array = mysqli_fetch_assoc($res)){
    array_push($json['data'], $array);
    // push fetched array to $json ['data']
}
}else{$json['error']= true;
    $json["errmsg"]=" No any Data to Show";
    
}
mysqli_close($link);

header('Content-Type: application/json');
// tell the browser that its jsno data
echo json_encode($json);



?>