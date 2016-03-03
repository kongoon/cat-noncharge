<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
use yii\widgets\ActiveForm;
use wahyugnc\pdfjs\ViewerPDF;

$this->registerJsFile('http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js', ['position' => \yii\web\View::POS_HEAD]);

/* @var $this yii\web\View */
/* @var $model common\models\Borrow */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Borrows', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="box box-success box-solid">
    <div class="box-header with-border">
        <h3 class="box-title"><?= Html::encode($this->title) ?></h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            //'id',
            [
                'attribute' => 'person_id',
                'format' => 'raw',
                'value' => $model->person->firstname.' '.$model->person->lastname
            ],
            [
                'attribute' => 'user_id',
                'format' => 'raw',
                'value' => $model->user->authority->employee->person->firstname.' '.$model->user->authority->employee->person->lastname
            ],
            'date_out',
            'start_date',
            'end_date',
            'created_at',
            'updated_at',
        ],
    ]) ?>

</div>
</div>

<div class="box box-danger box-solid">
    <div class="box-header with-border">
        <h3 class="box-title">Upload Document</h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <?php $form = ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data']])?>
        <?=$form->field($model, 'file1')->fileInput()?>
        <?=$form->field($model, 'file2')->fileInput()?>
        <?=Html::submitButton('Upload File', ['class' => 'btn btn-success'])?>
        <?php ActiveForm::end()?>
    </div>

</div>
<?php if(!empty($model->file1)){?>
    <div class="box box-warning box-solid">
        <div class="box-header with-border">
            <h3 class="box-title">หนังสืออนุญาต</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <?php //$model->file1?>
            <?php //ViewerPDF::widget(['url' => Yii::getAlias('@web').'/upload/file1/'.$model->file1]);?>
            <iframe width="100%" height="300" src="<?=Yii::getAlias('@web').'/upload/file1/'.$model->file1?>" frameborder="0"></iframe>
        </div>

    </div>
<?php }?>

<?php if(!empty($model->file2)){?>
    <div class="box box-warning box-solid">
        <div class="box-header with-border">
            <h3 class="box-title">หนังสือยืม</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <?php //$model->file1?>
            <?php //ViewerPDF::widget(['url' => Yii::getAlias('@web').'/upload/file1/'.$model->file1]);?>
            <iframe width="100%" height="300" src="<?=Yii::getAlias('@web').'/upload/file2/'.$model->file2?>" frameborder="0"></iframe>
        </div>

    </div>
<?php }?>

<?php if(!empty($model->file3)){?>
    <div class="box box-warning box-solid">
        <div class="box-header with-border">
            <h3 class="box-title">หนังสือคืน</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <?php //$model->file1?>
            <?php //ViewerPDF::widget(['url' => Yii::getAlias('@web').'/upload/file1/'.$model->file1]);?>
            <iframe width="100%" src="<?=Yii::getAlias('@web').'/upload/file3/'.$model->file3?>" frameborder="0"></iframe>
        </div>

    </div>
<?php }?>
