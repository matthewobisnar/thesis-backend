<?php
namespace api\v1\controllers;

use api\v1\models\process\Process;
use core\misc\Database;
use core\misc\Defaults;
use core\misc\Utilities;

class Dashboard
{

    public function __construct() 
    {
        $headers = Utilities::getHeaders();
		$auth = Utilities::fetchRequiredDataFromArray($headers, 'Authorization');
		$userId = Utilities::fetchRequiredDataFromArray($headers, 'Userid');

        $tokenObj = (new Database())->processQuery("SELECT * FROM token WHERE token_user_id = ? AND token_token = ?", [$userId, $auth]);
        
        if (empty($tokenObj)) {
            return Utilities::responseWithException(Defaults::ERROR_401);
        }
    }
    
    public function actionStatistics()
    {
        return Process::statistics();
    }

    public function actionDashboard()
    {
        return Process::dashboard();
    }

    public function actionDashboardDetail()
    {
        return Process::dashboardDetail();
    }

    public function actionUpdateCustomer()
    {
        return Process::updateCustomer();
    }

    public function actionDeleteCustomer()
    {
        return Process::deleteCustomer();
    }

    //=====================

    public function actionGetEmployeeList()
    {
        return Process::getEmployeeList();
    }

    public function actionGetActiveEmployeeList()
    {
        return Process::getActiveEmployeeList();
    }

    public function actionCreateEmployee()
    {
        return Process::createEmployee();
    }

    public function actionDeleteEmployee()
    {
        return Process::deleteEmployee();
    }

    public function actionUpdateEmployee()
    {
        return Process::updateEmployee();
    }

    public function actionGetEmployee()
    {
        return Process::getEmployee();
    }

    public function actionGetTodoList()
    {
        return Process::getTodoList();
    }

    public function actionGetTodoDetail()
    {
        return Process::getTodoDetail();
    }

    public function actionCreateTodo()
    {
        return Process::createTodo();
    }

    public function actionUpdateTodo()
    {
        return Process::updateTodo();
    }

    public function actionDeleteTodo()
    {
        return Process::deleteTodo();
    }
    
    public function actionCreateMessage()
    {
        return Process::createMessage();
    }

    public function actionGetMessage()
    {
        return Process::getSentMessages();
    }

    public function actionGetMessageDetail()
    {
        return Process::getSentMessagesDetail();
    }


    public function actionDeleteSentMessages()
    {
        return Process::deleteSentMessage();
    }

    public function actionCreateContects()
    {
        return Process::createContacts();
    }

 
}
