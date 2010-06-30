<?php
	class M {
		protected $db = null;
		
		public function __construct($dsn, $username = "", $password = "") {
			$this->db = new PDO($dsn, $username, $password);
			$this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  		}
		
		public function query($query, $values = array()) {
			$s = $this->db->prepare($query);
			$s->execute($values);
			$s->setFetchMode(PDO::FETCH_ASSOC);
			return $s->fetchAll();
		}
	}
	
	class V {
		protected $template = null;
		protected $language = null;
		protected $xml = null;
		protected $fractions = null;

		const FRACTIONS = 1;
		const NBSP		= 2;
		const TYPO		= 4;
		
		protected static $_fractions = array(
			"1/2" => "½",
			"1/4" => "¼",
			"3/4" => "¾",
			"1/3" => "⅓",
			"2/3" => "⅔",
			"1/5" => "⅕",
			"2/5" => "⅖",
			"3/5" => "⅗",
			"4/5" => "⅘",
			"1/6" => "⅙",
			"5/6" => "⅚",
			"1/8" => "⅛",
			"3/8" => "⅜",
			"5/8" => "⅝",
			"7/8" => "⅞"
		);
		
		protected static $typo = array(
			"<->" => "↔",
			"->" => "→",
			"<-" => "←",
			"<=>" => "⇔",
			"=>" => "⇒",
			"<=" => "⇐",
			">>" => "»",
			"<<" => "«",
			"---" => "—",
			"--" => "–",
			"(c)" => "©",
			"(C)" => "©",
			"(tm)" => "™",
			"(TM)" => "™",
			"(r)" => "®",
			"(R)" => "®",
			"..." => "…"
		);
		
		public function __construct() {
			$this->xml = new DOMDocument();
			foreach (self::$_fractions as $name=>$value) {
				$newname = "@(?<=\\s|^)".$name."(?=\\s|$)@";
				$this->fractions[$newname] = $value;
			}
		}
		
		public function translate($what, $mode) {
			$str = $what;
			if ($mode & self::NBSP) { 
				$str = preg_replace("/(?<=\s)([A-Z]) (?=\S)/i", "$1".html_entity_decode("&nbsp;", ENT_QUOTES, "utf-8"), $str);
			}
			if ($mode & self::FRACTIONS) {
				$str = preg_replace(array_keys($this->fractions), array_values($this->fractions), $str);
			}
			if ($mode & self::TYPO) {
				$str = str_replace(array_keys(self::$typo), array_values(self::$typo), $str);
				$str = preg_replace("/(?<=\d)x(?=\d)/i", "×", $str);
			}
			return $str;
		}

		public function setTemplate($template) {
			$this->template = $template;
		}
		
		public function setLanguage($language) {
			$this->language = $language;
		}
		
		public function setData($data) {
			$this->xml->appendChild($this->arrayToNode($data));
		}
		
		public function output() {
			$xsl = new DOMDocument();
			$xsl->load($this->template, LIBXML_NOCDATA);
			$xslt = new XSLTProcessor();
			$xslt->importStylesheet($xsl);
			if ($this->language) { $xslt->setParameter("", "language", $this->language); }
			return $xslt->transformToXML($this->xml); 
		}
		
		protected function arrayToNode($array, $nodeName = null) {
			$node = ($nodeName === null ? $this->xml->createDocumentFragment() : $this->xml->createElement($nodeName));
			foreach ($array as $name=>$value) {
				if ($name === "") {
					$node->appendChild($this->xml->createCDATASection($value));
				} else if (is_array($value)) {
					if (is_numeric($name)) { $name = "item"; }
					$node->appendChild($this->arrayToNode($value, $name));
				} else {
					$node->setAttribute($name, $value);
				}
			}
			return $node;
		}
	}
	
	class C {
		protected $input = null;
		protected $output = null;
	
		/**
		 * @param {M_Base} input
		 * @param {V_Base} output
		 */
		public function __construct($input, $output) {
			$this->input = $input;
			$this->output = $output;
			$this->dispatch();
		}
		
		public function dispatch() {
			echo $this->output->output();
		}
	}
?>

