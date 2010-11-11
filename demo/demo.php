<?php
	class APP_Demo extends APP {
		protected $db = null;
		protected $template = null;

		protected $dispatch_table = array(
			"get	^/$					index",
			"get	^/articles$			articles",
			"get	^/article/(\d+)$	article",
			"post	^/language$			language",
		);
		
		public function __construct() {
			parent::__construct();

			$this->db = new DB("sqlite:demo.sqlite");
			$this->template = new XML();
			$this->template->setParameter("LANGUAGE", "cz");
			$this->template->setParameter("BASE", $this->BASE);
			$this->template->addFilter(new FILTER_TYPO());
			$this->template->addFilter(new FILTER_NBSP());
			$this->template->addFilter(new FILTER_FRACTIONS());
			
			$this->dispatch();
		}

		protected function index($method, $matches) {
			echo $this->template->setTemplate("xsl/index.xsl")->toString();
		}
		
		protected function articles($method, $matches) {
			$this->template->setTemplate("xsl/articles.xsl");
			
			$articles = $this->db->query("SELECT id, name, popularity FROM article");
			$data = array("articles" => array(
							"article" => $articles
						));
			$this->template->setData($data);
			
			echo $this->template->toString();
		}

		protected function article($method, $matches) {
			$this->template->setTemplate("xsl/article.xsl");

			$id = $matches[1];
			$article = $this->db->query("SELECT * FROM article WHERE id = ?", array($id));
			if (!count($article)) { return $this->http404(); }
			$article = $article[0];

			$this->template->setData(array(
				"article" => array(
					"id" => $article["id"],
					"" => $article["text"],
					"name" => $article["name"]
				)
			));
			echo $this->template->toString();
		}

		protected function language($method, $matches) {
			$this->httpRedirect("/");
		}
		
	}
?>
