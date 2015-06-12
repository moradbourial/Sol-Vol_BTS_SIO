<?php
class Clients
{

	function getAllClients(){
		$sql = "SELECT * FROM clients";
	    try {
	        $db = getConnection();
	        $stmt = $db->query($sql);
	        $clients = $stmt->fetchAll(PDO::FETCH_OBJ);
	        $db = null;
		    echo '{"clients": ' . json_encode($clients) . '}';
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	}

	function getClient($id){
		$sql = "SELECT * FROM clients WHERE id_clients=:id_clients";
	    try {
	        $db = getConnection();
	        $stmt = $db->prepare($sql);
	        $stmt->bindParam(":id_clients", $id);       
	        $stmt->execute();
	        $clients = $stmt->fetchObject();
	        $db = null;
	        echo json_encode($clients);
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	}


	function updateClient($id, $client){
    $sql = "UPDATE clients SET nom_clients=:nom, prenom_clients=:prenom, adresse_clients=:adresse, cp_clients=:cp, ville_clients=:ville, tel_clients=:tel, mail_clients=:mail, password_clients=:password WHERE id_clients=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("nom", $client->nom_clients);
        $stmt->bindParam("prenom", $client->prenom_clients);
        $stmt->bindParam("adresse", $client->adresse_clients);
        $stmt->bindParam("cp", $client->cp_clients);
        $stmt->bindParam("ville", $client->ville_clients);
        $stmt->bindParam("tel", $client->tel_clients);
        $stmt->bindParam("mail", $client->mail_clients);
        $stmt->bindParam("password", $client->password_clients);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $db = null;
        echo json_encode($client);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

}

?>