<?php 

namespace api\v1\models\user;

use core\misc\Utilities;
use core\misc\Database;

class Tokenizer {

    public static function login(){
        $username = trim(Utilities::fetchRequiredDataFromArray($_GET, 'username'));
        $password = trim(Utilities::fetchRequiredDataFromArray($_GET, 'password'));

        $user = (new Database())->processQuery("Select * from users WHERE user_username =? AND user_password = md5(?) ", [
            $username,
            $password
        ]);


        if(!empty($user)){
            $userObj = reset($user);
            $userId = Utilities::fetchRequiredDataFromArray($userObj, 'user_id');
            $token = (new Database())->processQuery("Select * from token WHERE token_user_id =?", [
                $userId
            ]);

            $random = Utilities::randomizer(255);
            if(empty($token)){
                $tk = (new Database())->processQuery("INSERT INTO token (token_user_id, token_token, token_created_at) VALUES (?, ?, now())", [
                    $userId,
                    $random
                ]);
            }else{
                $tk = (new Database())->processQuery("UPDATE token SET token_token = ?, token_updated_at = now() WHERE token_user_id = ?" , [
                    $random,
                    $userId
                ]);
            }

            return Utilities::response(true , null, ["token" => $random, "user_id" => $userId]);
        }else{
            return Utilities::response(false, ["error" => "Invalid Username / Password."], null);
        }

    
    }


    public static function checkToken(){
        $headers = Utilities::getHeaders();
        $authorization = Utilities::fetchRequiredDataFromArray($headers, "Authorization" );
        $userId = Utilities::fetchRequiredDataFromArray($headers, "Userid");

        $tokenObj = (new Database())->processQuery("Select * from token WHERE token_user_id =? AND token_token = ?", [
            $userId,
            $authorization
        ]);
        
        return Utilities::response(empty($tokenObj) ? false: true, null, null);
        
        Utilities::dd($tokenObj);
    }
}