<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "number".
 *
 * @property integer $id
 * @property integer $zone_id
 * @property string $number
 * @property string $owner
 * @property string $status
 *
 * @property BorrowItem[] $borrowItems
 * @property Zone $zone
 */
class Number extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'number';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['zone_id', 'number', 'owner', 'status'], 'required'],
            [['zone_id'], 'integer'],
            [['owner', 'status'], 'string'],
            [['number'], 'string', 'max' => 45]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'zone_id' => 'ภาค',
            'number' => 'เบอร์โทร',
            'owner' => 'ความเป็นเจ้าของ',
            'status' => 'Status',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrowItems()
    {
        return $this->hasMany(BorrowItem::className(), ['number_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getZone()
    {
        return $this->hasOne(Zone::className(), ['id' => 'zone_id']);
    }
}
