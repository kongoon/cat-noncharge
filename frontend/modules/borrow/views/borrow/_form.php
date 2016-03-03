<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use common\models\Person;
use yii\helpers\ArrayHelper;
use kartik\select2\Select2;
use kartik\date\DatePicker;

/* @var $this yii\web\View */
/* @var $model common\models\Borrow */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="borrow-form">

    <?php $form = ActiveForm::begin(); ?>

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

    <div class="form-group">
<?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

<?php ActiveForm::end(); ?>

</div>
