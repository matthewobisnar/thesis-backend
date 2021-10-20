<?php
namespace api\v1\controllers;

use api\v1\models\user\Tokenizer;
use core\misc\Utilities;


class Auth
{

   public function actionLogin(){
       return Tokenizer::login();
   }

   public function actionDd(){
    return die("sample");
}

   public function actionCheckToken(){
      return Tokenizer::checkToken();
  }
}
