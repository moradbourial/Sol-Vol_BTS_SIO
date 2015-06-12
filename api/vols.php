<?php


class Vols
{
	function getAllVols($date)
	{
		$dateVol = $date;
		$sql = "SELECT * FROM vols WHERE depart_vols LIKE :date_vols";
	    try {
	        $db = getConnection();
	        
	        $stmt = $db->prepare($sql);
		    $stmt->execute(array(":date_vols" => "%".$dateVol. "%"));
	        $vols = $stmt->fetchAll(PDO::FETCH_OBJ);

	        $db = null;

		    echo json_encode($vols);

	    } catch(PDOException $e) {

	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	}

	function getVol($destination, $app)
	{
        $i = 0;
        $TabVol = array();
		$request = $app->request();
        $date = $request->get('date');
        $date = $date."%";
        $depart = $request->get('depart');
        $arriver = $request->get('arriver');
        $typeClass = $request->get('type');
        $sql = "SELECT * FROM vols WHERE depart_vols LIKE :date_vols AND id_aero_depart=:depart AND id_aero_arriver=:destination";
        $airport ="SELECT id_aero FROM aeroports WHERE ville_aero =:airport";



        try {

                $db = getConnection();
                

                /// ID DEPART
                $stmt = $db->prepare($airport);
                $stmt->bindParam("airport", $depart);
                $stmt->execute();
                $depart = $stmt->fetch();
                $dep = $depart['id_aero'];

                // ID ARRIVER
                $stmt = $db->prepare($airport);
                $stmt->bindParam("airport", $arriver);
                $stmt->execute();
                $arriver = $stmt->fetch();
                $dest = $arriver['id_aero'];



                // SEARCH
                $stmt = $db->prepare($sql);
                $stmt->bindParam("depart", $dep);
                $stmt->bindParam("destination", $dest);
                $stmt->bindParam("date_vols", $date);
                $stmt->execute();
                $Vols = $stmt->fetchObject();
                $db = null;

                echo json_encode($Vols);



        } catch(PDOException $e) {
                echo '{"error":{"text":'. $e->getMessage() .'}}';
    	}
	}
}

?>