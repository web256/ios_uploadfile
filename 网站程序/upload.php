<?php
	header("Content-type: text/html; charset=utf-8"); 
	// 配置文件需要上传到服务器的路径，需要允许所有用户有可写权限，否则无法上传！
	$uploadPath = 'uploads/';
	
	$IOS_forKey=$_FILES["uploadFile"];

	if ($IOS_forKey["error"] > 0) {
		echo "传入参数错误：" . $IOS_forKey["error"] . "<br />";
	} else {
		echo "文件: " . $IOS_forKey["name"] . "<br />";
		echo "类型: " . $IOS_forKey["type"] . "<br />";
		echo "大小: " . ($IOS_forKey["size"] / 1024) . " Kb<br />";
		echo "临时文件: " . $IOS_forKey["tmp_name"] . "<br />";

		chmod($uploadPath . $IOS_forKey["name"], 0666);
		if (file_exists($uploadPath . $IOS_forKey["name"])) {
			echo $IOS_forKey["name"] . "文件已经存在！";
		} else {
			move_uploaded_file($IOS_forKey["tmp_name"], $uploadPath . $IOS_forKey["name"]);
			echo "上传文件保存在: " . $uploadPath . $IOS_forKey["name"];
		}
	}
?>