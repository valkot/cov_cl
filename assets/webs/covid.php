<?php 

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=0.8">
    </head>
    <body>
    <center>
    <div id="container" style="height:100%; width:100%;"></div>
    </center>

    <script src="https://code.jquery.com/jquery.js"></script>
    <!--<script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
	<script src="http://code.highcharts.com/stock/highstock.js"></script>-->
	<script src="https://code.highcharts.com/highcharts.js"></script>

    <script>
        $(document).ready(function() 
        {
            var options = 
            {
                chart: 
                {
                    type: 'area',
                    zoomType: 'x',
                    renderTo: 'container'
                },
                title: 
                {
                    text: '',
                    style:  {
                                display: 'none'
                            }
                },
                subtitle: 
                {
                    text: '',
                    style:  {
                                display: 'none'
                            }
                },
                xAxis: 
                {
                    //categories: ['03/03/20', '04/03/20', '05/03/20', '06/03/20', '07/03/20', '08/03/20', '09/03/20', '10/03/20', '11/03/20', '12/03/20', '13/03/20', '14/03/20', '15/03/20', '16/03/20', '17/03/20', '18/03/20', '19/03/20', '20/03/20', '21/03/20', '22/03/20'],
                    categories: [0],
                    tickmarkPlacement: 'on',
                    title: {
                        enabled: false
                    }
                },
                yAxis: 
                {
                    title: {
                        text: 'Personas'
                    },
                    labels: {
                        formatter: function () {
                            return this.value;
                        }
                    }
                },
                tooltip: 
                {
                    split: true,
                    valueSuffix: ' personas'
                },
                plotOptions: 
                {
                    area: 
                    {
                        marker: 
                        {
                            enabled: true,
                            radius: 3
                        }
                    },
                    series: 
					{
            			animation: 
						{
                    		duration: 5000
                		}
            		}
                },
                credits:
                {
                    enabled: false
                },
                exporting: 
                {
                    enabled: false
                },
                series: 
                [
                    {
                        data:[]
                    }
                ]
            }
            $.getJSON("http://186.64.121.251/app-urology/grafico/consumo.php", function(json)
            //$.getJSON("querys/XXXXX.php", function(json)
            {
                options.xAxis.categories = json[0]['data'];
                options.series[0] = json[1];
                options.series[0].name='Infectados';
                options.series[0].color = '#FF2828';
                options.series[1] = json[2];
                options.series[1].name='Recuperados';
                options.series[1].color = '#05AD19';
                options.series[2] = json[3];
                options.series[2].name='Activos';
                options.series[2].color = '#FFD128';
                options.series[3] = json[4];
                options.series[3].name='Fallecidos';
                options.series[3].color = '#6b7177';
                chart = new Highcharts.Chart(options);
            });
        });		
    </script>




    
    </body>
</html>
