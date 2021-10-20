<?php
namespace api\v1\controllers;

use core\misc\Utilities;
use api\v1\models\globe\GlobeLabs;
use core\misc\Database;

class Process
{
    public function actionResult(){
        GlobeLabs::sendSms();
    }

    public function actionDd()
    {

        $optIn = (new Database())->processQuery("SELECT opt_in_mobile_number FROM opt_in WHERE opt_in_mobile_number =?", ['945d2567866']);     
        var_dump($optIn);
    }
}
