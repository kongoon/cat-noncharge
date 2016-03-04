<?php
namespace frontend\modules\borrow\components;
use Yii;
use yii\data\ActiveDataProvider;
use common\models\Borrow as BR;

class Borrow
{
    public function countOver()
    {
        $sql = "SELECT COUNT(b.id) as cno FROM borrow b WHERE NOW() > b.end_date";
        $row = Yii::$app->db->createCommand($sql)->queryOne();

        return $row['cno'];
    }

    public function listOver()
    {
        return BR::find()->where('NOW() > end_date')->orderBy(['end_date' => SORT_DESC])->all();
    }
}
