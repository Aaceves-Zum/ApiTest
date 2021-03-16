<?php

include_once("class/class.conexion.mysql.php");

    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $database = new dbmysql();
            $cuentas = ObtenCuentas($_POST,$database);
            $database->Disconnect();
            exit(json_encode($cuentas));
        break;
        
    }

    function ObtenCuentas($Data,$database){
        $where = "";
        if (isset($Data['IdSocio'])) {
            $where = " WHERE cuen.IdSocio = ".$Data['IdSocio'];
        }
        $cuentas = $database->getRows("SELECT cuen.*,tic.Descripcion AS TipoCuenta, subt.Descripcion AS Subtipo,soc.Nombre,soc.ApellidoPaterno,soc.ApellidoMaterno
                                        FROM `cuentas` AS cuen
                                        INNER JOIN tipocuenta AS tic ON tic.IdTipoCuenta = cuen.TipoCuenta
                                        INNER JOIN SubtipoCuenta AS subt ON subt.IdSubtipoCuenta = cuen.SubtipoCuenta
                                        INNER JOIN socios AS soc ON soc.IdSocio = cuen.IdSocio ".$where );
        
        $dataRecords = [];
        for ($i=0; $i < count($cuentas); $i++) { 
            $fechaTrans = $database->getRows("SELECT FechaTransaccion FROM movimientos WHERE NumCuenta = ".$cuentas[$i]["NumCuenta"]." ORDER BY FechaTransaccion DESC LIMIT 1");

            $dataRecords[$i]= array(
                    "numeroCuenta" => $cuentas[$i]["NumCuenta"],
                    "tipoCuenta" => $cuentas[$i]["TipoCuenta"],
                    "subtipoCuenta" => $cuentas[$i]["SubtipoCuenta"],
                    "nombreSocioPertenece" => $cuentas[$i]["Nombre"].' '.$cuentas[$i]["ApellidoPaterno"].' '. $cuentas[$i]["ApellidoMaterno"],
                    "numeroSocioPertenece" => $cuentas[$i]["IdSocio"],
                    "saldo" => $cuentas[$i]["Saldo"],
                    "fechaUltimoMovimiento" => $fechaTrans
            );

            if (isset($Data['registro'])) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "registro" => [
                        "fechaRegistro" => $cuentas[$i]["FechaRegistro"],
                        "saldoInicial" => $cuentas[$i]["SaldoInicial"]
                    ]
                ));
            }
            if (isset($Data['credito'])) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "datosCredito" => [
                        "proximoPago" => [
                            "monto" => $cuentas[$i]["ProximoPago"],
                            "moneda" => $cuentas[$i]["Moneda"],
                            "fecha" => $cuentas[$i]["Fecha"]
                        ]
                    ]
                ));
            }

        }
        

        $data = array(
            "cuentas" => $dataRecords
        );
        

        return $data;
    }
?>