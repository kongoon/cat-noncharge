<?php

namespace frontend\modules\borrow\controllers;

use Yii;
use common\models\Borrow;
use common\models\BorrowItem;
use common\models\Number;
use frontend\modules\borrow\models\BorrowSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\data\ArrayDataProvider;
use kartik\mpdf\Pdf;
use yii\web\UploadedFile;
//use yii\data\ArrayDataProvider;

/**
 * BorrowController implements the CRUD actions for Borrow model.
 */
class BorrowController extends Controller
{
    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    /**
     * Lists all Borrow models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new BorrowSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Borrow model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        $model = $this->findModel($id);
        if($model->load(Yii::$app->request->post()))
        {
            $model->file1 = UploadedFile::getInstance($model, 'file1');
            $model->file2 = UploadedFile::getInstance($model, 'file2');

            $model->file1 = $model->uploadFirst();
            $model->file2 = $model->uploadSecond();

            $model->save();

        }
        return $this->render('view', [

            'model' => $model,
        ]);
    }

    /**
     * Creates a new Borrow model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Borrow();
        $rows = (new \yii\db\Query())
            ->select(['number.number', 'number.id', 'number_sim.id as number_sim_id', 'sim_card.iccid'])
            ->from('number_sim')
            
            ->join('LEFT JOIN', 'number', 'number.id = number_sim.number_id')
            ->join('LEFT JOIN', 'sim_card', 'sim_card.id = number_sim.sim_card_id')
            ->where('number.status > 1')
            ->all();
        $dataProvider = new ArrayDataProvider([
            'allModels' => $rows
        ]);

        if ($model->load(Yii::$app->request->post())) {

            //var_dump($_POST['selection']);
            //die();
            $model->user_id = Yii::$app->user->getId();
            if($model->save()){
                $limited = $_POST['limited'];
                $borrow_type = $_POST['borrow_type'];
                $i = 0;
                foreach($_POST['selection'] as $key => $val){
                    $bi = new BorrowItem();
                    $bi->borrow_id = $model->id;
                    $bi->number_sim_id = $val;
                    $bi->limited_id = $limited[$i];
                    $bi->borrow_type = $borrow_type[$i];

                    $bi->save();

                    $number = $bi->numberSim->number;
                    $number->status = '1';
                    $number->save();
                    $i++;
                }
            }
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                'model' => $model,
                'dataProvider' => $dataProvider,
            ]);
        }
    }

    /**
     * Updates an existing Borrow model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Borrow model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Borrow model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Borrow the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Borrow::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    public function actionPdf($id)
    {
        $model = $this->findModel($id);
        $dataProvider = new ArrayDataProvider([
            'allModels' => $model->borrowItems,
        ]);
        //var_dump($model->borrowItems);

        // get your HTML raw content without any layouts or scripts
        $content = $this->renderPartial('_pdf', [
            'model' => $model,
            'dataProvider' => $dataProvider,
        ]);

        // setup kartik\mpdf\Pdf component
        $pdf = new Pdf([
            // set to use core fonts only
            'mode' => Pdf::MODE_UTF8,
            // A4 paper format
            'format' => Pdf::FORMAT_A4,
            // portrait orientation
            'orientation' => Pdf::ORIENT_PORTRAIT,
            // stream to browser inline
            'destination' => Pdf::DEST_BROWSER,
            // your html content input
            'content' => $content,
            // format content from your own css file if needed or use the
            // enhanced bootstrap css built by Krajee for mPDF formatting
            'cssFile' => '@frontend/web/css/kv-mpdf-bootstrap.css',
            // any css to be embedded if required
            'cssInline' => '.kv-heading-1{font-size:18px}',
             // set mPDF properties on the fly
            'options' => ['title' => 'ใบรับการยืมเลขหมาย'],
             // call mPDF methods on the fly
            'methods' => [
                'SetHeader'=>['ใบรับการยืมเลขหมาย'],
                'SetFooter'=>['{PAGENO}'],
            ]
        ]);

        // return the pdf output as per the destination setting
        return $pdf->render();
    }
}
