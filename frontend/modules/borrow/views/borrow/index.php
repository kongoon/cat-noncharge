<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel frontend\modules\borrow\models\BorrowSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'รายการยืม';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="box box-warning box-solid">
    <div class="box-header with-border">
        <h3 class="box-title"><?= Html::encode($this->title) ?></h3>

        <div class="box-tools pull-right">
            <?= Html::a('Create Borrow', ['create'], ['class' => 'btn btn-success']) ?>
        </div>
        <!-- /.box-tools -->
    </div>
    <!-- /.box-header -->
    <div class="box-body">

        <?php // echo $this->render('_search', ['model' => $searchModel]); ?>



        <?=
        GridView::widget([
            'dataProvider' => $dataProvider,
            'filterModel' => $searchModel,
            'columns' => [
                ['class' => 'yii\grid\SerialColumn'],
                //'id',
                [
                    'attribute' => 'person_id',
                    'value' => function($model)
                    {
                        return $model->person->firstname.' '.$model->person->lastname;
                    }
                ],
                'date_out:date',
                'start_date:date',
                'end_date:date',
                // 'created_at',
                // 'updated_at',
                ['class' => 'yii\grid\ActionColumn'],
            ],
        ]);
        ?>

    </div>
    <!-- /.box-body -->
</div>
<!-- /.box -->
