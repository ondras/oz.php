<?php
	class VF_Fractions extends VF {
		protected $fractions = null;

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

		protected function apply($str) {
		}
	}
	
		public function __construct() {
			parent::__construct();
			$this->xml = new DOMDocument();
			foreach (self::$_fractions as $name=>$value) {
				$newname = "@(?<=[^\\d]|^)".$name."(?=[^\\d]|$)@";
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
		
		public function addFilter($filter) {
			$this->filters[] = $filter;
		}
		
		public function output() {
			echo $this->xml->saveXML(); return;
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
				if (is_array($value)) {
					if (is_numeric($name)) { $name = "item"; }
					$node->appendChild($this->arrayToNode($value, $name));
				} else {
					$value = $this->filter($value);
					if ($name === "") {
						$node->appendChild($this->xml->createCDATASection($value));
					} else {
						$node->setAttribute($name, $value);
					}
				}
			}

			return $node;
		}
		
		protected function filter($str) {
			$s = $str;
			for ($i=0;$i<count($this->filters);$i++) {
				$s = $this->filters[$i]->apply($s);
			}
			return $s;
		}
	}
	
	class C {
		protected $input = null;
		protected $output = null;
	
		/**
		 * @param {M} input
		 * @param {V} output
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
	
	class VF {
		public function __construct() {
		}

		public function apply($str) {
			return $str;
		}
	}
?>
