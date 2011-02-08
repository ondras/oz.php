<?php
	class APP_Demo extends APP {
		protected $db = null;
		protected $view = null;

		protected $dispatch_table = array(
			"get	^/$					index",
			"get	^/articles$			articles",
			"get	^/article/(\d+)$	article",
			"post	^/language$			language",
		);
		
		public function __construct() {
			$this->db = new DB("sqlite:demo.sqlite");
			$this->view = new XML();
			
			$language = HTTP::value("language", "cookie", "cs");
			$this->view->setParameter("LANGUAGE", $language);
			$this->view->setParameter("BASE", HTTP::$BASE);
			$this->view->addFilter(new FILTER_TYPO());
			$this->view->addFilter(new FILTER_NBSP());
			$this->view->addFilter(new FILTER_FRACTIONS());
			
			$this->dispatch();
		}

		protected function index($matches) {
			echo $this->view->setTemplate("xsl/index.xsl")->toString();
		}
		
		protected function articles($matches) {
			$this->view->setTemplate("xsl/articles.xsl");
			
			$articles = $this->db->query("SELECT id, name, popularity FROM article");
			$data = array("article" => $articles);
			$this->view->addData("articles", $data);
			
			echo $this->view->toString();
		}

		protected function article($matches) {
			$this->view->setTemplate("xsl/article.xsl");

			$id = $matches[1];
			$article = $this->db->query("SELECT * FROM article WHERE id = ?", $id);
			if (!count($article)) { return $this->error404(); }
			$article = $article[0];

			$this->view->addData("article", array(
					"id" => $article["id"],
					"" => $article["text"],
					"name" => $article["name"]
				)
			);
			echo $this->view->toString();
		}

		protected function language($matches) {
			$language = HTTP::value("language", "post", "");
			if ($language) { setcookie("language", $language); }
			HTTP::redirectBack();
		}
		
	}
?>
