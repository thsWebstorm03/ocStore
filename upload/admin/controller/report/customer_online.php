<?php  
class ControllerReportCustomerOnline extends Controller {  
  	public function index() {
		$this->language->load('report/customer_online');
		
    	$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->request->get['filter_ip'])) {
			$filter_ip = $this->request->get['filter_ip'];
		} else {
			$filter_ip = NULL;
		}
		
		if (isset($this->request->get['filter_customer'])) {
			$filter_customer = $this->request->get['filter_customer'];
		} else {
			$filter_customer = NULL;
		}
						
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
																		
		$url = '';
		
		if (isset($this->request->get['filter_customer'])) {
			$url .= '&filter_customer=' . urlencode($this->request->get['filter_customer']);
		}
		
		if (isset($this->request->get['filter_ip'])) {
			$url .= '&filter_ip=' . $this->request->get['filter_ip'];
		}
						
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
						
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
       		'text' => $this->language->get('text_home')
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href' => $this->url->link('report/customer_online', 'token=' . $this->session->data['token'] . $url, 'SSL'),
       		'text' => $this->language->get('heading_title')
   		);
		
		$this->load->model('report/customer');
    	$this->load->model('sale/customer');
		
		$this->data['customers'] = array();

		$data = array(
			'filter_ip'       => $filter_ip, 
			'filter_customer' => $filter_customer, 
			'start'           => ($page - 1) * 20,
			'limit'           => 20
		);
		
		$customer_total = $this->model_report_customer->getTotalCustomersOnline($data);
		
		$results = $this->model_report_customer->getCustomersOnline($data);
    	
		foreach ($results as $result) {
			$customer_info = $this->model_sale_customer->getCustomer($result['customer_id']);
					
			if ($customer_info) {
				$customer = $customer_info['firstname'] . ' ' . $customer_info['lastname'];
			} else {
				$customer = $this->language->get('text_guest');
			}
								
      		$this->data['customers'][] = array(
				'customer_id' => $result['customer_id'],
				'ip'          => $result['ip'],
				'customer'    => $customer,
				'url'         => $result['url'],
				'referer'     => $result['referer'],
				'date_added'  => date('d/m/Y H:i:s', strtotime($result['date_added'])),
				'edit'        => $this->url->link('sale/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'], 'SSL')
			);
		}	
		
 		$this->data['heading_title'] = $this->language->get('heading_title');
		 
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		
		$this->data['column_ip'] = $this->language->get('column_ip');
		$this->data['column_customer'] = $this->language->get('column_customer');
		$this->data['column_url'] = $this->language->get('column_url');
		$this->data['column_referer'] = $this->language->get('column_referer');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');
	
		$this->data['entry_ip'] = $this->language->get('entry_ip');
		$this->data['entry_customer'] = $this->language->get('entry_customer');
				
		$this->data['button_edit'] = $this->language->get('button_edit');
		$this->data['button_filter'] = $this->language->get('button_filter');
				
		$this->data['token'] = $this->session->data['token'];
		
		$url = '';
		
		if (isset($this->request->get['filter_customer'])) {
			$url .= '&filter_customer=' . urlencode($this->request->get['filter_customer']);
		}
		
		if (isset($this->request->get['filter_ip'])) {
			$url .= '&filter_ip=' . $this->request->get['filter_ip'];
		}
				
		$pagination = new Pagination();
		$pagination->total = $customer_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->url = $this->url->link('report/customer_online', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
	
		$this->data['results'] = sprintf($this->language->get('text_pagination'), ($customer_total) ? (($page - 1) * $this->config->get('config_admin_limit')) + 1 : 0, ((($page - 1) * $this->config->get('config_admin_limit')) > ($customer_total - $this->config->get('config_admin_limit'))) ? $customer_total : ((($page - 1) * $this->config->get('config_admin_limit')) + $this->config->get('config_admin_limit')), $customer_total, ceil($customer_total / $this->config->get('config_admin_limit')));
		
		$this->data['filter_customer'] = $filter_customer;
		$this->data['filter_ip'] = $filter_ip;		
				
		$this->template = 'report/customer_online.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render());
  	}
}
?>
