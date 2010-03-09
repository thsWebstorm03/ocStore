<?php   
class ControllerCommonHome extends Controller {   
	public function index() {
    	$this->load->language('common/home');
	 
		$this->document->title = $this->language->get('heading_title');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_overview'] = $this->language->get('text_overview');
		$this->data['text_statistics'] = $this->language->get('text_statistics');
		$this->data['text_latest_10_orders'] = $this->language->get('text_latest_10_orders');
		$this->data['text_total_sale'] = $this->language->get('text_total_sale');
		$this->data['text_total_sale_year'] = $this->language->get('text_total_sale_year');
		$this->data['text_total_order'] = $this->language->get('text_total_order');
		$this->data['text_total_customer'] = $this->language->get('text_total_customer');
		$this->data['text_total_customer_approval'] = $this->language->get('text_total_customer_approval');
		$this->data['text_total_product'] = $this->language->get('text_total_product');
		$this->data['text_total_review'] = $this->language->get('text_total_review');
		$this->data['text_total_review_approval'] = $this->language->get('text_total_review_approval');
		$this->data['text_day'] = $this->language->get('text_day');
		$this->data['text_week'] = $this->language->get('text_week');
		$this->data['text_month'] = $this->language->get('text_month');
		$this->data['text_year'] = $this->language->get('text_year');
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_order'] = $this->language->get('column_order');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_total'] = $this->language->get('column_total');
		$this->data['column_firstname'] = $this->language->get('column_firstname');
		$this->data['column_lastname'] = $this->language->get('column_lastname');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['entry_range'] = $this->language->get('entry_range');

		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('common/home'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);
		
		$this->load->model('sale/order');

		$this->data['total_sale'] = $this->currency->format($this->model_sale_order->getTotalSales(), $this->config->get('config_currency'));
		$this->data['total_sale_year'] = $this->currency->format($this->model_sale_order->getTotalSalesByYear(date('Y')), $this->config->get('config_currency'));
		$this->data['total_order'] = $this->model_sale_order->getTotalOrders();
		
		$this->load->model('sale/customer');
		
		$this->data['total_customer'] = $this->model_sale_customer->getTotalCustomers();
		$this->data['total_customer_approval'] = $this->model_sale_customer->getTotalCustomersAwatingApproval();
		
		$this->load->model('catalog/product');
		
		$this->data['total_product'] = $this->model_catalog_product->getTotalProducts();
		
		$this->load->model('catalog/review');
		
		$this->data['total_review'] = $this->model_catalog_review->getTotalReviews();
		$this->data['total_review_approval'] = $this->model_catalog_review->getTotalReviewsAwatingApproval();
		
		$this->data['orders'] = array(); 
		
		$data = array(
			'sort'  => 'o.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => 10
		);
		
		$results = $this->model_sale_order->getOrders($data);
    	
    	foreach ($results as $result) {
			$action = array();
			 
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->https('sale/order/update&order_id=' . $result['order_id'])
			);
					
			$this->data['orders'][] = array(
				'order_id'   => $result['order_id'],
				'name'       => $result['name'],
				'status'     => $result['status'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'total'      => $this->currency->format($result['total'], $result['currency'], $result['value']),
				'action'     => $action
			);
		}

		if ($this->config->get('config_currency_auto')) {
			$this->load->model('localisation/currency');
		
			$this->model_localisation_currency->updateCurrencies();
		}
		
