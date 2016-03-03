<?php
namespace common\models;
use dektrium\user\models\User as DekUser;
use common\models\Authority;

class User extends DekUser
{
    public function getAuthority()
    {
        return $this->hasOne(Authority::className(), ['user_id' => 'id']);
    }
}
