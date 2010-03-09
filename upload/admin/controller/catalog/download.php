<?php  
class ControllerCatalogDownload extends Controller {  
	private $error = array();
   
  	public function index() {
		$this->load->language('catalog/download');

    	$this->document->title = $this->language->get('heading_title');
	
		$this->load->model('catalog/download');
		
    	$this->getList();
  	}
  	        
  	public function insert() {
		$this->load->language('catalog/download');
    
    	$this->document->title = $this->language->get('heading_title');
		
		$this->load->model('catalog/download');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$data = array();
			
			if (is_uploaded_file($this->request->files['download']['tmp_name'])) {
				$filename = $this->request->files['download']['name'] . '.' . md5(rand());
				
				move_uploaded_file($this->request->files['download']['tmp_name'], DIR_DOWNLOAD . $filename);

				if (file_exists(DIR_DOWNLOAD . $filename)) {
					$data['download'] = $filename;
					$data['mask'] = $this->request->files['download']['name'];
				}
			}

			$this->model_catalog_download->addDownload(array_merge($this->request->post, $data));
   	  		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->https('catalog/download' . $url));
		}
	
    	$this->getForm();
  	}

  	public function update() {
		$this->load->language('catalog/download');

    	$this->document->title = $this->language->get('heading_title');
		
		$this->load->model('catalog/download');
			
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$data = array();
			
			if (is_uploaded_file($this->request->files['download']['tmp_name'])) {
				$filename = $this->request->files['download']['name'] . '.' . md5(rand());
				
				move_uploaded_file($this->request->files['download']['tmp_name'], DIR_DOWNLOAD . $filename);

				if (file_exists(DIR_DOWNLOAD . $filename)) {
					$data['download'] = $filename;
					$data['mask'] = $this->request->files['download']['name'];
				}
			}
			
			$this->model_catalog_download->editDownload($this->request->get['download_id'], array_merge($this->request->post, $data));
	  		
			$this->session->data['success'] = $this->language->get('text_success');
	      
			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->https('catalog/download' . $url));
		}
		
    	$this->getForm();
  	}

  	public function delete() {
		$this->load->language('catalog/download');
 
    	$this->document->title = $this->language->get('heading_title');
		
		$this->load->model('catalog/download');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {	  
			foreach ($this->request->post['selected'] as $download_id) {
				$this->model_catalog_download->deleteDownload($download_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->https('catalog/download' . $url));
    	}

    	$this->getList();
  	}
    
  	private function getList() {
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'dd.name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		$url = '';
			
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

  		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('common/home'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('catalog/download' . $url),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->https('catalog/download/insert' . $url);
		$this->data['delete'] = $this->url->https('catalog/download/delete' . $url);	

		$this->data['downloads'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * 10,
			'limit' => 10
		);
		
		$download_total = $this->model_catalog_download->getTotalDownloads();
	
		$results = $this->model_catalog_download->getDownloads($data);
 
    	foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->https('catalog/download/update&download_id=' . $result['download_id'] . $url)
			);
						
			$this->data['downloads'][] = array(
				'download_id' => $result['download_id'],
				'name'        => $result['name'],
				'remaining'   => $result['remaining'],
				'selected'    => isset($this->request->post['selected']) && in_array($result['download_id'], $this->request->post['selected']),
				'action'      => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_remaining'] = $this->language->get('column_remaining');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=' .  'DESC';
		} else {
			$url .= '&order=' .  'ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->https('catalog/download&sort=dd.name' . $url);
		$this->data['sort_remaining'] = $this->url->https('catalog/download&sort=d.remaining' . $url);
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $download_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->https('catalog/download' . $url . '&page=%s');

		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'catalog/download_list.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
  	}
  
  	private function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');
   
    	$this->data['entry_name'] = $this->language->get('entry_name');
    	$this->data['entry_filename'] = $this->language->get('entry_filename');
    	$this->data['entry_remaining'] = $this->language->get('entry_remaining');
  
    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
  
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}
		
  		if (isset($this->error['download'])) {
			$this->data['error_download'] = $this->error['download'];
		} else {
			$this->data['error_download'] = '';
		}

  		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('common/home'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('catalog/download'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
		$url = '';
			
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
							
		if (!isset($this->request->get['download_id'])) {
			$this->data['action'] = $this->url->https('catalog/download/insert' . $url);
		} else {
			$this->data['action'] = $this->url->https('catalog/download/update&download_id=' . $this->request->get['download_id'] . $url);
		}
		
		$this->data['cancel'] = $this->url->https('catalog/download' . $url);
 		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

    	if (isset($this->request->get['download_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$download_info = $this->model_catalog_download->getDownload($this->request->get['download_id']);
    	}

		if (isset($this->request->post['download_description'])) {
			$this->data['download_description'] = $this->request->post['download_description'];
		} elseif (isset($this->request->get['download_id'])) {
			$this->data['download_description'] = $this->model_catalog_download->getDownloadDescriptions($this->request->get['download_id']);
		} else {
			$this->data['download_description'] = array();
		}   	
		
		if (isset($this->request->post['remaining'])) {
      		$this->data['remaining'] = $this->request->post['remaining'];
    	} elseif (isset($download_info['remaining'])) {
      		$this->data['remaining'] = $download_info['remaining'];
    	} else {
      		$this->data['remaining'] = 0;
    	}
		
		$this->template = 'catalog/download_form.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));	
  	}

  	private function validateForm() { 
    	if (!$this->user->hasPermission('modify', 'catalog/download')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
	
    	foreach ($this->request->post['download_description'] as $language_id => $value) {
      		if ((strlen(utf8_decode($value['name'])) < 3) || (strlen(utf8_decode($value['name'])) > 64)) {
        		$this->error['name'][$language_id] = $this->language->get('error_name');
      		}
    	}	

		if ($this->request->files['download']['name']) {
			if ((strlen(utf8_decode($this->request->files['download']['name'])) < 3) || (strlen(utf8_decode($this->request->files['download']['name'])) > 128)) {
        		$this->error['download'] = $this->language->get('error_filename');
	  		}	  	
			
			if (substr(strrchr($this->request->files['download']['name'], '.'), 1) == 'php') {
       	   		$this->error['download'] = $this->language->get('error_filetype');
       		}	
						
			if ($this->request->files['download']['error'] != UPLOAD_ERR_OK) {
				$this->error['warning'] = $this->language->get('error_upload_' . $this->request->files['download']['error']);
			}
		}
		
		if (!$this->error) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
  	}

  	private function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'catalog/download')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}	
		
		$this->load->model('catalog/product');

		foreach ($this->request->post['selected'] as $download_id) {
  			$product_total = $this->model_catalog_product->getTotalProductsByDownloadId($download_id);
    
			if ($product_total) {
	  			$this->error['warning'] = sprintf($this->language->get('error_product'), $product_total);	
			}	
		}	
			  	  	 
		if (!$this->error) {
	  		return TRUE;
		} else {
	  		return FALSE;
		} 
  	}
}
?>