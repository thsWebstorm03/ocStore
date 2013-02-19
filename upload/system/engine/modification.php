<?php
final class Modification {
	private $data = array();
	private $error = array();
	
	public function call($file) {
		if (isset($this->data[$file])) {
			$content = $this->data[$file];
		} else {
			if (file_exists($file)) { 
				$content = file_get_contents($file);
			} else {
				trigger_error('Error: Could not load modification ' . $file . '!');
				exit();
			}
		}
		
		if ($content) {
			return eval($content);
		}
	}
	
	public function load($file) {
		if (file_exists($file)) { 
			$xml = file_get_contents($file);
			
			$this->parse($xml);
		} else {
			trigger_error('Error: Could not load modification ' . $file . '!');
			exit();
		}
	}
	
	public function parse($xml) {
		$dom = new DOMDocument('1.0', 'UTF-8');
		$dom->loadXml($xml);
		
		$files = $dom->getElementsByTagName('modification')->item(0)->getElementsByTagName('file');		
		
		foreach ($files as $file) {
			if (!isset($this->data[$file->getAttribute('name')])) {
				if (file_exists($file->getAttribute('name'))) {
					$this->data[$file->getAttribute('name')] = file_get_contents($file->getAttribute('name'));
					
					$handle = fopen($this->file, 'rb');
					
					while (!feof($handle)) {
						$buffer = fgets($handle);
						$data = $this->applyFilters($this->format_line($buffer));
						
						if($data) {
							$lines[] = $data;
						}
		 
						if($limit && $count == $limit)
						{
							break;
						}
						
					$count++;
				}
			
		    fclose($handle);
			
			
			
			
								
				} else {
					exit();	
				}			
			}

			$content = $this->data[$file->getAttribute('name')];

			//log|skip|abort = $file->getAttribute('error');

			$operations = $file->getElementsByTagName('operation');
					
			foreach ($operations as $operation) {
				//log|skip|abort = $operation->getAttribute('error');
				
				if ($operation->getElementsByTagName('ignoreif')->length) {

					if (strpos($content, $operation->getElementsByTagName('ignoreif')->item(0)->nodeValue) !== false) {
						continue;
					}

				}
				
				$index = 0;
			
				$lines = explode("\n", $content);
	
				$search = $operation->getElementsByTagName('search')->item(0)->nodeValue;
				
				$position = $operation->getElementsByTagName('search')->item(0)->getAttribute('position');
				$offset = $operation->getElementsByTagName('search')->item(0)->getAttribute('offset');
				$index = $operation->getElementsByTagName('search')->item(0)->getAttribute('index');
				$regex = $operation->getElementsByTagName('search')->item(0)->getAttribute('regex');
				$trim = $operation->getElementsByTagName('search')->item(0)->getAttribute('trim');
				
				/*
				search
				replace
				offset 
				limit
				*/
				
				if (!$offset) {
					$offset = 1;
				}
				
				
				/*
				 
				foreach ($lines as $line) {
					$pos = strpos($content, $operation->getElementsByTagName('search')->item(0)->nodeValue);
					
					if ($pos !== false) {
						$position == 'after'
						
						($pos + $offset)
						
						break;
					}
				}
				 
				$add = $operation->getElementsByTagName('add')->item(0)->nodeValue;
				 
				 
				switch($position) {
					case 'top':
						$line[$mod['search']['offset']] = $mod['add']->getContent() . $tmp[$mod['search']->offset];
						break;
					case 'bottom':
						$offset = (count($line) - 1) - $mod['search']->offset;
						
						if($offset < 0){
							$line[-1] = $mod['add']->getContent();
						} else {
							$line[$offset] .= $mod['add']->getContent();
						}						
						break;
					case 'all':
						$tmp = array($mod['add']->getContent());
						break;							
					case 'before':
						$offset = ($lineNum - $mod['search']->offset < 0) ? -1 : $lineNum - $mod['search']->offset;
						
						$tmp[$offset] = empty($tmp[$offset]) ? $mod['add']->getContent() : $mod['add']->getContent() . "\n" . $tmp[$offset];
						break;
					case 'after':
								$offset = ($lineNum + $mod['search']->offset > $lineMax) ? $lineMax : $lineNum + $mod['search']->offset;
								$tmp[$offset] = $tmp[$offset] . "\n" . $mod['add']->getContent();
					
						break;
					case 'replace':
					
						break;


				}
				
				$line = implode("\n", $content);
				
				/*
				$changed = false;
				foreach($tmp as $lineNum => $line) {
					if(strlen($mod['search']->getContent()) == 0) {
						if($mod['error'] == 'log' || $mod['error'] == 'abort') {
							$this->_vqmod->log->write('EMPTY SEARCH CONTENT ERROR', $this);
						}
						break;
					}
					
					if($mod['search']->regex == 'true') {
						$pos = @preg_match($mod['search']->getContent(), $line);
						if($pos === false) {
							if($mod['error'] == 'log' || $mod['error'] == 'abort' ) {
								$this->_vqmod->log->write('INVALID REGEX ERROR - ' . $mod['search']->getContent(), $this);
							}
							continue 2;
						} elseif($pos == 0) {
							$pos = false;
						}
					} else {
						$pos = strpos($line, $mod['search']->getContent());
					}

					if($pos !== false) {
						$indexCount++;
						$changed = true;

						if(!$mod['search']->indexes() || ($mod['search']->indexes() && in_array($indexCount, $mod['search']->indexes()))) {

							switch($mod['search']->position) {
								case 'before':
								$offset = ($lineNum - $mod['search']->offset < 0) ? -1 : $lineNum - $mod['search']->offset;
								$tmp[$offset] = empty($tmp[$offset]) ? $mod['add']->getContent() : $mod['add']->getContent() . "\n" . $tmp[$offset];
								break;

								case 'after':
								$offset = ($lineNum + $mod['search']->offset > $lineMax) ? $lineMax : $lineNum + $mod['search']->offset;
								$tmp[$offset] = $tmp[$offset] . "\n" . $mod['add']->getContent();
								break;

								default:
								if(!empty($mod['search']->offset)) {
									for($i = 1; $i <= $mod['search']->offset; $i++) {
										if(isset($tmp[$lineNum + $i])) {
											$tmp[$lineNum + $i] = '';
										}
									}
								}

								if($mod['search']->regex == 'true') {
									$tmp[$lineNum] = preg_replace($mod['search']->getContent(), $mod['add']->getContent(), $line);
								} else {
									$tmp[$lineNum] = str_replace($mod['search']->getContent(), $mod['add']->getContent(), $line);
								}
								break;
							}
						}
					}
				}
				*/
				
				
			}
		}
		
		
				
		echo '<pre>';
		print_r($this->data);
		echo '</pre>';
	}
}
?>