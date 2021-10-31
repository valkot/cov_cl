<?php 
//$reciboRegion = $_GET['region'];

date_default_timezone_set('America/Santiago');
require("../simplehtmldom/simple_html_dom.php");
$url="https://github.com/MinCiencia/Datos-COVID19/blob/master/output/producto5/TotalesNacionales.csv";
$html=file_get_contents($url); 

$dom = new domDocument;
//cargo el html dentro del dom
$dom->loadHTML($html);

$dom->preserveWhiteSpace = false;

$tables = $dom->getElementsByTagName('table'); 


$rows = $tables->item(0)->getElementsByTagName('tr');
$rows2 = $tables->item(0)->getElementsByTagName('tr');
$rows3 = $tables->item(0)->getElementsByTagName('tr');

$getFecha = array();
$algo = array();


$infectados = array();
$infectados['name'][] = 'Infectados';
$recuperados = array();
$recuperados['name'][] = 'Recuperados';
$fallecidos = array();
$fallecidos['name'][] = 'Fallecidos';
$activos = array();
$activos['name'][] = 'Activos';
$fecha = array();
$fecha['name'][] = 'Fecha';


$j = 0;
$longitud = 0;
$arreglo = array();
$fechaActualizacion = array();
$corregirFecha = '';
foreach ($rows2 as $row2)
{
    $cabecera = count($row2->getElementsByTagName('th'));
    $arreglo[] = $cabecera; 
}


$indice = $arreglo[0];
$bFecha = $indice-1;



//Obtengo la Fecha
foreach ($rows3 as $row3)
{
    $fa = $row3->getElementsByTagName('th');
    if($fa->item(0)->nodeValue == 'Fecha')
    { 
        for($i=1; $i<$indice; $i++)
        {
        $laFecha = $fa->item($i)->nodeValue;
        $anio = substr($laFecha,2,2);
        $mes = substr($laFecha,5,2);
        $dia = substr($laFecha,8,2);
        $miFecha= $dia.'-'.$mes.'-'.$anio;
        $fecha['data'][] = $miFecha;
        }
    }
    
}


//Obtengo los datos
foreach ($rows as $row) 
{ 
    $cols = $row->getElementsByTagName('td'); 
    if($cols->item(1)->nodeValue == 'Casos totales')
    {    
        for($i=2; $i<=$indice; $i++)
        {
            //$infectados[] = intval($cols->item($i)->nodeValue); 
            $infectados['data'][] = intval($cols->item($i)->nodeValue);
        }
    }
    if($cols->item(1)->nodeValue == 'Casos recuperados')
    {    
        for($i=2; $i<=$indice; $i++)
        {
            //$recuperados[] = intval($cols->item($i)->nodeValue); 
            $recuperados['data'][] = intval($cols->item($i)->nodeValue);
        }
    }
    if($cols->item(1)->nodeValue == 'Fallecidos')
    {    
        for($i=2; $i<=$indice; $i++)
        {
            //$fallecidos[] = intval($cols->item($i)->nodeValue); 
            $fallecidos['data'][] = intval($cols->item($i)->nodeValue); 
        }
    } 
    if($cols->item(1)->nodeValue == 'Casos activos')
    {    
        for($i=2; $i<=$indice; $i++)
        {
            //$activos[] = intval($cols->item($i)->nodeValue); 
            $activos['data'][] = intval($cols->item($i)->nodeValue);
        }
    } 
} 

$result = array();

array_push($result,$fecha);
array_push($result,$infectados);
array_push($result,$recuperados);
array_push($result,$activos);
array_push($result,$fallecidos);
print json_encode($result, JSON_NUMERIC_CHECK);
/*
$largo = count($activos);

for($i=0; $i<$largo; $i++)
{
    $data[] = ['fechas'=> "$fecha[$i]", 'infectados'=> "$infectados[$i]", 'recuperados'=> "$recuperados[$i]", 'fallecidos'=> "$fallecidos[$i]", 'activos'=> "$activos[$i]"];
}
    
echo json_encode($data, JSON_UNESCAPED_UNICODE);  
*/
?>