<?php

namespace common\models;

use Yii;
use common\models\Person;

/**
 * This is the model class for table "employee".
 *
 * @property integer $id
 * @property string $emp_id
 * @property integer $section_id
 * @property integer $person_id
 *
 * @property Authority[] $authorities
 * @property Person $person
 * @property Section $section
 */
class Employee extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'employee';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['emp_id', 'section_id', 'person_id'], 'required'],
            [['section_id', 'person_id'], 'integer'],
            [['emp_id'], 'string', 'max' => 8]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'emp_id' => 'รหัสพนักงาน',
            'section_id' => 'ส่วน',
            'person_id' => 'ข้อมูล',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAuthorities()
    {
        return $this->hasMany(Authority::className(), ['employee_id' => 'id']);
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
    public function getSection()
    {
        return $this->hasOne(Section::className(), ['id' => 'section_id']);
    }
}
