<?php  
class ControllerSaleVoucher extends Controller {
	private $error = array();
     
  	public function index() {
		$this->load->language('sale/voucher');
    	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/voucher');
		
		$this->getList();
  	}
  
  	public function insert() {
    	$this->load->language('sale/voucher');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/voucher');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_voucher->addVoucher($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getForm();
  	}

  	public function update() {
    	$this->load->language('sale/voucher');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/voucher');
				
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_voucher->editVoucher($this->request->get['voucher_id'], $this->request->post);
      		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}

  	public function delete() {
    	$this->load->language('sale/voucher');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/voucher');
		
    	if (isset($this->request->post['selected']) && $this->validateDelete()) { 
			foreach ($this->request->post['selected'] as $voucher_id) {
				$this->model_sale_voucher->deleteVoucher($voucher_id);
			}
      		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getList();
  	}

  	private function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'v.date_added';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
				
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('sale/voucher/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('sale/voucher/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$this->data['vouchers'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$voucher_total = $this->model_sale_voucher->getTotalVouchers();
	
		$results = $this->model_sale_voucher->getVouchers($data);
 
    	foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('sale/voucher/update', 'token=' . $this->session->data['token'] . '&voucher_id=' . $result['voucher_id'] . $url, 'SSL')
			);
						
			$this->data['vouchers'][] = array(
				'voucher_id'    => $result['voucher_id'],
				'code'          => $result['code'],
				'from'          => $result['from_name'],
				'to'            => $result['to_name'],
				'amount'        => $result['amount'],
				'status'        => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'date_added'    => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'date_redeemed' => date($this->language->get('date_format_short'), strtotime($result['date_redeemed'])),
				'selected'      => isset($this->request->post['selected']) && in_array($result['voucher_id'], $this->request->post['selected']),
				'action'        => $action
			);
		}
									
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_code'] = $this->language->get('column_code');
		$this->data['column_from'] = $this->language->get('column_from');
		$this->data['column_to'] = $this->language->get('column_to');
		$this->data['column_amount'] = $this->language->get('column_amount');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_date_redeemed'] = $this->language->get('column_date_redeemed');
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
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_code'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.code' . $url, 'SSL');
		$this->data['sort_from'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.from_name' . $url, 'SSL');
		$this->data['sort_to'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.to_name' . $url, 'SSL');
		$this->data['sort_amount'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.amount' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.date_end' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.date_added' . $url, 'SSL');
		$this->data['sort_date_redeemed'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . '&sort=v.date_redeemed' . $url, 'SSL');
				
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $voucher_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'sale/voucher_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
  	}

  	private function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		
    	$this->data['entry_code'] = $this->language->get('entry_code');
		$this->data['entry_from_name'] = $this->language->get('entry_from_name');
		$this->data['entry_from_email'] = $this->language->get('entry_from_email');
		$this->data['entry_to_name'] = $this->language->get('entry_to_name');
		$this->data['entry_to_email'] = $this->language->get('entry_to_email');
		$this->data['entry_message'] = $this->language->get('entry_message');
		$this->data['entry_amount'] = $this->language->get('entry_amount');
		$this->data['entry_status'] = $this->language->get('entry_status');

    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['code'])) {
			$this->data['error_code'] = $this->error['code'];
		} else {
			$this->data['error_code'] = '';
		}		
		
		if (isset($this->error['from_name'])) {
			$this->data['error_from_name'] = $this->error['from_name'];
		} else {
			$this->data['error_from_name'] = '';
		}	
		
		if (isset($this->error['from_email'])) {
			$this->data['error_from_email'] = $this->error['from_email'];
		} else {
			$this->data['error_from_email'] = '';
		}	
		
		if (isset($this->error['to_name'])) {
			$this->data['error_to_name'] = $this->error['to_name'];
		} else {
			$this->data['error_to_name'] = '';
		}	
		
		if (isset($this->error['to_email'])) {
			$this->data['error_to_email'] = $this->error['to_email'];
		} else {
			$this->data['error_to_email'] = '';
		}	
		
		if (isset($this->error['amount'])) {
			$this->data['error_amount'] = $this->error['amount'];
		} else {
			$this->data['error_amount'] = '';
		}
				
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
									
