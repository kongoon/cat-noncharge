<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "borrow_item".
 *
 * @property integer $id
 * @property integer $borrow_id
 * @property integer $sim_card_id
 * @property integer $number_id
 * @property string $date_return
 * @property integer $user_id
 * @property integer $person_id
 * @property integer $limited_id
 * @property string $borrow_type
 * @property string $created_at
 * @property string $updated_at
 *
 * @property Borrow $borrow
 * @property Limited $limited
 * @property Number $number
 * @property Person $person
 * @property SimCard $simCard
 * @property User $user
 */
class BorrowItem extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'borrow_item';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['borrow_id', 'sim_card_id', 'number_id', 'limited_id', 'borrow_type'], 'required'],
            [['borrow_id', 'sim_card_id', 'number_id', 'user_id', 'person_id', 'limited_id'], 'integer'],
            [['date_return', 'created_at', 'updated_at'], 'safe'],
            [['borrow_type'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'borrow_id' => 'การยืม',
            'sim_card_id' => 'Sim Card',
            'number_id' => 'หมายเลข',
            'date_return' => 'วันที่คืน',
            'user_id' => 'ผู้รับคืน',
            'person_id' => 'ผู้คืน',
            'limited_id' => 'วงเงิน',
            'borrow_type' => 'การใช้งาน',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBorrow()
    {
        return $this->hasOne(Borrow::className(), ['id' => 'borrow_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getLimited()
    {
        return $this->hasOne(Limited::className(), ['id' => 'limited_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getNumber()
    {
        return $this->hasOne(Number::className(), ['id' => 'number_id']);
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
    public function getSimCard()
    {
        return $this->hasOne(SimCard::className(), ['id' => 'sim_card_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
}
