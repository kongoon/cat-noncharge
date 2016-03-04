<?php
use yii\grid\GridView;
use yii\helpers\Html;

?>
<div class="jumbotron">
    <p class="lead">NonCharge</p>

    <p>
        <?php echo Html::a('<i class="fa fa-info-circle fa-2"></i><br/>ยืม', ['/borrow/borrow/create'], ['class' => 'btn btn-lg btn-info', 'data-toggle' => 'tooltip', 'data-placement' => 'right', 'title' => 'ยืม']); ?>
    </p>






</div>


<div class="box box-warning box-solid">
    <div class="box-header with-border">
        <h3 class="box-title">Report2</h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <div class="table-responsive">
            <?=GridView::widget([
                'dataProvider' => $dataProvider,
                'columns' => [
                    [
                        'attribute' => 'person_id',
                        'value' => function($model){
                            return $model->person->firstname.' '.$model->person->lastname;
                        }
                    ],
                    'start_date:date',
                    'end_date:date',
                    'person.tel',
                    [
                        'label' => 'หมายเหตุ (วัน)',
                        'format' => 'raw',
                        'value' => function($model){
                            $datetime1 = new DateTime(date('Y-m-d',strtotime($model->end_date)));
                            $datetime2 = new DateTime("now");
                            $interval = $datetime1->diff($datetime2);

                            return $interval->format('%d');
                        }
                    ],
                    [
                        'class' => 'yii\grid\ActionColumn',
                        'template' => '{view}',
                        'buttons' => [
                            'view' => function ($url, $model, $key) {
                                return Html::a('View', ['/borrow/borrow/view', 'id' => $model->id], ['class' => 'btn btn-xs btn-info']);
                            },
                        ]
                    ],


                ]
            ])?>
        </div>
    </div>
</div>
