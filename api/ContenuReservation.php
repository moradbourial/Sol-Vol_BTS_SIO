<?php

	///////////// RESERVATION

	// GET Reservation
	$app->get(
	    '/reservation/:id', 
	    function($id) use ($app)
	    {
	        $Bookings = new Reservation();
	        $booking = $Bookings->getResservation($id);
	        return $booking;
	    }
	);

	// DELT Reservation
	$app->delete(
	    '/reservation/:id', 
	    function($id) use ($app)
	    {
	        $Bookings = new Reservation();
	        $booking = $Bookings->deltReservation($id, $app);
	        return $booking;
	    }
	);

	// ADD Reservation
	$app->post(
	    '/reservation/:id',
	    function($id) use ($app)
	    {
	        $Bookings = new Reservation();
	        $booking = $Bookings->addReservation($id, $app);
	        return $booking;
	    }
	);
?>