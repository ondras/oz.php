<?php
	class M_Test extends M {
		public function __construct($name) {
			parent::__construct("sqlite:" . $name . ".sqlite");
		}
		
		public function getConfig() {
			return $this->query("SELECT * FROM config");
		}
	}
	
	class V_Test extends V {
		public function __construct() {
			parent::__construct();
			$this->addFilter(new VF_TYPO());
			$this->addFilter(new VF_NBSP());
			$this->addFilter(new VF_FRACTIONS());
		}
		
	}
	
	class C_Test extends C {
		protected static $BASE = "/oz-php/test";
		
		public function __construct($model, $view) {
			parent::__construct($model, $view);
			$this->view->setLanguage("cz");
			
			$this->addMethod("/", "test");
			$this->dispatch();
		}

		protected function test() {
			$this->view->setTemplate("xsl/test.xsl");
			$str = "3/4 -> <- <-> => <= <=> >> << -- --- 640x480 (c) (tm) (r) 1/2 a1/2 11/2 1/2";
			$str .= " <em>asdasdasd</em>";
			$data = array(
				"a"=>array(
					"b"=>"c",
					""=>$str,
					"config"=>$this->model->getConfig()
				)
			);
			$this->view->setData($data);
			echo $this->view->output();	
		}
		
		protected function error($code) {
			parent::error($code);
			echo "wtf.";
		}
	}
?>
