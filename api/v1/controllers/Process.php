<?php
namespace api\v1\controllers;

use core\misc\Utilities;
use api\v1\models\globe\GlobeLabs;

class Process
{
    public function actionResult(){
        GlobeLabs::sendSms();
    }
}
