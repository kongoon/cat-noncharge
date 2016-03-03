<?php

namespace common\models;

use Yii;
use common\models\Number;

/**
 * This is the model class for table "number_sim".
 *
 * @property integer $id
 * @property integer $number_id
 * @property integer $sim_card_id
 *
 * @property BorrowItem[] $borrowItems
 * @property SimCard $simCard
 * @property Number $number
 */
class NumberSim extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'number_sim';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['number_id', 'sim_card_id'], 'required'],
            [['number_id', 'sim_card_id'], 'integer']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'number_id' => 'Number ID',
            'sim_card_id' => 'Sim Card ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrowItems()
    {
        return $this->hasMany(BorrowItem::className(), ['number_sim_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSimCard()
    {
        return $this->hasOne(SimCard::className(), ['id' => 'sim_card_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getNumber()
    {
        return $this->hasOne(Number::className(), ['id' => 'number_id']);
    }
}
