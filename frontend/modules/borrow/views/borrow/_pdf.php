<?php
use yii\grid\GridView;
?>
<h3>ทดสอบ</h3>


ยืมโดย <?=$model->person->firstname.' '.$model->person->lastname?>
<div class="container-fluid">
<div class="row">
    <div class="col-md-12">
        ผู้ให้ยืม <?=$model->user->authority->employee->person->firstname?> <?=$model->user->authority->employee->person->lastname?>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <h4>รายการหมายเลขที่ยืม</h4>
        <?=GridView::widget([
            'dataProvider' => $dataProvider,
            'summary' => 'จำนวนทั้งหมด {totalCount} หมายเลข',
            'columns' => [
                ['class' => 'yii\grid\SerialColumn','header' => 'ลำดับที่'],
                'numberSim.number.number',
                'numberSim.simCard.iccid',
                'limited.limited',

            ]
        ])?>
    </div>
</div>

<div class="row">
    <div class="col-xs-6 pull-left">
        <div class="text-center">
        ............................<br>
        (<?=$model->user->authority->employee->person->firstname?> <?=$model->user->authority->employee->person->lastname?>)<br/>
        ผู้ให้ยืม
    </div>
    </div>
    <div class="col-xs-6 pull-right">
        <div class="text-center">
        ............................<br>
        (<?=$model->person->firstname.' '.$model->person->lastname?>)<br/>
        ผู้รับ
        </div>
    </div>
</div>
</div>
