<?php
	session_start();
	error_reporting(E_ALL);
	include("../oz.php");
	
	class M_Test extends M {
		public function __construct($name) {
			parent::__construct("sqlite:" . $name . ".sqlite");
		}
		
		public function getConfig() {
			return $this->query("SELECT * FROM config");
		}
	}
	
	class V_Test extends V {
	}
	
	class C_Test extends C {
		public function dispatch() {
			$this->output->setLanguage("cz");
			$this->output->setTemplate("xsl/test.xsl");

			$str = $this->output->translate("3/4 -> <- <-> => <= <=> >> << -- --- 640x480 (c) (tm) (r) 1/2 a1/2 11/2 1/2", V::FRACTIONS + V::TYPO);
			$str .= " <em>asdasdasd</em>";
			$data = array(
				"a"=>array(
					"b"=>"c",
					"config"=>$this->input->getConfig(),
					""=>$str,
				)
			);
			$this->output->setData($data);
			parent::dispatch();
		}
	}
	
	$input = new M_Test("test");
	$output = new V_Test();
	new C_Test($input, $output);
?>

