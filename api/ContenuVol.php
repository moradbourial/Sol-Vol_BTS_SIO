<?php 
	///////////// Vols

	// GET Vols
	$app->get(
	    '/vols/:date',
	    function($date)
	    {
	        $vols = new Vols();
	        $allVols = $vols->getAllVols($date);
	        return $allVols;

	    }
	);

	// GET Vol
	$app->get(
	    '/vols/search/:destination',
	    function($destination) use ($app) 
	    {
	        $vols = new Vols();
	        $Vols = $vols->getVol($destination, $app);
	        return $Vols;    
	    }
	);
?>