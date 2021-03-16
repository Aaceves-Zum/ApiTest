<?php

include_once("class/class.conexion.mysql.php");

    switch ($_SERVER['REQUEST_METHOD']) {
        
        case 'GET':
            $database = new dbmysql();
            $cuentas = ObtenMovimientos($_GET,$database);
            $database->Disconnect();
            exit(json_encode($cuentas));
        break;
    }

    function ObtenMovimientos($Data,$database){
        $where = "";
        if (isset($Data['fechaInicio']) && isset($Data['fechaFin']) ) {
            $where = " WHERE FechaTransaccion BETWEEN '".$Data['fechaInicio']. "´ AND '".$Data['fechaFin']."'";
        }
        if (isset($Data['fechaInicio']) && !isset($Data['fechaFin']) ) {
            $where = " WHERE FechaTransaccion BETWEEN '".$Data['fechaInicio']. "' AND '".date("Y-m-d H:i:s")."'";
        }
        $movimientos = $database->getRows("SELECT mov.*
                            FROM `movimientos` AS mov 
                            INNER JOIN cuentas AS cue ON cue.NumCuenta = mov.NumCuenta ".$where );
        
        $dataRecords = [];
        for ($i=0; $i < count($movimientos); $i++) { 
            
            $dataRecords[$i]= array(
                    "id" => $movimientos[$i]["IdMovimiento"],
                    "tipo" => $movimientos[$i]["Tipo"],
                    "origen" => $movimientos[$i]["Origen"],
                    "fechaTransaccion" => $movimientos[$i]["FechaTransaccion"],
                    "monto" => $movimientos[$i]["Monto"],
                    "descripcion" => $movimientos[$i]["Descripcion"]
            );

        }
        

        $data = array(
            "movimientos" => $dataRecords
        );
        

        return $data;
    }
?>