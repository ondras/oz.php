<?php
	class DB_Test extends DB {
		public function __construct($name) {
			parent::__construct("sqlite:" . $name . ".sqlite");
		}
		
		public function getConfig() {
			return $this->query("SELECT * FROM config");
		}
	}
	
	class XML_Test extends XML {
		public function __construct() {
			parent::__construct();
			$this->addFilter(new FILTER_TYPO());
			$this->addFilter(new FILTER_NBSP());
			$this->addFilter(new FILTER_FRACTIONS());
		}
		
	}
	
	class APP_Test extends APP {
		protected $db = null;
		protected $template = null;
		protected $dispatch_table = array(
			"/" => "test",
			"/a" => "test",
		);
		
		public function __construct() {
			parent::__construct();
			$this->db = new DB_Test("test");
			$this->template = new XML_Test();
			$this->template->setParameter("LANGUAGE", "cz");
			$this->template->setParameter("BASE", $this->BASE);
			
			$this->dispatch();
		}

		protected function test() {
			$this->template->setTemplate("xsl/test.xsl");
			$str = "3/4 -> <- <-> => <= <=> >> << -- --- 640x480 (c) (tm) (r) 1/2 a1/2 11/2 1/2";
			$str .= " <em>asdasdasd</em>";
			$data = array(
				"a"=>array(
					"b"=>"c",
					""=>$str,
					"config"=>$this->db->getConfig()
				)
			);
			$this->template->setData($data);
			echo $this->template->toString();	
		}
		
		protected function error($code) {
			parent::error($code);
			echo "<h1>Error $code</h1>";
		}
	}
?>
