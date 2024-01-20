<?php
$server ='localhost';
$dbname = 'soiltest';
$username ='root';
$password ='';

$conn = mysqli_connect($server, $username, $password, $dbname);

if($conn->connect_error){
    die('connection fail'. $conn->connect_error);
}
echo 'connected successfull';


if(!empty($_POST)){
    // keep track of posts
    $nitrogen = $_POST['nitrogen'];
    $phosphorus = $_POST['phosphorus'];
    $potasium = $_POST['potasium'];

    // insert data to the db

    $insert ="INSERT INTO nutrients (nitrogen,phosphorus,potasium) VALUES ($nitrogen,$phosphorus,$potasium)";

    $stm->mysqli_query($conn, $insert);
    $conn-> close();
}

?>