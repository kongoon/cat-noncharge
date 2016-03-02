<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "person".
 *
 * @property integer $id
 * @property string $firstname
 * @property string $lastname
 * @property string $citizen_id
 * @property string $address
 * @property string $tel
 *
 * @property Borrow[] $borrows
 * @property BorrowItem[] $borrowItems
 * @property Employee[] $employees
 */
class Person extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'person';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['firstname', 'lastname', 'citizen_id', 'address', 'tel'], 'required'],
            [['address'], 'string'],
            [['firstname', 'lastname'], 'string', 'max' => 100],
            [['citizen_id'], 'string', 'max' => 13],
            [['tel'], 'string', 'max' => 45]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'firstname' => 'ชื่อ',
            'lastname' => 'นามสกุล',
            'citizen_id' => 'หมายเลขบัตรประชาชน',
            'address' => 'ที่อยู่',
            'tel' => 'โทรศัพท์',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrows()
    {
        return $this->hasMany(Borrow::className(), ['person_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrowItems()
    {
        return $this->hasMany(BorrowItem::className(), ['person_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEmployees()
    {
        return $this->hasMany(Employee::className(), ['person_id' => 'id']);
    }
}
