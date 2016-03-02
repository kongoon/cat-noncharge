<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "sim_card".
 *
 * @property integer $id
 * @property string $iccid
 * @property integer $sim_size_id
 *
 * @property BorrowItem[] $borrowItems
 * @property SimSize $simSize
 */
class SimCard extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sim_card';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['iccid', 'sim_size_id'], 'required'],
            [['sim_size_id'], 'integer'],
            [['iccid'], 'string', 'max' => 19]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'iccid' => 'Iccid',
            'sim_size_id' => 'Sim Size ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrowItems()
    {
        return $this->hasMany(BorrowItem::className(), ['sim_card_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSimSize()
    {
        return $this->hasOne(SimSize::className(), ['id' => 'sim_size_id']);
    }
}
