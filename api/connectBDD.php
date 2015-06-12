<?php
function getConnection() {
    $dbhost="moradbouzhmorad.mysql.db";
    $dbuser="moradbouzhmorad";
    $dbpass="LaboEpsi34";
    $dbname="moradbouzhmorad";
    $dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);
    $dbh->exec("set names utf8");
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $dbh;
}
?>