<?php
class ControllerPaymentPayza extends Controller {
	private $error = array(); 

	public function index() {
		$this->language->load('payment/payza');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('payza', $this->request->post);				
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		
		$data['entry_merchant'] = $this->language->get('entry_merchant');
		$data['entry_security'] = $this->language->get('entry_security');
		$data['entry_callback'] = $this->language->get('entry_callback');
		$data['entry_total'] = $this->language->get('entry_total');	
		$data['entry_order_status'] = $this->language->get('entry_order_status');		
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['help_callback'] = $this->language->get('help_callback');
		$data['help_total'] = $this->language->get('help_total');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

  		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

 		if (isset($this->error['merchant'])) {
			$data['error_merchant'] = $this->error['merchant'];
		} else {
			$data['error_merchant'] = '';
		}

 		if (isset($this->error['security'])) {
			$data['error_security'] = $this->error['security'];
		} else {
			$data['error_security'] = '';
		}
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$data['breadcrumbs'][] = array(
       		'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$data['breadcrumbs'][] = array(
       		'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/payza', 'token=' . $this->session->data['token'], 'SSL')
   		);
				
		$data['action'] = $this->url->link('payment/payza', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['payza_merchant'])) {
			$data['payza_merchant'] = $this->request->post['payza_merchant'];
		} else {
			$data['payza_merchant'] = $this->config->get('payza_merchant');
		}

		if (isset($this->request->post['payza_security'])) {
			$data['payza_security'] = $this->request->post['payza_security'];
		} else {
			$data['payza_security'] = $this->config->get('payza_security');
		}
		
		$data['callback'] = HTTP_CATALOG . 'index.php?route=payment/payza/callback';
		
		if (isset($this->request->post['payza_total'])) {
			$data['payza_total'] = $this->request->post['payza_total'];
		} else {
			$data['payza_total'] = $this->config->get('payza_total'); 
		} 
				
		if (isset($this->request->post['payza_order_status_id'])) {
			$data['payza_order_status_id'] = $this->request->post['payza_order_status_id'];
		} else {
			$data['payza_order_status_id'] = $this->config->get('payza_order_status_id'); 
		} 
		
		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['payza_geo_zone_id'])) {
			$data['payza_geo_zone_id'] = $this->request->post['payza_geo_zone_id'];
		} else {
			$data['payza_geo_zone_id'] = $this->config->get('payza_geo_zone_id'); 
		} 

		$this->load->model('localisation/geo_zone');
										
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['payza_status'])) {
			$data['payza_status'] = $this->request->post['payza_status'];
		} else {
			$data['payza_status'] = $this->config->get('payza_status');
		}
		
		if (isset($this->request->post['payza_sort_order'])) {
			$data['payza_sort_order'] = $this->request->post['payza_sort_order'];
		} else {
			$data['payza_sort_order'] = $this->config->get('payza_sort_order');
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('payment/payza.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'payment/payza')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['payza_merchant']) {
			$this->error['merchant'] = $this->language->get('error_merchant');
		}

		if (!$this->request->post['payza_security']) {
			$this->error['security'] = $this->language->get('error_security');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>