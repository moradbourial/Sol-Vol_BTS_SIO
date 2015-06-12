<?php


class Aeroports
{

	function getAllAeroports(){
		$sql = "SELECT * FROM aeroports";
	    try {
	        $db = getConnection();
	        $stmt = $db->query($sql);
	        $aeroports = $stmt->fetchAll(PDO::FETCH_OBJ);
	        $db = null;
		    echo '{"aeroports": ' . json_encode($aeroports) . '}';
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	}
}
?>