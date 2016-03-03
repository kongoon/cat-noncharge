<?php

namespace common\models;

use Yii;
use yii\behaviors\TimestampBehavior;
use yii\db\Expression;
use common\models\NumberSim;
use common\models\Person;
use common\models\BorrowItem;
use yii\web\UploadedFile;
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
            [['person_id', 'user_id', 'date_out'], 'required'],
            [['person_id', 'user_id'], 'integer'],
            [['date_out', 'start_date', 'end_date', 'created_at', 'updated_at'], 'safe'],
            [['file1', 'file2', 'file3'], 'file', 'extensions' => 'pdf']
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
            'person_receive_id' => 'ผู้รับ',
            'file1' => 'หนังสืออนุญาต',
            'file2' => 'หนังสือยืม',
            'file3' => 'หนังสือคืน',
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
    public function getNumberSim()
    {
        return $this->hasOne(NumberSim::className(), ['id' => 'number_sim_id']);
    }

    public function uploadFirst()
    {
        if($this->validate())
        {
            $filename = md5($this->file1->baseName.time()).'.'.$this->file1->extension;
            $this->file1->saveAs($this->getUploadPath1().$filename);
            return $filename;
        }
    }
    public function uploadSecond()
    {
        if($this->validate())
        {
            $filename = md5($this->file2->baseName.time()).'.'.$this->file2->extension;
            $this->file2->saveAs($this->getUploadPath2().$filename);
            return $filename;
        }
    }
    public function getUploadPath1()
    {
        return Yii::getAlias('@webroot').'/upload/file1/';
    }
    public function getUploadPath2()
    {
        return Yii::getAlias('@webroot').'/upload/file2/';
    }
}
