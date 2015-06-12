<?php
class Reservation
{

	function getResservation($id){
		$ReservationPassager = array();
		// $NbrVol = "SELECT count(id_vols) as NombreVol FROM reservation WHERE id_clients=:id_clients";
		$sql = "SELECT * FROM reservation WHERE id_clients=:id_clients";
		// $vol = "SELECT * FROM vols WHERE id_vols=:id_vols";
	    try {
	        $db = getConnection();

	        // $stmt = $db->prepare($NbrVol);
	        // $stmt->bindParam(":id_clients", $id);       
	        // $stmt->execute();
	        // $reservation = $stmt->fetch();
	        // $NombreVol = intval($reservation['NombreVol']);

	        $stmt = $db->prepare($sql);
	        $stmt->bindParam(":id_clients", $id);       
	        $stmt->execute();
	        $reservation = $stmt->fetchAll(PDO::FETCH_OBJ);
	        

	        // for ($i=0; $i < $NombreVol ; $i++) 
	        // { 
	        // 	$stmt = $db->prepare($vol);
	        // 	$stmt ->bindParam(":id_vols", $reservation[$i]->id_vols); 
	        // 	$stmt->execute();
	        // 	$ReservationPassager[$i] = $stmt->fetchAll(PDO::FETCH_OBJ);

	        // }

	        

	        $db = null;

	        echo json_encode($reservation);

	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	}

	function deltReservation($id, $app)
	{

		$request = $app->request();
        $id_vols = $request->get('id_vols');
		$sql = "DELETE FROM reservation WHERE id_vols=:id_vols and id_clients =:id_clients";
	    try {

	        $db = getConnection();
	        $stmt = $db->prepare($sql);
	        $stmt->bindParam("id_vols", $id);
	        $stmt->bindParam("id_clients", $id_vols);
	        $stmt->execute();
	        $db = null;
	        echo "Reservation supprimer";
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }

	}

	function addReservation($id, $app)
	{

		$request = $app->request();
        $vols = $request->get('vols');
        $place = $request->get('place');
		$date = date('Y-m-d H:i:s');
	    $sql = "INSERT INTO reservation (id_clients, id_vols, date_reservation, place_reservation) VALUES (:client, :vols, :date_reservation, :place_reservation)";
	    try {

	        $db = getConnection();

	        $stmt = $db->prepare($sql);
	        $stmt->bindParam("client", $id);
	        $stmt->bindParam("vols", $vols);
	        $stmt->bindParam("date_reservation", $date);
	        $stmt->bindParam("place_reservation", $place);
	        $stmt->execute();

	        $db = null;

	        echo "Reservation effectuée";

	    } catch(PDOException $e) {

	        echo '{"error":{"text":'. $e->getMessage() .'}}';

	    }
	}	

}

?>