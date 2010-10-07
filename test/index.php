<?php
	session_start();
	error_reporting(E_ALL);
	include("../oz.php");
	include("test.php");
	
	$model = new M_Test("test");
	$view = new V_Test();
	$c = new C_Test($model, $view);
?>
