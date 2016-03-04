<?php
/* @var $this yii\web\View */
?>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
    google.load("visualization", "1", {packages: ["geochart"]});
    google.setOnLoadCallback(drawRegionsMap);

    function drawRegionsMap() {

        var data = google.visualization.arrayToDataTable([
            ['จังหวัด', 'จำนวนอุบัติเหตุ'],
<?=$data; ?>
        ]);

        var options = {
            region: 'TH',
            resolution: 'provinces',
            //displayMode: 'markers',
            colorAxis: {colors: ['green', 'yellow', 'orange', 'red']}
        };

        var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));

        chart.draw(data, options);
    }
</script>

<div class="panel panel-danger">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-signal"></i> การเกิดอุบัติเหตุในเทศกาลสงกรานต์ปี 2557</h3>
    </div>
    <div class="panel-body">

        <div id="regions_div" style="width: 100%; height: 500px;"></div>
    </div>
</div>
