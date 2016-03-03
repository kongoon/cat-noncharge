<?php

namespace common\models;

use Yii;
use yii\behaviors\TimestampBehavior;
use yii\db\Expression;

/**
 * This is the model class for table "borrow_item".
 *
 * @property integer $id
 * @property integer $borrow_id
 * @property integer $number_sim_id
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
 * @property Person $person
 * @property User $user
 * @property NumberSim $numberSim
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

    public function behaviors()
    {
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
            ]
        ];
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['borrow_id', 'number_sim_id', 'limited_id', 'borrow_type'], 'required'],
            [['borrow_id', 'number_sim_id', 'user_id', 'person_id', 'limited_id'], 'integer'],
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
            'number_sim_id' => 'Number Sim ID',
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
    public function getNumberSim()
    {
        return $this->hasOne(NumberSim::className(), ['id' => 'number_sim_id']);
    }
}
