<?php
	///////////// CONNECTION

	// GET Connection
	$app->get(
	    '/connection/:user',
	    function($user) use ($app) 
	    {
	        $Connection = new Utilisateur();
	        $connec = $Connection->getConection($user, $app);
	        return $connec;    
	    }
	);

	// ADD User
	$app->post(
	    '/connection/:user',
	    function($user) use ($app)
	    {

	        $request = $app->request();
	        $body = $request->getBody();
	        $newUser = json_decode($body);
	        $Connection = new Utilisateur();
	        $connec = $Connection->addUser($user, $newUser);
	        return $connec;
	    }
	);
?>