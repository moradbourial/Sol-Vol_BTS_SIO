<?php
class Utilisateur
{

	function getConection($user, $app)
		{
			$request = $app->request();
			$mail = $request->get('mail');
	        $password = $request->get('password');
		    $sql = "SELECT * FROM clients where mail_clients=:user AND password_clients=:password";
		    try {

		        $db = getConnection();

		        $stmt = $db->prepare($sql);
		        $stmt->bindParam("user", $mail);
		        $stmt->bindParam("password", $password);
		        $stmt->execute();
		        $user = $stmt->fetch(PDO::FETCH_ASSOC);
		        $id = $user['id_clients'];

		        $db = null;
		        if (empty($user)) {

					error_log("User $username: Echec");
					echo '{"success":0,"error_message":"Invalid Nom Utilisateur/Mot de Passe"}';
				
				} else {
					// Take token

					$Tokenn = new Token();
	        		$token = $Tokenn->getToken($id, $mail, $password);
	        		$array = array(
	        			'token' => $token['token_clients'],
	        			'id' => $user['id_clients'],
	        			'mail' => $user['mail_clients'],
	        			'password' => $user['password_clients']
	        			);
					echo json_encode($array);
					


					
				}

		    } catch(PDOException $e) {

		        echo '{"error":{"text":'. $e->getMessage() .'}}';

		    }
		}

		function addUser($user, $newUser)
		{
			$sql = "INSERT INTO clients (nom_clients, prenom_clients, adresse_clients, cp_clients, ville_clients, tel_clients, mail_clients, password_clients) 
			VALUES (:nom, :prenom, :adresse, :cp, :ville, :tel, :mail, :password)";
		    try {

		        $db = getConnection();

		        $stmt = $db->prepare($sql);
		        $stmt->bindParam("nom", $newUser->nom);
		        $stmt->bindParam("prenom", $newUser->prenom);
		        $stmt->bindParam("adresse", $newUser->adresse);
		        $stmt->bindParam("cp", $newUser->cp);
		        $stmt->bindParam("ville", $newUser->ville);
		        $stmt->bindParam("tel", $newUser->tel);
		        $stmt->bindParam("mail", $newUser->mail);
		        $stmt->bindParam("password", $newUser->password);
		        $stmt->execute();

		        $db = null;

		        echo "Utilisateur ajouter";

		    } catch(PDOException $e) {

		        echo '{"error":{"text":'. $e->getMessage() .'}}';

		    }
		}
}
?>