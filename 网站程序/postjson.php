<?php 
header('Content-Type:text/plain;charset=utf-8');

$json = file_get_contents('php://input');
// 反序列化JSON
$obj = json_decode($json, TRUE ); 

// 打印对象明细信息
print_r(json_encode($obj));
echo '真的是从服务器回来的哦';
    
?>
