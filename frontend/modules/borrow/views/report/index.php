<?php
use miloschuman\highcharts\Highcharts;
?>
<div class="box box-warning box-solid">
    <div class="box-header with-border">
        <h3 class="box-title">Report1</h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <?=Highcharts::widget([
            'id' => 'chart1',
            'scripts' => [
                'highcharts-more',
                'highcharts-3d',
                'modules/drilldown',
            ],
            'options' => [
                'credits' => ['enabled' => false],
                'type' => 'column',
                
                
            ]
         ])?>
        <div id="chart1"></div>
    </div>
</div>

<?php $this->registerJs("$(function () {
    // Create the chart
    $('#chart1').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'กราฟสรุปหมายเลขที่มีการยืม'
        },
        subtitle: {
            text: 'กราฟแสดงข้อมูลสรุปหมายเลขที่มีการยืม'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: 'จำนวนครั้ง'
            }

        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    format: '{point.y} ครั้ง'
                }
            }
        },

        tooltip: {
            headerFormat: '<span style=\"font-size:11px\">{series.name}</span><br>',
            pointFormat: '<span style=\"color:{point.color}\">{point.name}</span>: <b>{point.y} ครั้ง</b> <br/>'
        },

        series: [{
            name: 'หมายเลข',
            colorByPoint: true,
            data: ".json_encode($graph)." 
        }],
        drilldown: {
            series: ".json_encode($drilldown)." 
        }
    });
});");
