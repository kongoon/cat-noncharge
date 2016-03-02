<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "limited".
 *
 * @property integer $id
 * @property integer $limited
 * @property string $group
 *
 * @property BorrowItem[] $borrowItems
 */
class Limited extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'limited';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['limited', 'group'], 'required'],
            [['limited'], 'integer'],
            [['group'], 'string', 'max' => 100]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'limited' => 'Limited',
            'group' => 'Group',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrowItems()
    {
        return $this->hasMany(BorrowItem::className(), ['limited_id' => 'id']);
    }
}
