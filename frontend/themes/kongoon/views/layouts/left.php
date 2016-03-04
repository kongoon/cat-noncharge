<?php
use yii\helpers\Html;
 ?>
<aside class="main-sidebar">

    <section class="sidebar">

        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">

                <?=Html::img(Yii::getAlias('@web').'/upload/person/'.Yii::$app->user->identity->authority->employee->person->photo, ['class' => 'img-circle'])?>
            </div>
            <div class="pull-left info">
                <p><?=Yii::$app->user->identity->authority->employee->person->firstname?> <?=Yii::$app->user->identity->authority->employee->person->lastname?></p>

                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>

        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search..."/>
              <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
            </div>
        </form>
        <!-- /.search form -->

        <?= dmstr\widgets\Menu::widget(
            [
                'options' => ['class' => 'sidebar-menu'],
                'items' => [
                    ['label' => 'MAIN MENU', 'options' => ['class' => 'header']],

                    ['label' => 'เข้าสู่ระบบ', 'url' => ['site/login'], 'visible' => Yii::$app->user->isGuest],
                    ['label' => 'Profile', 'url' => ['/user/settings/profile'],],
                    ['label' => 'Account', 'url' => ['/user/settings/account'],],
                    [
                        'label' => 'การยืมหมายเลข',
                        'icon' => 'fa fa-share',
                        'url' => '#',
                        'items' => [
                            ['label' => 'รายการยืม', 'icon' => 'fa fa-file-code-o', 'url' => ['/borrow/borrow/index'],],

                            ['label' => 'ยืมหมายเลข', 'icon' => 'fa fa-file-code-o', 'url' => ['/borrow/borrow/create'],],

                            ['label' => 'เบอร์โทร', 'icon' => 'fa fa-file-code-o', 'url' => ['/borrow/number/index'],],

                            ['label' => 'Sim Card', 'icon' => 'fa fa-file-code-o', 'url' => ['/borrow/sim/index'],],
                            ['label' => 'Report', 'icon' => 'fa fa-file-code-o', 'url' => ['/borrow/report/'],],

                            //['label' => 'Debug', 'icon' => 'fa fa-dashboard', 'url' => ['/debug'],],
                            /*[
                                'label' => 'Level One',
                                'icon' => 'fa fa-circle-o',
                                'url' => '#',
                                'items' => [
                                    ['label' => 'Level Two', 'icon' => 'fa fa-circle-o', 'url' => '#',],
                                    [
                                        'label' => 'Level Two',
                                        'icon' => 'fa fa-circle-o',
                                        'url' => '#',
                                        'items' => [
                                            ['label' => 'Level Three', 'icon' => 'fa fa-circle-o', 'url' => '#',],
                                            ['label' => 'Level Three', 'icon' => 'fa fa-circle-o', 'url' => '#',],
                                        ],
                                    ],
                                ],
                            ],*/
                        ],
                    ],
                ],
            ]
        ) ?>

    </section>

</aside>
