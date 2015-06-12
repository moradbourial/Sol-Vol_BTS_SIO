<?php
class Destinations
{

	function getAllDestinations(){
		$sql = "SELECT * FROM destinations";
	    try {
	        $db = getConnection();
	        $stmt = $db->query($sql);
	        $destinations = $stmt->fetchAll(PDO::FETCH_OBJ);
	        $db = null;
		    echo '{"destinations": ' . json_encode($destinations) . '}';
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	}
}
?>