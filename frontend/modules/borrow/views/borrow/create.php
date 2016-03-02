<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Borrow */

$this->title = 'Create Borrow';
$this->params['breadcrumbs'][] = ['label' => 'Borrows', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="borrow-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