		if (!isset($this->request->get['voucher_id'])) {
			$this->data['action'] = $this->url->link('sale/voucher/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('sale/voucher/update', 'token=' . $this->session->data['token'] . '&voucher_id=' . $this->request->get['voucher_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'] . $url, 'SSL');
  		
		if (isset($this->request->get['voucher_id']) && (!$this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$voucher_info = $this->model_sale_voucher->getVoucher($this->request->get['voucher_id']);
    	}

    	if (isset($this->request->post['code'])) {
      		$this->data['code'] = $this->request->post['code'];
    	} elseif (isset($voucher_info)) {
			$this->data['code'] = $voucher_info['code'];
		} else {
      		$this->data['code'] = '';
    	}
		
    	if (isset($this->request->post['from_name'])) {
      		$this->data['from_name'] = $this->request->post['from_name'];
    	} elseif (isset($voucher_info)) {
			$this->data['from_name'] = $voucher_info['from_name'];
		} else {
      		$this->data['from_name'] = '';
    	}
		
    	if (isset($this->request->post['from_email'])) {
      		$this->data['from_email'] = $this->request->post['from_email'];
    	} elseif (isset($voucher_info)) {
			$this->data['from_email'] = $voucher_info['from_email'];
		} else {
      		$this->data['from_email'] = '';
    	}

    	if (isset($this->request->post['to_name'])) {
      		$this->data['to_name'] = $this->request->post['to_name'];
    	} elseif (isset($voucher_info)) {
			$this->data['to_name'] = $voucher_info['to_name'];
		} else {
      		$this->data['to_name'] = '';
    	}
		
    	if (isset($this->request->post['to_email'])) {
      		$this->data['to_email'] = $this->request->post['to_email'];
    	} elseif (isset($voucher_info)) {
			$this->data['to_email'] = $voucher_info['to_email'];
		} else {
      		$this->data['to_email'] = '';
    	}

    	if (isset($this->request->post['message'])) {
      		$this->data['message'] = $this->request->post['message'];
    	} elseif (isset($voucher_info)) {
			$this->data['message'] = $voucher_info['message'];
		} else {
      		$this->data['message'] = '';
    	}
		
    	if (isset($this->request->post['amount'])) {
      		$this->data['amount'] = $this->request->post['amount'];
    	} elseif (isset($voucher_info)) {
			$this->data['amount'] = $voucher_info['amount'];
		} else {
      		$this->data['amount'] = '';
    	}
 
    	if (isset($this->request->post['status'])) { 
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (isset($voucher_info)) {
			$this->data['status'] = $voucher_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}

		$this->template = 'sale/voucher_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());		
  	}
	
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'sale/voucher')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
    	if ((strlen(utf8_decode($this->request->post['code'])) < 3) || (strlen(utf8_decode($this->request->post['code'])) > 10)) {
      		$this->error['code'] = $this->language->get('error_code');
    	}
			      
    	if ((strlen(utf8_decode($this->request->post['to_name'])) < 1) || (strlen(utf8_decode($this->request->post['to_name'])) > 64)) {
      		$this->error['to_name'] = $this->language->get('error_to_name');
    	}    	
		
		if ((strlen($this->request->post['to_email']) > 96) || !filter_var($this->request->post['to_email'], FILTER_VALIDATE_EMAIL)) {
      		$this->error['to_email'] = $this->language->get('error_email');
    	}
		
    	if ((strlen(utf8_decode($this->request->post['from_name'])) < 1) || (strlen(utf8_decode($this->request->post['from_name'])) > 64)) {
      		$this->error['from_name'] = $this->language->get('error_from_name');
    	}  
		
		if ((strlen(utf8_decode($this->request->post['from_email'])) > 96) || !filter_var($this->request->post['from_email'], FILTER_VALIDATE_EMAIL)) {
      		$this->error['from_email'] = $this->language->get('error_email');
    	}
		
		if ($this->request->post['amount'] < 1) {
      		$this->error['amount'] = $this->language->get('error_amount');
    	}

    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}
  	}

  	private function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'sale/voucher')) {
      		$this->error['warning'] = $this->language->get('error_permission');  
    	}
	  	
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}		
}
?>