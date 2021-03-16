<?php
/*
 
 *
 */
ini_set('memory_limit', '-1');

class dbmysql{
    public $isConnected;
    private $datab;
    private $bd = "alianza";
    private $host = "localhost";
    private $user = "root";
    private $pass = "";
    private $options = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',PDO::MYSQL_ATTR_LOCAL_INFILE => true);
    public function __construct(){
        $this->isConnected = true;
        try {
            $this->datab = new PDO("mysql:host=".$this->host.";dbname=".$this->bd.";charset=utf8", $this->user , $this->pass, $this->options);
            $this->datab->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->datab->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        }
        catch(PDOException $e) {
            $this->isConnected = false;
            throw new Exception($e->getMessage());
            echo $e;
        }
    }
  
    public function beginTransactionDB(){
     return  $this->datab->beginTransaction();
    }
  
    public function commitDB(){
      return $this->datab->commit();
    }
  
  
    public function rollBackDB(){
      return $this->datab->rollback();
    }
  
    public function Disconnect(){
        $this->datab = null;
        $this->isConnected = false;
    }
    public function getRow($query, $params=array()){
        try{
            $stmt = $this->datab->prepare($query);
            $stmt->execute($params);
            return $stmt->fetch();
        }catch(PDOException $e){
            throw new Exception($e->getMessage());
            return false;
        }
    }
    public function getRows($query, $params=array()){
        try{
            $stmt = $this->datab->prepare($query);
            $stmt->execute($params);
            return $stmt->fetchAll();
        }catch(PDOException $e){
            throw new Exception($e->getMessage());
            return false;
        }
    }
    public function query($query){
        $this->datab->exec($query);
    }
  
  }
?>