<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Borrow */

$this->title = 'Update Borrow: ' . ' ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Borrows', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="borrow-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
