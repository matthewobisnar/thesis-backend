<?php
namespace api\v1\models\process;

use core\misc\Database;
use core\misc\Defaults;
use core\misc\Utilities;

class Process
{

    public static function statistics()
    {
        $customers = (new Database())->processQuery("SELECT count(*) as `count`, customer_status FROM customer GROUP BY customer_status", []);
        $employees = (new Database())->processQuery("SELECT count(*) as `count`, emp_status FROM employee GROUP BY emp_status", []);
        $todos = (new Database())->processQuery("SELECT count(*) as `count`, todo_status FROM todo GROUP BY todo_status", []);
        
        return Utilities::response(true, null, [
            "customer" => self::processStatuses($customers, 'customer_status'),
            "employee" => self::processStatuses($employees, 'emp_status'),
            "todo" => self::processStatuses($todos, 'todo_status'),
        ]);
    }

    public static function deleteEmployee()
    {
        $empId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $output = (new Database())->processQuery("DELETE FROM employee WHERE emp_id = ?", [$empId]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function processStatuses($data, $columnStatus)
    {
        $status = [];

        foreach ($data as $row) {
            $status[(string)$columnStatus.'_'.$row[$columnStatus]] = $row['count'];
        }

        return $status;
    }

    public static function dashboard()
    {
        $customers = (new Database())->processQuery("SELECT * FROM customer ORDER BY customer_created_at DESC, customer_updated_at DESC", []);
        $output = [];

        foreach ($customers as $customer) {
            $output[$customer['customer_status']][] = $customer;
        }

        return Utilities::response(true, null, $output);
    }

    public static function dashboardDetail()
    {
        $customerId = Utilities::fetchRequiredDataFromArray($_GET, 'customer_id');
        $customers = (new Database())->processQuery("SELECT * FROM customer WHERE customer_id = ?", [$customerId]);

        return Utilities::response(true, null, $customers);
    }

    public static function updateCustomer()
    {
        $customerId = Utilities::fetchRequiredDataFromArray($_POST, 'customer_id');
        $status = Utilities::fetchRequiredDataFromArray($_POST, 'status');
        $customer = (new Database())->processQuery("UPDATE customer SET customer_status = ?, customer_updated_at = now() WHERE customer_id = ?", [$status, $customerId]);

        return Utilities::response(((!empty($customer['response']) && $customer['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function deleteCustomer()
    {
        $customerId = Utilities::fetchRequiredDataFromArray($_POST, 'customer_id');
        $customer = (new Database())->processQuery("DELETE FROM customer WHERE customer_id = ?", [$customerId]);

        return Utilities::response(((!empty($customer['response']) && $customer['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function getEmployeeList()
    {
        $employees = (new Database())->processQuery("SELECT * FROM employee  ORDER BY  emp_last_name ASC", []);
        
        return Utilities::response(true, null, ["employees" => $employees, "count" => count($employees)]);
    }

    public static function getActiveEmployeeList()
    {
        $employees = (new Database())->processQuery("SELECT * FROM employee  WHERE emp_status = 1 ORDER BY emp_last_name ASC", []);
        
        return Utilities::response(true, null, ["employees" => $employees, "count" => count($employees)]);
    }


    public static function createEmployee()
    {
        $fname = Utilities::fetchRequiredDataFromArray($_POST, 'fname');
        $lname = Utilities::fetchRequiredDataFromArray($_POST, 'lname');
        $email = strtolower(trim(Utilities::fetchRequiredDataFromArray($_POST, 'email')));
        $mobile = substr(preg_replace( '/[^0-9]/', '', Utilities::fetchRequiredDataFromArray($_POST, 'mobile')), -10, 10);
        $employees = (new Database())->processQuery("SELECT * FROM employee WHERE emp_mobile_number = ? OR emp_email = ?", [$mobile, $email]);

        if (count($employees) > 0) {
            return Utilities::response(false, ["error" => "Account already exist. Unable to complete process."], null);
        }

        $output = (new Database())->processQuery("INSERT INTO employee (emp_first_name, emp_last_name, emp_mobile_number, emp_email, emp_created_at) VALUES (?,?,?,?,now())", [$fname, $lname, $mobile, $email]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function updateEmployee()
    {
        $empId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $fname = Utilities::fetchRequiredDataFromArray($_POST, 'fname');
        $lname = Utilities::fetchRequiredDataFromArray($_POST, 'lname');
        $email = strtolower(trim(Utilities::fetchRequiredDataFromArray($_POST, 'email')));
        $mobile = substr(preg_replace( '/[^0-9]/', '', Utilities::fetchRequiredDataFromArray($_POST, 'mobile')), -10, 10);
        $employees = (new Database())->processQuery("SELECT * FROM employee WHERE (emp_mobile_number = ? OR emp_email = ?) AND emp_id != ?", [$mobile, $email]);

        if (count($employees) > 0) {
            return Utilities::response(false, ["error" => "E-mail/Mobile Number already in use. Unable to complete process."], null);
        }

        $output = (new Database())->processQuery("UPDATE employee SET emp_first_name = ?, emp_last_name = ?, emp_mobile_number = ?, emp_email = ?, emp_updated_at = now() WHERE emp_id = ?", [$fname, $lname, $mobile, $email, $empId]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function getEmployee()
    {
        $empId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $employee = (new Database())->processQuery("SELECT * FROM employee WHERE emp_id = ?", [$empId]);

        return Utilities::response(true, null, (reset($employee) ?? null));
    }

    public static function getTodoList()
    {
        $todos = (new Database())->processQuery("SELECT * FROM todo ORDER BY todo_deadline ASC, todo_updated_at DESC", []);
        $output = [];

        foreach ($todos as $todo) {
            $output[$todo['todo_status']][] = $todo;
        }

        return Utilities::response(true, null, $output);
    }

    public static function getTodoDetail()
    {
        $todoId = Utilities::fetchRequiredDataFromArray($_POST, 'todo_id');
        $todo = (new Database())->processQuery("SELECT * FROM todo WHERE todo_id =? LIMIT 1 ", [$todoId]);

        return Utilities::response(true, null, $todo);
    }

    public static function createTodo()
    {
        $title = Utilities::fetchRequiredDataFromArray($_POST, 'title');
        $description = Utilities::fetchRequiredDataFromArray($_POST, 'description');
        $deadline = Utilities::formatDate(Utilities::fetchRequiredDataFromArray($_POST, 'deadline'), 'Y-m-d H:i:s');
        $output = (new Database())->processQuery("INSERT INTO todo (todo_title, todo_description, todo_deadline, todo_created_at) VALUES (?,?,?,now())", [$title, $description, $deadline]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function updateTodo()
    {
        $todoId = Utilities::fetchRequiredDataFromArray($_POST, 'todo_id');
        $status = Utilities::fetchRequiredDataFromArray($_POST, 'status');

        $todo = (new Database())->processQuery("UPDATE todo SET todo_status = ?, todo_updated_at = now() WHERE todo_id = ?", [$status, $todoId]);

        return Utilities::response(((!empty($todo['response']) && $todo['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function deleteTodo()
    {
        $todoId = array_map(function($payload) {return (int) $payload;}, Utilities::fetchRequiredDataFromArrayAsArray($_POST, 'todo_id'));
        $params = "(".str_repeat('?,', count($todoId) - 1).'?)';
        $todo = (new Database())->processQuery("DELETE FROM todo WHERE todo_id in $params", $todoId);
        return Utilities::response(((!empty($todo['response']) && $todo['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function createMessage()
    {
        $message = Utilities::fetchRequiredDataFromArray($_POST, 'message_content');
       
        $output = (new Database())->processQuery("INSERT INTO `message` (message_content, message_created_at) VALUES (?,now())", [$message]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function getSentMessages()
    {
        $messages = (new Database())->processQuery("SELECT * FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile ORDER BY sent_created_at ASC", []);

        return Utilities::response(true, null, $messages);
    }

    public static function deleteSentMessage()
    {
        $sentMessageId = array_map(function($payload) {return (int) $payload;}, Utilities::fetchRequiredDataFromArrayAsArray($_POST, 'sent_message_id'));
        $params = "(".str_repeat('?,', count($sentMessageId) - 1).'?)';
        $sentMessage = (new Database())->processQuery("DELETE FROM sent_message WHERE sent_message_id in $params", $sentMessageId);
        return Utilities::response(((!empty($sentMessage['response']) && $sentMessage['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function getSentMessagesDetail()
    {
        $sentMessageId = Utilities::fetchRequiredDataFromArray($_GET, 'sent_message_id');
        $messages = (new Database())->processQuery("SELECT * FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile WHERE sent_message_id = ? ", [$sentMessageId]);
        return Utilities::response(true, null, $messages);
    }

    public static function createContacts()
    {
        $contact = Utilities::fetchRequiredDataFromArray($_POST, 'emp_status');
        $contactId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $output = (new Database())->processQuery("UPDATE `employee` SET emp_status = ?, emp_updated_at = now() WHERE emp_id = ?", [$contact, $contactId]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }
}