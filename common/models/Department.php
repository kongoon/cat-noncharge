<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "department".
 *
 * @property integer $id
 * @property integer $line_company_id
 * @property string $name
 *
 * @property LineCompany $lineCompany
 * @property Section[] $sections
 */
class Department extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'department';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['line_company_id', 'name'], 'required'],
            [['line_company_id'], 'integer'],
            [['name'], 'string', 'max' => 100]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'line_company_id' => 'สายงาน',
            'name' => 'ฝ่าย',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getLineCompany()
    {
        return $this->hasOne(LineCompany::className(), ['id' => 'line_company_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSections()
    {
        return $this->hasMany(Section::className(), ['department_id' => 'id']);
    }
}
