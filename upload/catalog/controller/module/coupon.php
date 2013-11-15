<?php
class ControllerModuleCoupon extends Controller {
	public function index() {
		$data = array();
		
		$this->language->load('module/coupon');
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_loading'] = $this->language->get('text_loading');
	
		$data['entry_coupon'] = $this->language->get('entry_coupon');
		
		$data['button_coupon'] = $this->language->get('button_coupon');
		
		$data['status'] = $this->config->get('coupon_status');
		
		if (isset($this->session->data['coupon'])) {
			$data['coupon'] = $this->session->data['coupon'];
		} else {
			$data['coupon'] = '';
		}			
					
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/coupon.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/coupon.tpl', $data);
		} else {
			return $this->load->view('default/template/module/coupon.tpl', $data);
		}	
	}
	
	public function coupon() {
		$this->language->load('module/coupon');
		
		$json = array();
				
		$this->load->model('checkout/coupon');
		
		if (isset($this->request->post['coupon'])) {
			$coupon = $this->request->post['coupon'];
		} else {
			$coupon = '';
		}
						
		$coupon_info = $this->model_checkout_coupon->getCoupon($coupon);			
		
		if ($coupon_info) {			
			$this->session->data['coupon'] = $this->request->post['coupon'];
				
			$this->session->data['success'] = $this->language->get('text_coupon');
			
			$json['redirect'] = $this->url->link('checkout/cart');
		} else {
			$json['error'] = $this->language->get('error_coupon');			
		}
					
		$this->response->setOutput(json_encode($json));	
	}
}
?>