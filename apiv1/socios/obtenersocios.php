<?php

include_once("class/class.conexion.mysql.php");

    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $database = new dbmysql();
            $socios = ObtenSocios($_POST,$database);
            $database->Disconnect();
            exit(json_encode($socios));
        break;
    }

    function ObtenSocios($Data,$database){
        $sociosC = $database->getRows("SELECT socio.*,tiso.Descripcion AS TipoSocio
                                        FROM `socios` AS socio
                                        INNER JOIN tiposocio AS tiso ON tiso.IdTipoSocio = socio.Tipo");
        
        $dataRecords = [];
        for ($i=0; $i < 3; $i++) { 
                # code...
            
            if ($sociosC[$i]["TipoMovil"] == 1) {$Movil = "Movil"; } else $Movil = "Fijo";
            $dataRecords[$i]= array(
                    "id" => $sociosC[$i]["IdSocio"],
                    "nombre" => $sociosC[$i]["Nombre"],
                    "apellidoPaterno" => $sociosC[$i]["ApellidoPaterno"],
                    "apellidoMaterno" => $sociosC[$i]["ApellidoMaterno"],
                    "tipo" => $sociosC[$i]["TipoSocio"],
                    "estatus" => $sociosC[$i]["Estatus"],
                    "numeroSucursal" => $sociosC[$i]["NumeroSucursal"]
            );

            if (isset($Data['contacto']) ) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "contacto" => [
                        "correoElectronico" => $sociosC[$i]["CorreoElec"],
                        "telefonos" => [
                            "tipo" => $Movil,
                            "numero" => $sociosC[$i]["Numero"]
                        ]
                    ]
                ));

            }
            if (isset($Data['personales'])) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "personales" => [
                        "curp" => $sociosC[$i]["Curp"],
                        "genero" => $sociosC[$i]["Genero"],
                        "fechaNacimiento" => $sociosC[$i]["FechaNacimiento"]
                    ]
                ));
            }
            if (isset($Data['datosFiscales'])) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "datosFiscales" => [
                        "rfc" => $sociosC[$i]["Rfc"]
                    ]
                ));
            }
            if (isset($Data['domicilio'])) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "domicilio" => [
                        "calle" => $sociosC[$i]["Calle"],
                        "numeroExterior" => $sociosC[$i]["NumeroExter"],
                        "colonia" => $sociosC[$i]["Colonia"],
                        "ciudad" => $sociosC[$i]["Ciudad"],
                        "codigoPostal" => $sociosC[$i]["CodigoPostal"],
                        "codigoEstado" => $sociosC[$i]["CodigoEstado"],
                        "estado" => $sociosC[$i]["Calle"],
                        "pais" => $sociosC[$i]["Pais"]
                    ]
                ));
            }
            if (isset($Data['empleo'])) {
                $dataRecords[$i]= array_merge($dataRecords[$i],array(
                    "empleo" => [
                        "ocupacion" => $sociosC[$i]["Ocupacion"]
                    ]
                ));
            }
        }
        

        $data = array(
            "socios" => $dataRecords
        );
        

        return $data;
    }
?>