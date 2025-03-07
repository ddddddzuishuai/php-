<?php
session_start();
if (!isset($_SESSION['tid'])) {
    header("Location: index.php");
    exit();
}

require 'db.php';

$tid = $_SESSION['tid'];

// 查询教师所教授的课程
$stmt = $conn->prepare("SELECT cid, cname FROM t_course WHERE tid = :tid");
$stmt->execute(['tid' => $tid]);
$courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 查询所有学生
$stmt = $conn->query("SELECT sid, sname FROM t_student");
$all_students = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 查询每门课程的学生选课情况
$student_courses = [];
foreach ($courses as $course) {
    $stmt = $conn->prepare("
        SELECT s.sid, s.sname, sc.cid, sc.score 
        FROM t_student_course sc 
        JOIN t_student s ON sc.sid = s.sid 
        WHERE sc.cid = :cid
    ");
    $stmt->execute(['cid' => $course['cid']]);
    $student_courses[$course['cname']] = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// 处理成绩修改
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['update_score'])) {
    $sid = $_POST['sid'];
    $cid = $_POST['cid'];
    $score = $_POST['score'];

    $stmt = $conn->prepare("UPDATE t_student_course SET score = :score WHERE sid = :sid AND cid = :cid");
    $stmt->execute(['score' => $score, 'sid' => $sid, 'cid' => $cid]);

    header("Location: dashboard.php");
    exit();
}

// 处理删除选课记录
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['delete_record'])) {
    $sid = $_POST['sid'];
    $cid = $_POST['cid'];

    $stmt = $conn->prepare("DELETE FROM t_student_course WHERE sid = :sid AND cid = :cid");
    $stmt->execute(['sid' => $sid, 'cid' => $cid]);

    header("Location: dashboard.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>教师仪表盘</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>欢迎, <?php echo $_SESSION['tname']; ?></h1>
    <a href="logout.php">注销</a>
    <h2>您的课程及学生选课情况</h2>

    <?php foreach ($student_courses as $course_name => $students): ?>
        <h3><?php echo $course_name; ?></h3>
        <table border="1">
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>选课</th>
                <th>成绩</th>
                <th>操作</th>
            </tr>
            <?php foreach ($students as $student): ?>
                <tr>
                    <td><?php echo $student['sid']; ?></td>
                    <td><?php echo $student['sname']; ?></td>
                    <td><?php echo $course_name; ?></td>
                    <td>
                        <form method="POST" action="" style="display:inline;">
                            <input type="hidden" name="sid" value="<?php echo $student['sid']; ?>">
                            <input type="hidden" name="cid" value="<?php echo $student['cid']; ?>">
                            <input type="number" name="score" value="<?php echo $student['score'] ?? ''; ?>" min="0" max="100">
                            <button type="submit" name="update_score">修改成绩</button>
                        </form>
                    </td>
                    <td>
                        <form method="POST" action="" style="display:inline;">
                            <input type="hidden" name="sid" value="<?php echo $student['sid']; ?>">
                            <input type="hidden" name="cid" value="<?php echo $student['cid']; ?>">
                            <button type="submit" name="delete_record" onclick="return confirm('确定删除该选课记录吗？');">删除记录</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php endforeach; ?>

    <h2>添加选课记录</h2>
    <form method="POST" action="add_record.php">
        <label for="sid">学号:</label>
        <select id="sid" name="sid" required>
            <option value="">请选择学号</option>
            <?php foreach ($all_students as $student): ?>
                <option value="<?php echo $student['sid']; ?>"><?php echo $student['sid'] . ' - ' . $student['sname']; ?></option>
            <?php endforeach; ?>
        </select><br><br>

        <label for="cid">课程号:</label>
        <select id="cid" name="cid" required>
            <option value="">请选择课程号</option>
            <?php foreach ($courses as $course): ?>
                <option value="<?php echo $course['cid']; ?>"><?php echo $course['cid'] . ' - ' . $course['cname']; ?></option>
            <?php endforeach; ?>
        </select><br><br>

        <button type="submit">添加记录</button>
    </form>
</html>