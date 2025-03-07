<?php
session_start();
if (isset($_SESSION['tid'])) {
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require 'db.php';

    $tid = $_POST['tid'];
    $password = $_POST['password'];

    $stmt = $conn->prepare("SELECT * FROM t_teacher WHERE tid = :tid AND password = :password");
    $stmt->execute(['tid' => $tid, 'password' => $password]);
    $teacher = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($teacher) {
        $_SESSION['tid'] = $teacher['tid'];
        $_SESSION['tname'] = $teacher['tname'];
        header("Location: dashboard.php");
        exit();
    } else {
        $error = "账号或密码错误";
    }
}
?>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>教师登录</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>教师登录</h1>
    <?php if (isset($error)): ?>
        <p style="color: red;"><?php echo $error; ?></p>
    <?php endif; ?>
    <form method="POST" action="">
        <label for="tid">工号:</label>
        <input type="text" id="tid" name="tid" required><br><br>
        <label for="password">密码:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">登录</button>
    </form>
</body>
</html>