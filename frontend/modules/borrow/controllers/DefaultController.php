<?php

namespace frontend\modules\borrow\controllers;

use yii\web\Controller;
use yii\data\ActiveDataProvider;
use yii\data\ArrayDataProvider;
use Yii;
use common\models\Borrow;

class DefaultController extends Controller
{
    public function actionIndex()
    {
        //select by sql createCommand
        $sql = "SELECT * FROM borrow b WHERE NOW() > b.end_date";
        $rows = Yii::$app->db->createCommand($sql)->queryAll();
        $dataProvider = new ArrayDataProvider([
            'allModels' => $rows,
        ]);


        $dataProvider2 = new ActiveDataProvider([
            'query' => Borrow::find()->where('NOW() > end_date')->orderBy(['end_date' => SORT_DESC])
        ]);
        return $this->render('index', [
            'dataProvider' => $dataProvider2,
        ]);
    }
}
