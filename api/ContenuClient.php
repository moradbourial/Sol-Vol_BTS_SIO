<?php
    ///////////// CLIENT

    // GET clients
    $app->get(
        '/clients',
        function () {
            $clients = new Clients();
            $allClients = $clients->getAllClients();
            return $allClients;

        }
    );

    // GET client
    $app->get(
        '/clients/:id', 
        function($id) use ($app){
        $clients = new Clients();
        $Client = $clients->getClient($id);
        return $Client;
    });



    // PUT Client
    $app->put(
        '/clients/:id', 
        function($id) use ($app){

        $request = $app->request();
        $body = $request->getBody();
        $client = json_decode($body);
        $clients = new Clients();
        $Client = $clients->updateClient($id, $client);
        return $Client;
    });
?>