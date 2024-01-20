<?php

if(isset($_GET["nitrogen"])) {
   $nitrogen = $_GET["nitrogen"]; // get nitrogen value from HTTP GET
   $phosphorus = $_GET["phosphorus"]; // get nitrogen value from HTTP GET
   $potassium = $_GET["potassium"]; // get nitrogen value from HTTP GET


   $servername = "localhost";
   $username = "root";
   $password = "";
   $dbname = "soiltest";

   // Create connection
   $conn = new mysqli($servername, $username, $password, $dbname);
   // Check connection
   if ($conn->connect_error) {
      die("Connection failed: " . $conn->connect_error);
   }

   $sql = "INSERT INTO nutrients (nitrogen, phosphorus, potassium) VALUES ($nitrogen, $phosphorus, $potassium)";

   if ($conn->query($sql) === TRUE) {
      echo "New record created successfully";
   } else {
      echo "Error: " . $sql . " => " . $conn->error;
   }

   $conn->close();
} else {
   echo "nutrients is not set";
}
?>