		$this->template = 'common/home.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
  	}
	
	public function chart() {
		$this->load->language('common/home');
		
		$data = array();
		
		$data['order'] = array();
		$data['customer'] = array();
		$data['xaxis'] = array();
		
		$data['order']['label'] = $this->language->get('text_order');
		$data['customer']['label'] = $this->language->get('text_customer');
		
		if (isset($this->request->get['range'])) {
			$range = $this->request->get['range'];
		} else {
			$range = 'month';
		}
		
		switch ($range) {
			case 'day':
				for ($i = 0; $i <= 23; $i++) {
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND (DATE(date_added) = DATE(NOW()) AND HOUR(date_added) = '" . (int)$i . "') GROUP BY HOUR(date_added) ORDER BY date_added ASC");
					
					if ($query->num_rows) {
						$data['order']['data'][]  = array(date('G', strtotime('-' . (int)$i . ' hour')), (int)$query->row['total']);
					} else {
						$data['order']['data'][]  = array(date('G', strtotime('-' . (int)$i . ' hour')), 0);
					}
					
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE DATE(date_added) = DATE(NOW()) AND HOUR(date_added) = '" . (int)$i . "' GROUP BY HOUR(date_added) ORDER BY date_added ASC");
					
					if ($query->num_rows) {
						$data['customer']['data'][] = array(date('G', strtotime('-' . (int)$i . ' hour')), (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array(date('G', strtotime('-' . (int)$i . ' hour')), 0);
					}
			
					$data['xaxis'][] = array(date('G', strtotime('-' . (int)$i . ' hour')), date('H', strtotime('-' . (int)$i . ' hour')));
				}					
				break;
			case 'week':
				$week = mktime(0, 0, 0, date('m'), date('d') - date('w'), date('Y'));
			
				for ($i = 0; $i < 7; $i++) {
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND DATE(date_added) = DATE('" . date('Y-m-d', $week + ($i * 86400)) . "') GROUP BY DAY(date_added)");
			
					if ($query->num_rows) {
						$data['order']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), (int)$query->row['total']);
					} else {
						$data['order']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), 0);
					}
				
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE DATE(date_added) = DATE('" . date('Y-m-d', $week + ($i * 86400)) . "') GROUP BY DAY(date_added)");
			
					if ($query->num_rows) {
						$data['customer']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), 0);
					}
					
					$data['xaxis'][] = array(date('d', strtotime('-' . (int)$i . ' day')), date('d/m', strtotime('-' . (int)$i . ' day')));
				}			
				break;
			default:
			case 'month':
				$last_day_of_the_month = mktime(23, 59, 59, date('m'), 0, date('Y')); 
			
				for ($i = 1; $i <= date('j', $last_day_of_the_month); $i++) {
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND (DATE(date_added) = '" . date('Y-m-d', strtotime('-' . (int)$i . ' day')) . "') GROUP BY DAY(date_added)");
					
					if ($query->num_rows) {
						$data['order']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), (int)$query->row['total']);
					} else {
						$data['order']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), 0);
					}	
				
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE DATE(date_added) = '" . date('Y-m-d', strtotime('-' . (int)$i . ' day')) . "' GROUP BY DAY(date_added)");
			
					if ($query->num_rows) {
							$data['customer']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), (int)$query->row['total']);
					} else {
							$data['customer']['data'][] = array(date('d', strtotime('-' . (int)$i . ' day')), 0);
					}	
					
					$data['xaxis'][] = array(date('d', strtotime('-' . (int)$i . ' day')), date('d/m', strtotime('-' . (int)$i . ' day')));
				}
				break;
			case 'year':
				for ($i = 0; $i < date('n'); $i++) {
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND (YEAR(date_added) = '" . date('Y') . "' AND MONTH(date_added) = '" . date('m', strtotime('-' . $i . ' month')) . "') GROUP BY MONTH(date_added)");
					
					if ($query->num_rows) {
						$data['order']['data'][] = array(date('n', strtotime('-' . (int)$i . ' month')), (int)$query->row['total']);
					} else {
						$data['order']['data'][] = array(date('n', strtotime('-' . (int)$i . ' month')), 0);
					}
					
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE YEAR(date_added) = '" . date('Y') . "' AND MONTH(date_added) = '" . date('m', strtotime('-' . $i . ' month')) . "' GROUP BY MONTH(date_added)");
					
					if ($query->num_rows) {
						$data['customer']['data'][] = array(date('n', strtotime('-' . (int)$i . ' month')), (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array(date('n', strtotime('-' . (int)$i . ' month')), 0);
					}
					
					$data['xaxis'][] = array(date('n', strtotime('-' . (int)$i . ' month')), date('m', strtotime('-' . (int)$i . ' month')));
				}			
				break;	
		}
		
		$this->load->library('json');
		
		$this->response->setOutput(Json::encode($data));
	}
	
	public function login() {
		if (!$this->user->isLogged()) {
			return $this->forward('common/login');
		}
	}
	
	public function permission() {
		if (isset($this->request->get['route'])) {
			$route = $this->request->get['route'];
		  
			$part = explode('/', $route);
			
			$ignore = array(
				'common/home',
				'common/login',
				'common/logout',
				'common/filemanager',
				'common/permission',
				'error/error_403',
				'error/error_404'		
			);
			
			if (!in_array(@$part[0] . '/' . @$part[1], $ignore)) {
				if (!$this->user->hasPermission('access', @$part[0] . '/' . @$part[1])) {
					return $this->forward('error/permission');
				}
			}
		}
	}
}
?>