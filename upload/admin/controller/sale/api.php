<?php
class ControllerSaleApi extends Controller {	
	public function insert() {
		$this->load->language('sale/order');
		
		$json = array();
		
		$this->load->model('setting/store');
		
		$store_info = $this->model_setting_store->getStore($this->request->post['store_id']);
		
		if ($store_info) {
			$url = $store_info['url'];
		} else {
			$url = HTTP_CATALOG;
		}
		
		$this->load->model('user/api');
		
		$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));
		
		if ($api_info) {
			$api_data = array(
				'username' => $api_info['username'],
				'password' => $api_info['password']
			);
			
			$response = $this->api($url . 'index.php?route=api/login', '', $api_data);
			
			if (isset($response['error'])) {
				$json['error'] = $response['error'];
			}
		}		
		
		if (isset($response['cookie'])) {
			$cookie = $response['cookie'];

			// Products
			if (isset($this->request->post['order_product'])) {
				foreach ($this->request->post['order_product'] as $order_product) {
					if (isset($order_product['order_option'])) {
						$option = $order_product['order_option'];
					} else {
						$option = array();
					}
								
					$product_data = array(
						'product_id' => $order_product['product_id'],
						'option'     => $option,
						'quantity'   => $order_product['quantity'],
						'override'   => true
					);
	
					$response = $this->api($url . 'index.php?route=api/cart/add', $cookie, $product_data);
					
					if (isset($response['error'])) {
						$json['error']['product'] = $response['error'];
						
						break;	
					}
				}
			}
			
			// Vouchers
			if (isset($this->request->post['order_voucher'])) {
				foreach ($this->request->post['order_voucher'] as $order_voucher) {
					$response = $this->api($url . 'index.php?route=api/voucher/add', $cookie, $order_voucher);
						
					if (isset($response['error'])) {
						$json['error']['vouchers'] = $response['error'];
						
						break;	
					}
				}
			}
			
			// Customer
			$customer_data = array(
				'customer_id'       => $this->request->post['customer_id'],
				'customer_group_id' => $this->request->post['customer_group_id'], 
				'firstname'         => $this->request->post['firstname'],
				'lastname'          => $this->request->post['lastname'],
				'email'             => $this->request->post['email'],
				'telephone'         => $this->request->post['telephone'],
				'fax'               => $this->request->post['fax'],
				'custom_field'      => isset($this->request->post['custom_field']) ? $this->request->post['custom_field'] : array(),
			);
			
			$response = $this->api($url . 'index.php?route=api/customer', $cookie, $customer_data);
			
			if (isset($response['error'])) {
				$json['error']['customer'] = $response['error'];
			}		
					
			// Payment Address
			$payment_address = array(
				'firstname'    => $this->request->post['payment_firstname'],
				'lastname'     => $this->request->post['payment_lastname'],
				'company'      => $this->request->post['payment_company'],
				'address_1'    => $this->request->post['payment_address_1'],
				'address_2'    => $this->request->post['payment_address_2'],
				'postcode'     => $this->request->post['payment_postcode'],
				'city'         => $this->request->post['payment_city'],
				'zone_id'      => $this->request->post['payment_zone_id'],
				'country_id'   => $this->request->post['payment_country_id'],
				'custom_field' => isset($this->request->post['payment_custom_field']) ? $this->request->post['payment_custom_field'] : array()
			);
					
			$response = $this->api($url . 'index.php?route=api/payment/address', $cookie, $payment_address);
					
			if (isset($response['error'])) {
				$json['error']['payment'] = $response['error'];
			}
			
			// Shipping Address
			$shipping_address = array(
				'firstname'    => $this->request->post['shipping_firstname'],
				'lastname'     => $this->request->post['shipping_lastname'],
				'company'      => $this->request->post['shipping_company'],
				'address_1'    => $this->request->post['shipping_address_1'],
				'address_2'    => $this->request->post['shipping_address_2'],
				'postcode'     => $this->request->post['shipping_postcode'],
				'city'         => $this->request->post['shipping_city'],
				'zone_id'      => $this->request->post['shipping_zone_id'],
				'country_id'   => $this->request->post['shipping_country_id'],
				'custom_field' => isset($this->request->post['shipping_custom_field']) ? $this->request->post['shipping_custom_field'] : array()
			);		
			
			$response = $this->api($url . 'index.php?route=api/shipping/address', $cookie, $shipping_address);
			
			if (isset($response['error'])) {
				$json['error']['shipping'] = $response['error'];
			}		
			
			// Coupon
			if ($this->request->post['coupon']) {
				$response = $this->api($url . 'index.php?route=api/coupon', $cookie, array('coupon' => $this->request->post['coupon']));
							
				if (isset($response['error'])) {
					$json['error']['coupon'] = $response['error'];
				}			
			}
			
			// Voucher
			if ($this->request->post['voucher']) {
				$response = $this->api($url . 'index.php?route=api/voucher', $cookie, array('voucher' => $this->request->post['voucher']));
			
				if (isset($response['error'])) {
					$json['error']['voucher'] = $response['error'];
				}
			}
			
			// Reward Points
			if ($this->request->post['reward']) {
				$response = $this->api($url . 'index.php?route=api/reward', $cookie, array('reward' => $this->request->post['reward']));
				
				if (isset($response['error'])) {
					$json['error']['reward'] = $response['error'];
				}
			}
							
			// Shipping Methods	
			$response = $this->api($url . 'index.php?route=api/shipping/methods', $cookie);
				
			if (isset($response['error'])) {
				$json['error']['shipping_method'] = $response['error'];
			}
			
			// Shipping Method
			$response = $this->api($url . 'index.php?route=api/shipping/method', $cookie, array('shipping_method' => $this->request->post['shipping_code']));
				
			if (isset($response['error'])) {
				$json['error']['shipping_method'] = $response['error'];
			}
			
			// Payment Methods	
			$response = $this->api($url . 'index.php?route=api/payment/methods', $cookie);
			
			if (isset($response['error'])) {
				$json['error']['payment_method'] = $response['error'];
			}
			
			// Payment Method
			$response = $this->api($url . 'index.php?route=api/payment/method', $cookie, array('payment_method' => $this->request->post['payment_code']));
				
			if (isset($response['error'])) {
				$json['error']['payment_method'] = $response['error'];
			}			
		
			if (!$json['error']) {
				$response = $this->api($url . 'index.php?route=api/order/add', $cookie);
							
				if (isset($response['error'])) {
					$json['error']['warning'] = $response['error'];
				}
				
				$response = $this->api($url . 'index.php?route=api/order/history&order_id=' . $this->request->get['order_id'], $cookie, array('order_status_id' => $this->request->post['order_status_id']));
							
				if (isset($response['error'])) {
					$json['error']['warning'] = $response['error'];
				}
			}
		}
		
		if (!$json['error']) {
			$this->session->data['success'] = $this->language->get('text_success');
		}		
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
	
	public function update() {
		$this->load->language('sale/order');
		
		$json = array();
		
		$this->load->model('setting/store');
		
		$store_info = $this->model_setting_store->getStore($this->request->post['store_id']);
		
		if ($store_info) {
			$url = $store_info['url'];
		} else {
			$url = HTTP_CATALOG;
		}
		
		$this->load->model('user/api');
		
		$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));
		
		if ($api_info) {
			$api_data = array(
				'username' => $api_info['username'],
				'password' => $api_info['password']
			);
			
			$response = $this->api($url . 'index.php?route=api/login', '', $api_data);
			
			if (isset($response['error'])) {
				$json['error'] = $response['error'];
			}
		}		
		
		if (isset($response['cookie'])) {
			$cookie = $response['cookie'];

			// Products
			if (isset($this->request->post['order_product'])) {
				foreach ($this->request->post['order_product'] as $order_product) {
					if (isset($order_product['order_option'])) {
						$option = $order_product['order_option'];
					} else {
						$option = array();
					}
								
					$product_data = array(
						'product_id' => $order_product['product_id'],
						'option'     => $option,
						'quantity'   => $order_product['quantity'],
						'override'   => true
					);
	
					$response = $this->api($url . 'index.php?route=api/cart/add', $cookie, $product_data);
					
					if (isset($response['error'])) {
						$json['error']['product'] = $response['error'];
						
						break;	
					}
				}
			}
				
			// Vouchers
			if (isset($this->request->post['order_voucher'])) {
				foreach ($this->request->post['order_voucher'] as $order_voucher) {
					$response = $this->api($url . 'index.php?route=api/voucher/add', $cookie, $order_voucher);
						
					if (isset($response['error'])) {
						$json['error']['vouchers'] = $response['error'];
						
						break;	
					}
				}
			}
			
			// Customer
			$customer_data = array(
				'customer_id'       => $this->request->post['customer_id'],
				'customer_group_id' => $this->request->post['customer_group_id'], 
				'firstname'         => $this->request->post['firstname'],
				'lastname'          => $this->request->post['lastname'],
				'email'             => $this->request->post['email'],
				'telephone'         => $this->request->post['telephone'],
				'fax'               => $this->request->post['fax'],
				'custom_field'      => isset($this->request->post['custom_field']) ? $this->request->post['custom_field'] : array(),
			);
			
			$response = $this->api($url . 'index.php?route=api/customer', $cookie, $customer_data);
			
			if (isset($response['error'])) {
				$json['error']['customer'] = $response['error'];
			}		
					
			// Payment Address
			$payment_address = array(
				'firstname'    => $this->request->post['payment_firstname'],
				'lastname'     => $this->request->post['payment_lastname'],
				'company'      => $this->request->post['payment_company'],
				'address_1'    => $this->request->post['payment_address_1'],
				'address_2'    => $this->request->post['payment_address_2'],
				'postcode'     => $this->request->post['payment_postcode'],
				'city'         => $this->request->post['payment_city'],
				'zone_id'      => $this->request->post['payment_zone_id'],
				'country_id'   => $this->request->post['payment_country_id'],
				'custom_field' => isset($this->request->post['payment_custom_field']) ? $this->request->post['payment_custom_field'] : array()
			);
					
			$response = $this->api($url . 'index.php?route=api/payment/address', $cookie, $payment_address);
					
			if (isset($response['error'])) {
				$json['error']['payment'] = $response['error'];
			}
			
			// Shipping Address
			$shipping_address = array(
				'firstname'    => $this->request->post['shipping_firstname'],
				'lastname'     => $this->request->post['shipping_lastname'],
				'company'      => $this->request->post['shipping_company'],
				'address_1'    => $this->request->post['shipping_address_1'],
				'address_2'    => $this->request->post['shipping_address_2'],
				'postcode'     => $this->request->post['shipping_postcode'],
				'city'         => $this->request->post['shipping_city'],
				'zone_id'      => $this->request->post['shipping_zone_id'],
				'country_id'   => $this->request->post['shipping_country_id'],
				'custom_field' => isset($this->request->post['shipping_custom_field']) ? $this->request->post['shipping_custom_field'] : array()
			);		
			
			$response = $this->api($url . 'index.php?route=api/shipping/address', $cookie, $shipping_address);
			
			if (isset($response['error'])) {
				$json['error']['shipping'] = $response['error'];
			}		
			
			// Coupon
			if ($this->request->post['coupon']) {
				$response = $this->api($url . 'index.php?route=api/coupon', $cookie, array('coupon' => $this->request->post['coupon']));
							
				if (isset($response['error'])) {
					$json['error']['coupon'] = $response['error'];
				}			
			}
			
			// Voucher
			if ($this->request->post['voucher']) {
				$response = $this->api($url . 'index.php?route=api/voucher', $cookie, array('voucher' => $this->request->post['voucher']));
			
				if (isset($response['error'])) {
					$json['error']['voucher'] = $response['error'];
				}
			}
			
			// Reward Points
			if ($this->request->post['reward']) {
				$response = $this->api($url . 'index.php?route=api/reward', $cookie, array('reward' => $this->request->post['reward']));
				
				if (isset($response['error'])) {
					$json['error']['reward'] = $response['error'];
				}
			}
							
			// Shipping Methods	
			$response = $this->api($url . 'index.php?route=api/shipping/methods', $cookie);
				
			if (isset($response['error'])) {
				$json['error']['shipping_method'] = $response['error'];
			}
			
			// Shipping Method
			$response = $this->api($url . 'index.php?route=api/shipping/method', $cookie, array('shipping_method' => $this->request->post['shipping_code']));
				
			if (isset($response['error'])) {
				$json['error']['shipping_method'] = $response['error'];
			}
			
			// Payment Methods	
			$response = $this->api($url . 'index.php?route=api/payment/methods', $cookie);
			
			if (isset($response['error'])) {
				$json['error']['payment_method'] = $response['error'];
			}
			
			// Payment Method
			$response = $this->api($url . 'index.php?route=api/payment/method', $cookie, array('payment_method' => $this->request->post['payment_code']));
				
			if (isset($response['error'])) {
				$json['error']['payment_method'] = $response['error'];
			}	
			
			if (!isset($json['error'])) {		
				$response = $this->api($url . 'index.php?route=api/order/update&order_id=' . $this->request->get['order_id'], $cookie);
							
				if (isset($response['error'])) {
					$json['error']['warning'] = $response['error'];
				}
				
				$response = $this->api($url . 'index.php?route=api/order/history&order_id=' . $this->request->get['order_id'], $cookie, array('order_status_id' => $this->request->post['order_status_id']));
							
				if (isset($response['error'])) {
					$json['error']['warning'] = $response['error'];
				}
			}
		}
		
		if (!isset($json['error'])) {
			$json['success'] = $this->language->get('text_success');	
		}
					
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
	
	public function delete() {
		$this->load->language('sale/order');
		
		$json = array();
		
		$this->load->model('setting/store');
		
		$store_info = $this->model_setting_store->getStore($this->request->post['store_id']);
		
		if ($store_info) {
			$url = $store_info['url'];
		} else {
			$url = HTTP_CATALOG;
		}
		
		$this->load->model('user/api');
		
		$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));
		
		if ($api_info) {
			$api_data = array(
				'username' => $api_info['username'],
				'password' => $api_info['password']
			);
			
			$response = $this->api($url . 'index.php?route=api/login', '', $api_data);
			
			if (isset($response['error'])) {
				$json['error'] = $response['error'];
			}
		}		
		
		if (isset($response['cookie'])) {
			$cookie = $response['cookie'];
			
			// Sert the order history to a voided status to add the product stock, rewards, coupons and vouchers
			$response = $this->api($url . 'index.php?route=api/order/history', $cookie, array('order_status_id' => $this->request->post['order_status_id']));
						
			if (isset($response['error'])) {
				$json['error']['warning'] = $response['error'];
			}				
			
			$response = $this->api($url . 'index.php?route=api/order/delete&order_id=' . $this->request->get['order_id'], $cookie);
						
			if (isset($response['error'])) {
				$json['error']['warning'] = $response['error'];
			}
		}
		
		if (!isset($json['error'])) {
			$json['success'] = $this->language->get('text_success');	
		}		
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
	
	public function refresh() {
		$this->load->language('sale/order');
		
		$json = array();
		
		$this->load->model('setting/store');
		
		$store_info = $this->model_setting_store->getStore($this->request->post['store_id']);
		
		if ($store_info) {
			$url = $store_info['url'];
		} else {
			$url = HTTP_CATALOG;
		}
		
		$this->load->model('user/api');
		
		$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));
		
		if ($api_info) {
			$api_data = array(
				'username' => $api_info['username'],
				'password' => $api_info['password']
			);
			
			$response = $this->api($url . 'index.php?route=api/login', '', $api_data);
			
			if (isset($response['error'])) {
				$json['error'] = $response['error'];
			}
		}		
		
		if (isset($response['cookie'])) {
			$cookie = $response['cookie'];

			// Products
			if (isset($this->request->post['order_product'])) {
				foreach ($this->request->post['order_product'] as $order_product) {
					if (isset($order_product['order_option'])) {
						$option = $order_product['order_option'];
					} else {
						$option = array();
					}
								
					$product_data = array(
						'product_id' => $order_product['product_id'],
						'option'     => $option,
						'quantity'   => $order_product['quantity'],
						'override'   => true
					);
	
					$response = $this->api($url . 'index.php?route=api/cart/add', $cookie, $product_data);
					
					if (isset($response['error'])) {
						$json['error']['product'] = $response['error'];
						
						break;	
					}
				}
			}
	
			// Add to cart
			if (isset($this->request->post['product_id'])) {
				if (isset($this->request->post['quantity'])) {
					$quantity = $this->request->post['quantity'];
				} else {
					$quantity = 1;
				}
							
				if (isset($this->request->post['option'])) {
					$option = $this->request->post['option'];
				} else {
					$option = array();
				}
				
				$product_data = array(
					'product_id' => $this->request->post['product_id'],
					'option'     => $option,
					'quantity'   => $quantity
				);
				
				$response = $this->api($url . 'index.php?route=api/cart/add', $cookie, $product_data);
						
				if (isset($response['error'])) {
					$json['error']['product'] = $response['error'];
				}
			}		
			
			// Vouchers
			if (isset($this->request->post['order_voucher'])) {
				foreach ($this->request->post['order_voucher'] as $order_voucher) {
					$response = $this->api($url . 'index.php?route=api/voucher/add', $cookie, $order_voucher);
						
					if (isset($response['error'])) {
						$json['error']['vouchers'] = $response['error'];
						
						break;	
					}
				}
			}
			
			// Add to cart
			if (isset($this->request->post['to_name']) || isset($this->request->post['to_email']) || isset($this->request->post['from_name']) || isset($this->request->post['from_email'])) {
				$voucher_data = array(
					'from_name'        => $this->request->post['from_name'],
					'from_email'       => $this->request->post['from_email'],
					'to_name'          => $this->request->post['to_name'],
					'to_email'         => $this->request->post['to_email'],
					'voucher_theme_id' => $this->request->post['voucher_theme_id'],
					'message'          => $this->request->post['message'],
					'amount'           => $this->request->post['amount']
				);
				
				$response = $this->api($url . 'index.php?route=api/voucher/add', $cookie, $voucher_data);
				
				if (isset($response['error'])) {
					$json['error']['vouchers'] = $response['error'];
				}			
			}
						
			// Customer
			$customer_data = array(
				'customer_id'       => $this->request->post['customer_id'],
				'customer_group_id' => $this->request->post['customer_group_id'], 
				'firstname'         => $this->request->post['firstname'],
				'lastname'          => $this->request->post['lastname'],
				'email'             => $this->request->post['email'],
				'telephone'         => $this->request->post['telephone'],
				'fax'               => $this->request->post['fax'],
				'custom_field'      => isset($this->request->post['custom_field']) ? $this->request->post['custom_field'] : array(),
			);
			
			$response = $this->api($url . 'index.php?route=api/customer', $cookie, $customer_data);
			
			if (isset($response['error'])) {
				$json['error']['customer'] = $response['error'];
			}		
					
			// Payment Address
			$payment_address = array(
				'firstname'    => $this->request->post['payment_firstname'],
				'lastname'     => $this->request->post['payment_lastname'],
				'company'      => $this->request->post['payment_company'],
				'address_1'    => $this->request->post['payment_address_1'],
				'address_2'    => $this->request->post['payment_address_2'],
				'postcode'     => $this->request->post['payment_postcode'],
				'city'         => $this->request->post['payment_city'],
				'zone_id'      => $this->request->post['payment_zone_id'],
				'country_id'   => $this->request->post['payment_country_id'],
				'custom_field' => isset($this->request->post['payment_custom_field']) ? $this->request->post['payment_custom_field'] : array()
			);
					
			$response = $this->api($url . 'index.php?route=api/payment/address', $cookie, $payment_address);
					
			if (isset($response['error'])) {
				$json['error']['payment'] = $response['error'];
			}
			
			// Shipping Address
			$shipping_address = array(
				'firstname'    => $this->request->post['shipping_firstname'],
				'lastname'     => $this->request->post['shipping_lastname'],
				'company'      => $this->request->post['shipping_company'],
				'address_1'    => $this->request->post['shipping_address_1'],
				'address_2'    => $this->request->post['shipping_address_2'],
				'postcode'     => $this->request->post['shipping_postcode'],
				'city'         => $this->request->post['shipping_city'],
				'zone_id'      => $this->request->post['shipping_zone_id'],
				'country_id'   => $this->request->post['shipping_country_id'],
				'custom_field' => isset($this->request->post['shipping_custom_field']) ? $this->request->post['shipping_custom_field'] : array()
			);		
			
			$response = $this->api($url . 'index.php?route=api/shipping/address', $cookie, $shipping_address);
			
			if (isset($response['error'])) {
				$json['error']['shipping'] = $response['error'];
			}		
			
			// Coupon
			if ($this->request->post['coupon']) {
				$response = $this->api($url . 'index.php?route=api/coupon', $cookie, array('coupon' => $this->request->post['coupon']));
							
				if (isset($response['error'])) {
					$json['error']['coupon'] = $response['error'];
				}			
			}
			
			// Voucher
			if ($this->request->post['voucher']) {
				$response = $this->api($url . 'index.php?route=api/voucher', $cookie, array('voucher' => $this->request->post['voucher']));
			
				if (isset($response['error'])) {
					$json['error']['voucher'] = $response['error'];
				}
			}
			
			// Reward Points
			if ($this->request->post['reward']) {
				$response = $this->api($url . 'index.php?route=api/reward', $cookie, array('reward' => $this->request->post['reward']));
				
				if (isset($response['error'])) {
					$json['error']['reward'] = $response['error'];
				}
			}
							
			// Shipping Methods	
			$response = $this->api($url . 'index.php?route=api/shipping/methods', $cookie);
				
			if (isset($response['error'])) {
				$json['error']['shipping_method'] = $response['error'];
			} else {
				$json['shipping_methods'] = $response['shipping_methods'];
			}
			
			// Shipping Method
			$response = $this->api($url . 'index.php?route=api/shipping/method', $cookie, array('shipping_method' => $this->request->post['shipping_code']));
				
			if (isset($response['error'])) {
				$json['error']['shipping_method'] = $response['error'];
			}
			
			// Payment Methods	
			$response = $this->api($url . 'index.php?route=api/payment/methods', $cookie);
			
			if (isset($response['error'])) {
				$json['error']['payment_method'] = $response['error'];
			} else {
				$json['payment_methods'] = $response['payment_methods'];
			}
			
			// Payment Method
			$response = $this->api($url . 'index.php?route=api/payment/method', $cookie, array('payment_method' => $this->request->post['payment_code']));
				
			if (isset($response['error'])) {
				$json['error']['payment_method'] = $response['error'];
			}	
			
			// Products
			$response = $this->api($url . 'index.php?route=api/cart/products', $cookie);
			
			if (isset($response['products'])) {
				$json['products'] = $response['products'];
			}
			
			// Vouchers
			if (isset($response['vouchers'])) {
				$json['vouches'] = $response['vouchers'];
			}
					
			// Totals
			$response = $this->api($url . 'index.php?route=api/cart/totals', $cookie);
			
			if (isset($response['totals'])) {
				$json['totals'] = $response['totals'];
			}		
		}

		if (!isset($json['error'])) {
			$json['success'] = $this->language->get('text_refresh');	
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
	
	public function history() {
		$json = array();
		
		$this->load->model('user/api');
		
		$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));
		
		if ($api_info) {
			$api_data = array(
				'username' => $api_info['username'],
				'password' => $api_info['password']
			);
			
			$response = $this->api(HTTPS_CATALOG . 'index.php?route=api/login', '', $api_data);
			
			if (isset($response['error'])) {
				$json['error'] = $response['error'];
			}
		}
		
		if (isset($response['cookie'])) {
			$json = $this->api(HTTPS_CATALOG . 'index.php?route=api/order/history&order_id=' . $this->request->get['order_id'], $response['cookie'], $this->request->post);
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
	
	function api($url, $cookie = '', $data = array()) {
		$curl = curl_init();
		
		// Set SSL if required
		if (substr($url, 0, 5) == 'https') {
			curl_setopt($curl, CURLOPT_PORT, 443);
		}
		
		curl_setopt($curl, CURLOPT_HEADER, false);
		curl_setopt($curl, CURLINFO_HEADER_OUT, true);
		curl_setopt($curl, CURLOPT_USERAGENT, $this->request->server['HTTP_USER_AGENT']);
		curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false); 
		curl_setopt($curl, CURLOPT_FORBID_REUSE, false);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_URL, $url);
		
		if ($data) {
			curl_setopt($curl, CURLOPT_POST, true);
			curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
		}
		
		if ($cookie) {
			curl_setopt($curl, CURLOPT_COOKIE, session_name() . '=' . $cookie . ';');
		}
		
		$response = curl_exec($curl);

		if (!$response) {
			return array('error' => curl_error($curl) . '(' . curl_errno($curl) . ')');
		}
				
		curl_close($curl);
		
		return json_decode($response, true);
	}
}