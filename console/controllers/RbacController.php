<?php
namespace console\controllers;
use yii\console\Controller;
use Yii;

class RbacController extends Controller{
    public function actionHello(){
        echo "Hello";
    }
    
    public function actionCreatePermission(){
        $auth = Yii::$app->authManager;
        
        $booking_booking_index = $auth->createPermission('booking/booking/index');
        $booking_booking_index->description = 'รายการจองห้องประชุม';
        $auth->add($booking_booking_index);
        
        $booking_booking_create = $auth->createPermission('booking/booking/create');
        $booking_booking_create->description = 'จองห้องประชุม';
        $auth->add($booking_booking_create);
        
        $booking_booking_update = $auth->createPermission('booking/booking/update');
        $booking_booking_update->description = 'แก้ไขการจองห้องประชุม';
        $auth->add($booking_booking_update);
        
        $booking_booking_delete = $auth->createPermission('booking/booking/delete');
        $booking_booking_delete->description = 'ลบรายการจองห้องประชุม';
        $auth->add($booking_booking_delete);
        
        $booking_booking_view = $auth->createPermission('booking/booking/view');
        $booking_booking_view->description = 'ดูรายการจองห้องประชุม';
        $auth->add($booking_booking_view);
        
        $booking_room_index = $auth->createPermission('booking/room/index');
        $booking_room_index->description = 'รายการห้องประชุม';
        $auth->add($booking_room_index);
        
        $booking_room_create = $auth->createPermission('booking/room/create');
        $booking_room_create->description = 'เพิ่มรายการห้องประชุม';
        $auth->add($booking_room_create);
        
        $booking_room_update = $auth->createPermission('booking/room/update');
        $booking_room_update->description = 'แก้ไขรายการห้องประชุม';
        $auth->add($booking_room_update);
        
        $booking_room_delete = $auth->createPermission('booking/room/delete');
        $booking_room_delete->description = 'ลบรายการห้องประชุม';
        $auth->add($booking_room_delete);
        
        $booking_room_view = $auth->createPermission('booking/room/view');
        $booking_room_view->description = 'ดูรายการห้องประชุม';
        $auth->add($booking_room_view);
        
        $personal_person_index = $auth->createPermission('personal/person/index');
        $personal_person_index->description = 'รายการบุคลากร';
        $auth->add($personal_person_index);
        
        $personal_person_create = $auth->createPermission('personal/person/create');
        $personal_person_create->description = 'เพิ่มรายการบุคลากร';
        $auth->add($personal_person_create);
        
        $personal_person_update = $auth->createPermission('personal/person/update');
        $personal_person_update->description = 'แก้ไขรายการบุคลากร';
        $auth->add($personal_person_update);
        
        $personal_person_delete = $auth->createPermission('personal/person/delete');
        $personal_person_delete->description = 'ลบรายการบุคลากร';
        $auth->add($personal_person_delete);
        
        $personal_person_view = $auth->createPermission('personal/person/view');
        $personal_person_view->description = 'ดูรายการบุคลากร';
        $auth->add($personal_person_view);
        
        
        echo "Create Permission Success!";
        
    }
    
    public function actionCreateRole(){
        $auth = Yii::$app->authManager;
        
        $booking_booking_index = $auth->createPermission('booking/booking/index');
        $booking_booking_create = $auth->createPermission('booking/booking/create');
        $booking_booking_update = $auth->createPermission('booking/booking/update');
        $booking_booking_delete = $auth->createPermission('booking/booking/delete');
        $booking_booking_view = $auth->createPermission('booking/booking/view');
        
        $booking_room_index = $auth->createPermission('booking/room/index');
        $booking_room_create = $auth->createPermission('booking/room/create');
        $booking_room_update = $auth->createPermission('booking/room/update');
        $booking_room_delete = $auth->createPermission('booking/room/delete');
        $booking_room_view = $auth->createPermission('booking/room/view');
        
        $personal_person_index = $auth->createPermission('personal/person/index');
        $personal_person_create = $auth->createPermission('personal/person/create');
        $personal_person_update = $auth->createPermission('personal/person/update');
        $personal_person_delete = $auth->createPermission('personal/person/delete');
        $personal_person_view = $auth->createPermission('personal/person/view');
        
        $user = $auth->createRole('user');
        $auth->add($user);
        $auth->addChild($user, $booking_booking_index);
        $auth->addChild($user, $booking_booking_view);
        $auth->addChild($user, $booking_booking_create);
        $auth->addChild($user, $personal_person_index);
        $auth->addChild($user, $personal_person_view);
        $auth->addChild($user, $booking_room_index);
        $auth->addChild($user, $booking_room_view);
        
        $staff_personal = $auth->createRole('staff_personal');
        $auth->add($staff_personal);
        $auth->addChild($staff_personal, $personal_person_create);
        $auth->addChild($staff_personal, $personal_person_update);
        $auth->addChild($staff_personal, $personal_person_delete);
        $auth->addChild($staff_personal, $user);
        
        $staff_booking = $auth->createRole('staff_booking');
        $auth->add($staff_booking);
        $auth->addChild($staff_booking, $booking_booking_update);
        $auth->addChild($staff_booking, $booking_booking_delete);
        $auth->addChild($staff_booking, $booking_room_create);
        $auth->addChild($staff_booking, $booking_room_update);
        $auth->addChild($staff_booking, $booking_room_delete);
        $auth->addChild($staff_booking, $user);
        
        $admin = $auth->createRole('admin');
        $auth->add($admin);
        $auth->addChild($admin, $staff_personal);
        $auth->addChild($admin, $staff_booking);
        
        echo 'Create Role Success!';
    }
    
    public function actionCreateAssignment(){
        $auth = Yii::$app->authManager;
        
        $user = $auth->createRole('user');
        $staff_personal = $auth->createRole('staff_personal');
        $staff_booking = $auth->createRole('staff_booking');
        $admin = $auth->createRole('admin');
        
        $auth->assign($user, 4);
        $auth->assign($staff_booking, 3);
        $auth->assign($staff_personal, 2);
        $auth->assign($admin, 1);
        
        
        echo 'Create Assignment Success!';
    }
    
    public function actionCreateRule(){
        $auth = Yii::$app->authManager;
        
        $rule = new \common\rbac\OwnRule;
        $auth->add($rule);
        
        $updateOwnPost = $auth->createPermission('updateOwnPost');
        $updateOwnPost->description = 'ปรับปรุงการโพสของตัวเอง';
        $updateOwnPost->ruleName = $rule->name;
        $auth->add($updateOwnPost);
        
        $booking_booking_update = $auth->createPermission('booking/booking/update');
        $auth->addChild($updateOwnPost, $booking_booking_update);
        
        $user = $auth->createPermission('user');
        $auth->addChild($user, $updateOwnPost);
        
        echo 'Create Rule Success!';
        
    }
}
