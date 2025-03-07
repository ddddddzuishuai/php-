<?php
session_start();
if (!isset($_SESSION['tid'])) {
    header("Location: index.php");
    exit();
}

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $sid = $_POST['sid'];
    $cid = $_POST['cid'];

    // 检查学生和课程是否存在
    $stmt = $conn->prepare("SELECT * FROM t_student WHERE sid = :sid");
    $stmt->execute(['sid' => $sid]);
    $student = $stmt->fetch(PDO::FETCH_ASSOC);

    $stmt = $conn->prepare("SELECT * FROM t_course WHERE cid = :cid");
    $stmt->execute(['cid' => $cid]);
    $course = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$student) {
        echo "学生不存在！";
        exit();
    }

    if (!$course) {
        echo "课程不存在！";
        exit();
    }

    // 检查是否已经存在相同的选课记录
    $stmt = $conn->prepare("SELECT * FROM t_student_course WHERE sid = :sid AND cid = :cid");
    $stmt->execute(['sid' => $sid, 'cid' => $cid]);
    $existing_record = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($existing_record) {
        echo "该学生已经选择了这门课程，无法重复添加！";
    } else {
        // 插入选课记录（成绩可以为空）
        $stmt = $conn->prepare("INSERT INTO t_student_course (sid, cid, score) VALUES (:sid, :cid, NULL)");
        $stmt->execute(['sid' => $sid, 'cid' => $cid]);

        header("Location: dashboard.php");
        exit();
    }
}
?>