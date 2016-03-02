<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "sim_size".
 *
 * @property integer $id
 * @property string $sim_size
 *
 * @property SimCard[] $simCards
 */
class SimSize extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sim_size';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['sim_size'], 'required'],
            [['sim_size'], 'string', 'max' => 45]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'sim_size' => 'Sim Size',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSimCards()
    {
        return $this->hasMany(SimCard::className(), ['sim_size_id' => 'id']);
    }
}
