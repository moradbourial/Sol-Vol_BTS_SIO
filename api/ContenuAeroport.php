<?php 
	///////////// Aeroports

	// GET aeroports
	$app->get(
	    '/aeroports',
	    function () {
	        $aeroports = new Aeroports();
	        $allAeroports = $aeroports->getAllAeroports();
	        return $allAeroports;

	    }
	);

	///////////// Destinations

	// GET destinations
	$app->get(
	    '/destinations',
	    function () {
	        $destinations = new Destinations();
	        $allDestinations = $destinations->getAllDestinations();
	        return $allDestinations;

	    }
	);
?>