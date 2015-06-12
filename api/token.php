<?php
	class Token
	{
		function getToken($id, $mail, $password)
		{
			$token_key = md5(uniqid(rand(), true));
			$token = "UPDATE clients SET token_clients =:token WHERE id_clients =:id AND mail_clients=:user AND password_clients=:password";
			$sql = "SELECT token_clients FROM clients WHERE id_clients =:id AND mail_clients=:user AND password_clients=:password";
			try {

		        $db = getConnection();

		        $stmt = $db->prepare($token);
		        $stmt->bindParam("id", $id);
		        $stmt->bindParam("token", $token_key);
		        $stmt->bindParam("user", $mail);
		        $stmt->bindParam("password", $password);
		        $stmt->execute();

		        $stmt = $db->prepare($sql);
		        $stmt->bindParam("id", $id);
		        $stmt->bindParam("user", $mail);
		        $stmt->bindParam("password", $password);
		        $stmt->execute();
		        $token_client = $stmt->fetch(PDO::FETCH_ASSOC);


		        $db = null;

		        if (empty($token_client)) {
					error_log("User $username: Echec");
					echo '{"success":0,"error_message":"Invalid token"}';
				} else {
					return $token_client;
				}

		    } catch(PDOException $e) {

		        echo '{"error":{"text":'. $e->getMessage() .'}}';

		    }
		}

		function authentification($id, $user, $password){
			$time = time();
			$sql = "SELECT token_time FROM clients where mail_clients=:user AND password_clients=:password AND id_clients=:id";
		    try {

		        $db = getConnection();

		        $stmt = $db->prepare($sql);
		        $stmt->bindParam("id", $id);
		        $stmt->bindParam("user", $mail);
		        $stmt->bindParam("password", $password);
		        $stmt->execute();
		        $user = $stmt->fetch();
		        $token_time = $user['token_time'];

		        $db = null;

		    } catch(PDOException $e) {

		        echo '{"error":{"text":'. $e->getMessage() .'}}';

		    }
			if($time >= $token_time)
			{
				getToken($id, $user, $password);
			}
		}
		
	}
?>