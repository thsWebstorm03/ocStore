<?php   
class ControllerCommonHeader extends Controller {
	protected function index() {
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && isset($this->request->post['language_code'])) {
			$this->session->data['language'] = $this->request->post['language_code'];
		
			if (isset($this->request->post['redirect'])) {
				$this->redirect($this->request->post['redirect']);
			} else {
				$this->redirect($this->url->http('common/home'));
			}
    	}		
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && isset($this->request->post['currency_code'])) {
      		$this->currency->set($this->request->post['currency_code']);

			if (isset($this->request->post['redirect'])) {
				$this->redirect($this->request->post['redirect']);
			} else {
				$this->redirect($this->url->http('common/home'));
			}
   		}
		
		$this->language->load('common/header');
		
		$this->data['title'] = $this->document->title;
		$this->data['description'] = $this->document->description;

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}
		
		$this->data['charset'] = $this->language->get('charset');
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['links'] = $this->document->links;	
		$this->data['styles'] = $this->document->styles;
		$this->data['scripts'] = $this->document->scripts;		
		$this->data['breadcrumbs'] = $this->document->breadcrumbs;
		$this->data['icon'] = $this->config->get('config_icon');
		
		$this->data['store'] = $this->config->get('config_store');
		
		if (isset($this->request->server['HTTPS']) && ($this->request->server['HTTPS'] == 'on')) {
			$this->data['logo'] = HTTPS_IMAGE . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = HTTP_IMAGE . $this->config->get('config_logo');
		}
		
		$this->data['text_home'] = $this->language->get('text_home');
		$this->data['text_special'] = $this->language->get('text_special');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_sitemap'] = $this->language->get('text_sitemap');
    	$this->data['text_account'] = $this->language->get('text_account');
    	$this->data['text_login'] = $this->language->get('text_login');
    	$this->data['text_logout'] = $this->language->get('text_logout');
    	$this->data['text_cart'] = $this->language->get('text_cart'); 
    	$this->data['text_checkout'] = $this->language->get('text_checkout');
		$this->data['text_checkout'] = $this->language->get('text_checkout');
		$this->data['text_keyword'] = $this->language->get('text_keyword');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_advanced'] = $this->language->get('text_advanced');

		$this->data['entry_search'] = $this->language->get('entry_search');
		
		$this->data['button_go'] = $this->language->get('button_go');

		$this->data['home'] = $this->url->http('common/home');
		$this->data['special'] = $this->url->http('product/special');
		$this->data['contact'] = $this->url->http('information/contact');
    	$this->data['sitemap'] = $this->url->http('information/sitemap');
    	$this->data['account'] = $this->url->https('account/account');
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['login'] = $this->url->https('account/login');
		$this->data['logout'] = $this->url->http('account/logout');
    	$this->data['cart'] = $this->url->http('checkout/cart');
		$this->data['checkout'] = $this->url->https('checkout/shipping');
		
		if (isset($this->request->get['keyword'])) {
			$this->data['keyword'] = $this->request->get['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		
		if (isset($this->request->get['category_id'])) {
			$this->data['category_id'] = $this->request->get['category_id'];
		} elseif (isset($this->request->get['path'])) {
			$path = explode('_', $this->request->get['path']);
		
			$this->data['category_id'] = end($path);
		} else {
			$this->data['category_id'] = '';
		}
		
		$this->data['advanced'] = $this->url->http('product/search');
		
		$this->load->model('catalog/category');
		
		$this->data['categories'] = $this->getCategories(0);
		
		$this->data['action'] = $this->url->http('common/home');

		if (!isset($this->request->get['route'])) {
			$this->data['redirect'] = $this->url->http('common/home');
		} else {
			$this->load->model('tool/seo_url');
			
			$data = $this->request->get;
			
			unset($data['_route_']);
			
			$route = $data['route'];
			
			unset($data['route']);
			
			$url = '';
			
			if ($data) {
				$url = '&' . urldecode(http_build_query($data));
			}			
			
			$this->data['redirect'] = $this->model_tool_seo_url->rewrite($this->url->http($route . $url));
		}
		
		$this->data['language_code'] = $this->session->data['language'];	
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = array();
		
		$results = $this->model_localisation_language->getLanguages();
		
		foreach ($results as $result) {
			if ($result['status']) {
				$this->data['languages'][] = array(
					'name'  => $result['name'],
					'code'  => $result['code'],
					'image' => $result['image']
				);	
			}
		}
		
		$this->data['currency_code'] = $this->currency->getCode(); 
		
		$this->load->model('localisation/currency');
		 
		 $this->data['currencies'] = array();
		 
		$results = $this->model_localisation_currency->getCurrencies();	
		
		foreach ($results as $result) {
			if ($result['status']) {
   				$this->data['currencies'][] = array(
					'title' => $result['title'],
					'code'  => $result['code']
				);
			}
		}
		
		$this->id = 'header';
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/header.tpl';
		} else {
			$this->template = 'default/template/common/header.tpl';
		}
		
    	$this->render();
	}	
	
	private function getCategories($parent_id, $level = 0) {
		$level++;
		
		$data = array();
		
		$results = $this->model_catalog_category->getCategories($parent_id);
		
		foreach ($results as $result) {
			$data[] = array(
				'category_id' => $result['category_id'],
				'name'        => str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $level) . $result['name']
			);
			
			$children = $this->getCategories($result['category_id'], $level);
			
			if ($children) {
			  $data = array_merge($data, $children);
			}
		}
		
		return $data;
	}
}
?>