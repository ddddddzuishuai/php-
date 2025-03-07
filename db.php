<?php
$host = 'localhost';
$dbname = 'student_grades_system';
$username = 'root';
$password = 'dongMAO@123';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("数据库连接失败: " . $e->getMessage());
}
?>