<?php

namespace frontend\modules\borrow\controllers;
use yii\data\ArrayDataProvider;
use Yii;

class ReportController extends \yii\web\Controller
{
    public function actionIndex()
    {
        $sql = "SELECT COUNT(bi.id) as total,n.number FROM borrow_item bi
            LEFT JOIN number_sim nm ON nm.id = bi.number_sim_id
            LEFT JOIN number n ON n.id = nm.number_id
            GROUP BY bi.number_sim_id
               ";
        $rows = Yii::$app->db->createCommand($sql)->queryAll();
        $graph = [];
        foreach($rows as $r){
            $graph[] = [
                //'type' => 'column',
                'name' => $r['number'],
                'y' => intval($r['total']),
                'drilldown' => $r['number'],
            ];
        }

        $y = date('Y');

        $sql_sub = "SELECT n.number,
        COUNT(IF(MONTH(date_out)=1,bi.id,NULL)) AS m1,
        COUNT(IF(MONTH(date_out)=2,bi.id,NULL)) AS m2,
        COUNT(IF(MONTH(date_out)=3,bi.id,NULL)) AS m3,
        COUNT(IF(MONTH(date_out)=4,bi.id,NULL)) AS m4,
        COUNT(IF(MONTH(date_out)=5,bi.id,NULL)) AS m5,
        COUNT(IF(MONTH(date_out)=6,bi.id,NULL)) AS m6,
        COUNT(IF(MONTH(date_out)=7,bi.id,NULL)) AS m7,
        COUNT(IF(MONTH(date_out)=8,bi.id,NULL)) AS m8,
        COUNT(IF(MONTH(date_out)=9,bi.id,NULL)) AS m9,
        COUNT(IF(MONTH(date_out)=10,bi.id,NULL)) AS m10,
        COUNT(IF(MONTH(date_out)=11,bi.id,NULL)) AS m11,
        COUNT(IF(MONTH(date_out)=12,bi.id,NULL)) AS m12
        FROM borrow_item bi
        LEFT JOIN borrow b ON b.id = bi.borrow_id
        LEFT JOIN number_sim ns ON ns.id = bi.number_sim_id
        LEFT JOIN number n ON n.id = ns.number_id
        WHERE YEAR(date_out) = '$y'
        GROUP BY bi.number_sim_id";

        $row_sub = Yii::$app->db->createCommand($sql_sub)->queryAll();
        $sub = [];
        foreach($row_sub as $rs){
            $sub[] = [
                //'type' => 'column',
                'id' => $rs['number'],
                'name' => $rs['number'],
                'data' => [['ม.ค.', intval($rs['m1'])], ['ก.พ.', intval($rs['m2'])], ['มี.ค.', intval($rs['m3'])], ['เม.ย.', intval($rs['m4'])], ['พ.ค.', intval($rs['m5'])], ['มิ.ย.', intval($rs['m6'])], ['ก.ค.', intval($rs['m7'])], ['ส.ค.', intval($rs['m8'])], ['ก.ย.', intval($rs['m9'])], ['ต.ค.', intval($rs['m10'])], ['พ.ย.', intval($rs['m11'])], ['ธ.ค.', intval($rs['m12'])]]
            ];
        }

        $dataProvider = new ArrayDataProvider([
            'allModels' => $rows,
            'sort' => [
                'attributes' => [

                ]
            ]
        ]);
        return $this->render('index',[
            'graph' => $graph,
            'drilldown' => $sub,
            'dataProvider' => $dataProvider,
        ]);
    }

    public function actionReport1()
    {

        //เตรียมข้อมูลส่งให้กราฟ

        $data = "['กรุงเทพมหานคร', 100], ['ชลบุรี', 200],";
        return $this->render('report1', [
            'data' => $data,
        ]);
    }

    public function actionReport2()
    {
        return $this->render('report2');
    }

}
