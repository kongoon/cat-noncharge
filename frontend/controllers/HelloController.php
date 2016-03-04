<?php
namespace frontend\controllers;
use yii\web\Controller;
use yii\filters\AccessControl;


class HelloController extends Controller
{
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['hi', 'say'],
                'rules' => [
                    [
                        'allow' => true,
                        'actions' => ['hi'],
                        'roles' => ['?', '@'],
                    ],
                    [
                        'allow' => true,
                        'actions' => ['say'],
                        'roles' => ['@'],
                    ]
                ],
            ]
        ];
    }

    public function actionHi()
    {
        $this->layout = 'blank';



        return $this->render('hi');
    }
    public function actionSay()
    {
        $this->layout = 'blank';
        return $this->render('say');
    }
}
 ?>
