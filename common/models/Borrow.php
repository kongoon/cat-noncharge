<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "borrow".
 *
 * @property integer $id
 * @property integer $person_id
 * @property integer $user_id
 * @property string $date_out
 * @property string $start_date
 * @property string $end_date
 * @property string $created_at
 * @property string $updated_at
 *
 * @property Person $person
 * @property User $user
 * @property BorrowItem[] $borrowItems
 */
class Borrow extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'borrow';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['person_id', 'user_id', 'date_out'], 'required'],
            [['person_id', 'user_id'], 'integer'],
            [['date_out', 'start_date', 'end_date', 'created_at', 'updated_at'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'person_id' => 'ผู้ยืม',
            'user_id' => 'ผู้ให้ยืม',
            'date_out' => 'วันที่ยืม',
            'start_date' => 'วันเริ่มต้น',
            'end_date' => 'วันกำหนดส่งคืน',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPerson()
    {
        return $this->hasOne(Person::className(), ['id' => 'person_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrowItems()
    {
        return $this->hasMany(BorrowItem::className(), ['borrow_id' => 'id']);
    }
}
