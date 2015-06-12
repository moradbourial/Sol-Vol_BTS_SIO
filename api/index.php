<?php
require 'Slim/Slim.php';
require 'connectBDD.php';
require 'token.php';
require 'clients.php';
require 'aeroports.php';
require 'destinations.php';
require 'reservation.php';
require 'vols.php';
require 'connection.php';

///IF token VAlide + id + email + password 



\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

///////////// CONNECTION
require 'ContenuConnection.php';

///////////// CLIENT

require 'ContenuClient.php';

///////////// Aeroports

require 'ContenuAeroport.php';

///////////// Vols

require 'ContenuVol.php';

///////////// RESERVATION

require 'ContenuReservation.php';


$app->run();

// else New token 