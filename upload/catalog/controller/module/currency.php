<?php  
class ControllerModuleCurrency extends Controller {
	public function index() {
		if (isset($this->request->post['currency_code'])) {
      		$this->currency->set($this->request->post['currency_code']);
			
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			
			if (isset($this->request->post['redirect'])) {
				$this->response->redirect($this->request->post['redirect']);
			} else {
				$this->response->redirect($this->url->link('common/home'));
			}
   		}
		
		$this->load->language('module/currency');
		
    	$data['text_currency'] = $this->language->get('text_currency');

		if ($this->request->server['HTTPS']) {
			$connection = 'SSL';
		} else {
			$connection = 'NONSSL';
		}
		
		$data['action'] = $this->url->link('module/currency', '', $connection);
		
		$data['currency_code'] = $this->currency->getCode(); 
		
		$this->load->model('localisation/currency');
		 
		 $data['currencies'] = array();
		 
		$results = $this->model_localisation_currency->getCurrencies();	
		
		foreach ($results as $result) {
			if ($result['status']) {
   				$data['currencies'][] = array(
					'title'        => $result['title'],
					'code'         => $result['code'],
					'symbol_left'  => $result['symbol_left'],
					'symbol_right' => $result['symbol_right']				
				);
			}
		}
		
		if (!isset($this->request->get['route'])) {
			$data['redirect'] = $this->url->link('common/home');
		} else {
			$url_data = $this->request->get;
			
			unset($url_data['_route_']);
			
			$route = $url_data['route'];
			
			unset($url_data['route']);
			
			$url = '';
			
			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}	
						
			$data['redirect'] = $this->url->link($route, $url, $connection);
		}	
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/currency.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/currency.tpl', $data);
		} else {
			return $this->load->view('default/template/module/currency.tpl', $data);
		}
	}
}