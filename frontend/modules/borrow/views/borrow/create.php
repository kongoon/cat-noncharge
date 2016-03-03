<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use common\models\Person;
use common\models\Limited;
use common\models\Number;
use yii\helpers\ArrayHelper;
use kartik\select2\Select2;
use kartik\date\DatePicker;

use yii\grid\GridView;


/* @var $this yii\web\View */
/* @var $model common\models\Borrow */

$this->title = 'ยืมเบอร์';
$this->params['breadcrumbs'][] = ['label' => 'Borrows', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<?php $form = ActiveForm::begin(); ?>
<div class="box box-warning box-solid">
    <div class="box-header with-border">
        <h3 class="box-title"><?= Html::encode($this->title) ?></h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">



        <?=
        $form->field($model, 'person_id')->widget(Select2::classname(), [
            'data' => ArrayHelper::map(Person::find()->all(), 'id', function($model) {
                        return $model->firstname . ' ' . $model->lastname;
                    }),
            'options' => ['placeholder' => 'เลือกผู้ยืม ...'],
            'pluginOptions' => [
                'allowClear' => true
            ],
        ])
        ?>

        <?=
        $form->field($model, 'date_out')->widget(DatePicker::className(), [
            'options' => ['placeholder' => 'เลือกวันยืม ...'],
            'value' => date('Y-m-d'),
            'pluginOptions' => [
                'todayHighlight' => true,
                'todayBtn' => true,
                'autoclose' => true,
                'format' => 'yyyy-mm-dd'
            ]
        ])
        ?>

            <?= $form->field($model, 'start_date')->widget(DatePicker::className(), [
            'options' => ['placeholder' => 'เลือกวันเริ่มต้น ...'],
            'value' => date('Y-m-d'),
            'pluginOptions' => [
                'todayHighlight' => true,
                'todayBtn' => true,
                'autoclose' => true,
                'format' => 'yyyy-mm-dd'
            ]
        ]) ?>

    <?= $form->field($model, 'end_date')->widget(DatePicker::className(), [
            'options' => ['placeholder' => 'เลือกวันกำหนดส่งคืน ...'],
            'value' => date('Y-m-d'),
            'pluginOptions' => [
                'todayHighlight' => true,
                'todayBtn' => true,
                'autoclose' => true,
                'format' => 'yyyy-mm-dd'
            ]
        ]) ?>





    </div>
</div>


<div class="box box-warning box-solid">
    <div class="box-header with-border">
        <h3 class="box-title"><?= Html::encode($this->title) ?></h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">

        <?=GridView::widget([
            'dataProvider' => $dataProvider,
            'columns' => [
                ['class' => 'yii\grid\CheckboxColumn',
                    'checkboxOptions' => function ($model, $key, $index, $column) {
                        return ['value' => $model['number_sim_id']];
                    }
                ],

                [
                    'label' => 'หมายเลข',
                    'attribute' => 'number'
                ],
                [
                    'label' => 'ICCID',
                    'attribute' => 'iccid',
                ],
                [
                    'label' => 'Limited',
                    'format' => 'raw',
                    'value' => function($model)
                    {
                        return Html::dropDownList('limited[]',null, ArrayHelper::map(Limited::find()->all(), 'id',function($m){return $m->group.'-'.$m->limited;}));
                    }
                ],
                [
                    'label' => 'Borrow Type',
                    'format' => 'raw',
                    'value' => function($model){
                        return Html::dropDownList('borrow_type[]',null,['0' => 'ประจำ', '1' => 'ชั่วคราว']);
                    }
                ]
            ]
            ])?>
    </div>
</div>

<div class="form-group">
<?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
</div>

<?php ActiveForm::end(); ?>
