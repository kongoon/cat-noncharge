<?php
namespace common\components;
use yii\rbac\Rule;

class UpdateOwn extends Rule {
    public $name = 'isOwn';
    
    public function execute($user, $item, $params) {
        return isset($params['model']) ? $params['model']->user_id == $user : false;
    }
}
