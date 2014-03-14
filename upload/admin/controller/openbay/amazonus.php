<?php
class ControllerOpenbayAmazonus extends Controller {
	public function stockUpdates() {
		$data = $this->load->language('openbay/amazonus_stockupdates');

		$this->document->setTitle($this->language->get('text_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_overview'),
		);

		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/stockUpdates', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_stock_updates'),
		);

		$data['link_overview'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');

		$requestArgs = array();

		if (isset($this->request->get['filter_date_start'])) {
			$requestArgs['date_start'] = date("Y-m-d", strtotime($this->request->get['filter_date_start']));
		} else {
			$requestArgs['date_start'] = date("Y-m-d");
		}

		if (isset($this->request->get['filter_date_end'])) {
			$requestArgs['date_end'] = date("Y-m-d", strtotime($this->request->get['filter_date_end']));
		} else {
			$requestArgs['date_end'] = date("Y-m-d");
		}

		$data['date_start'] = $requestArgs['date_start'];
		$data['date_end'] = $requestArgs['date_end'];

		$xml = $this->openbay->amazonus->getStockUpdatesStatus($requestArgs);
		$simpleXmlObj = simplexml_load_string($xml);
		$data['table_data'] = array();

		if($simpleXmlObj !== false) {
			$table_data = array();

			foreach($simpleXmlObj->update as $updateNode) {
				$row = array('date_requested' => (string)$updateNode->date_requested,
					'date_updated' => (string)$updateNode->date_updated,
					'status' => (string)$updateNode->status,
					);
				$data = array();
				foreach($updateNode->data->product as $productNode) {
					$data[] = array('sku' => (string)$productNode->sku,
						'stock' => (int)$productNode->stock
						);
				}
				$row['data'] = $data;
				$table_data[(int)$updateNode->ref] = $row;
			}

			$data['table_data'] = $table_data;
		} else {
			$data['error'] = 'Could not connect to OpenBay PRO API.';
		}

		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_stock_updates.tpl', $data));
	}

	public function index() {
		$this->response->redirect($this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'));
		return;
	}

	public function overview() {
		$this->load->model('setting/setting');
		$this->load->model('localisation/order_status');
		$this->load->model('openbay/amazonus');
		$this->load->model('sale/customer_group');

		$data = $this->load->language('openbay/amazonus_overview');

		$this->document->setTitle($this->language->get('text_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_title'),
		);

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['validation'] = $this->openbay->amazonus->validate();
		$data['link_settings'] = $this->url->link('openbay/amazonus/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_subscription'] = $this->url->link('openbay/amazonus/subscription', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_item_link'] = $this->url->link('openbay/amazonus/itemLinks', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_stock_updates'] = $this->url->link('openbay/amazonus/stockUpdates', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_saved_listings'] = $this->url->link('openbay/amazonus/savedListings', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_bulk_listing'] = $this->url->link('openbay/amazonus/bulkListProducts', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_bulk_linking'] = $this->url->link('openbay/amazonus/bulkLinking', 'token=' . $this->session->data['token'], 'SSL');

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_overview.tpl', $data));
	}

	public function subscription() {
		$data = $this->load->language('openbay/amazonus_subscription');

		$this->document->setTitle($this->language->get('text_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_overview'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/subscription', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_my_account'),
		);

		$data['link_overview'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');

		$response = simplexml_load_string($this->openbay->amazonus->callWithResponse('plans/getPlans'));

		$data['plans'][] = array();

		if ($response) {
			foreach ($response->Plan as $plan) {
				$data['plans'][] = array(
					'title' => (string)$plan->Title,
					'description' => (string)$plan->Description,
					'order_frequency' => (string)$plan->OrderFrequency,
					'product_listings' => (string)$plan->ProductListings,
					'bulk_listing' => (string)$plan->BulkListing,
					'price' => (string)$plan->Price,
				);
			}
		}

		$response = simplexml_load_string($this->openbay->amazonus->callWithResponse('plans/getUsersPlans'));

		$plan = false;

		if ($response) {
			$plan = array(
				'merchant_id' => (string)$response->MerchantId,
				'user_status' => (string)$response->UserStatus,
				'title' => (string)$response->Title,
				'description' => (string)$response->Description,
				'price' => (string)$response->Price,
				'order_frequency' => (string)$response->OrderFrequency,
				'product_listings' => (string)$response->ProductListings,
				'listings_remain' => (string)$response->ListingsRemain,
				'listings_reserved' => (string)$response->ListingsReserved,
				'bulk_listing' => (string)$response->BulkListing,
			);
		}

		$data['user_plan'] = $plan;
		$data['link_change_plan'] = $this->openbay->amazonus->getServer().'account/changePlan/?token='.$this->config->get('openbay_amazonus_token');
		$data['link_change_seller'] = $this->openbay->amazonus->getServer().'account/changeSellerId/?token='.$this->config->get('openbay_amazonus_token');

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_subscription.tpl', $data));
	}

	public function settings() {
		$data = $this->load->language('openbay/amazonus_settings');
		$this->load->language('openbay/amazonus_listing');
		$this->document->setTitle($this->language->get('text_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$this->load->model('setting/setting');
		$this->load->model('localisation/order_status');
		$this->load->model('openbay/amazonus');
		$this->load->model('sale/customer_group');

		$settings = $this->model_setting_setting->getSetting('openbay_amazonus');

		if (isset($settings['openbay_amazonus_orders_marketplace_ids'])) {
			$settings['openbay_amazonus_orders_marketplace_ids'] = $this->is_serialized($settings['openbay_amazonus_orders_marketplace_ids']) ? (array)unserialize($settings['openbay_amazonus_orders_marketplace_ids']) : $settings['openbay_amazonus_orders_marketplace_ids'];
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			if (!isset($this->request->post['openbay_amazonus_orders_marketplace_ids'])) {
				$this->request->post['openbay_amazonus_orders_marketplace_ids'] = array();
			}

			$settings = array_merge($settings, $this->request->post);
			$this->model_setting_setting->editSetting('openbay_amazonus', $settings);

			$this->config->set('openbay_amazonus_token', $this->request->post['openbay_amazonus_token']);
			$this->config->set('openbay_amazonus_enc_string1', $this->request->post['openbay_amazonus_enc_string1']);
			$this->config->set('openbay_amazonus_enc_string2', $this->request->post['openbay_amazonus_enc_string2']);

			$this->model_openbay_amazonus->scheduleOrders($settings);

			$this->session->data['success'] = $this->language->get('text_setttings_updated');
			$this->response->redirect($this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'));
			return;
		}

		$data['link_overview'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_amazon'),
		);

		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/settings', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_settings'),
		);

		$data['marketplace_ids']                  = (isset($settings['openbay_amazonus_orders_marketplace_ids']) ? (array)$settings['openbay_amazonus_orders_marketplace_ids'] : array() );
		$data['default_listing_marketplace_ids']  = ( isset($settings['openbay_amazonus_default_listing_marketplace_ids']) ? (array)$settings['openbay_amazonus_default_listing_marketplace_ids'] : array() );

		$data['marketplaces'] = array(
			array('name' => $this->language->get('text_de'), 'id' => 'A1PA6795UKMFR9', 'code' => 'de'),
			array('name' => $this->language->get('text_fr'), 'id' => 'A13V1IB3VIYZZH', 'code' => 'fr'),
			array('name' => $this->language->get('text_it'), 'id' => 'APJ6JRA9NG5V4', 'code' => 'it'),
			array('name' => $this->language->get('text_es'), 'id' => 'A1RKKUPIHCS9HS', 'code' => 'es'),
			array('name' => $this->language->get('text_uk'), 'id' => 'A1F83G8C2ARO7P', 'code' => 'uk'),
		);

		$data['conditions'] = array(
			'New' => $this->language->get('text_new'),
			'UsedLikeNew' => $this->language->get('text_used_like_new'),
			'UsedVeryGood' => $this->language->get('text_used_very_good'),
			'UsedGood' => $this->language->get('text_used_good'),
			'UsedAcceptable' => $this->language->get('text_used_acceptable'),
			'CollectibleLikeNew' => $this->language->get('text_collectible_like_new'),
			'CollectibleVeryGood' => $this->language->get('text_collectible_very_good'),
			'CollectibleGood' => $this->language->get('text_collectible_good'),
			'CollectibleAcceptable' => $this->language->get('text_collectible_acceptable'),
			'Refurbished' => $this->language->get('text_refurbished'),
		);

		$data['is_enabled'] = isset($settings['amazonus_status']) ? $settings['amazonus_status'] : '';
		$data['openbay_amazonus_token'] = isset($settings['openbay_amazonus_token']) ? $settings['openbay_amazonus_token'] : '';
		$data['openbay_amazonus_enc_string1'] = isset($settings['openbay_amazonus_enc_string1']) ? $settings['openbay_amazonus_enc_string1'] : '';
		$data['openbay_amazonus_enc_string2'] = isset($settings['openbay_amazonus_enc_string2']) ? $settings['openbay_amazonus_enc_string2'] : '';
		$data['openbay_amazonus_listing_tax_added'] = isset($settings['openbay_amazonus_listing_tax_added']) ? $settings['openbay_amazonus_listing_tax_added'] : '0.00';
		$data['openbay_amazonus_order_tax'] = isset($settings['openbay_amazonus_order_tax']) ? $settings['openbay_amazonus_order_tax'] : '00';
		$data['openbay_amazonus_default_listing_marketplace'] = isset($settings['openbay_amazonus_default_listing_marketplace']) ? $settings['openbay_amazonus_default_listing_marketplace'] : '';
		$data['openbay_amazonus_listing_default_condition'] = isset($settings['openbay_amazonus_listing_default_condition']) ? $settings['openbay_amazonus_listing_default_condition'] : '';

		$data['carriers'] = $this->openbay->amazonus->getCarriers();
		$data['openbay_amazonus_default_carrier'] = isset($settings['openbay_amazonus_default_carrier']) ? $settings['openbay_amazonus_default_carrier'] : '';

		$unshippedStatusId = isset($settings['openbay_amazonus_order_status_unshipped']) ? $settings['openbay_amazonus_order_status_unshipped'] : '';
		$partiallyShippedStatusId = isset($settings['openbay_amazonus_order_status_partially_shipped']) ? $settings['openbay_amazonus_order_status_partially_shipped'] : '';
		$shippedStatusId = isset($settings['openbay_amazonus_order_status_shipped']) ? $settings['openbay_amazonus_order_status_shipped'] : '';
		$canceledStatusId = isset($settings['openbay_amazonus_order_status_canceled']) ? $settings['openbay_amazonus_order_status_canceled'] : '';

		$amazonusOrderStatuses = array(
			'unshipped' => array('name' => $this->language->get('text_unshipped'), 'order_status_id' => $unshippedStatusId),
			'partially_shipped' => array('name' => $this->language->get('text_partially_shipped'), 'order_status_id' => $partiallyShippedStatusId),
			'shipped' => array('name' => $this->language->get('text_shipped'), 'order_status_id' => $shippedStatusId),
			'canceled' => array('name' => $this->language->get('text_canceled'), 'order_status_id' => $canceledStatusId),
		);

		$data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		$data['openbay_amazonus_order_customer_group'] = isset($settings['openbay_amazonus_order_customer_group']) ? $settings['openbay_amazonus_order_customer_group'] : '';

		$data['amazonus_order_statuses'] = $amazonusOrderStatuses;
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		$data['subscription_url'] = $this->url->link('openbay/amazonus/subscription', 'token=' . $this->session->data['token'], 'SSL');
		$data['itemLinks_url'] = $this->url->link('openbay/amazonus_product/linkItems', 'token=' . $this->session->data['token'], 'SSL');

		$data['openbay_amazonus_notify_admin'] = isset($settings['openbay_amazonus_notify_admin']) ? $settings['openbay_amazonus_notify_admin'] : '';

		$pingInfo = simplexml_load_string($this->openbay->amazonus->callWithResponse('ping/info'));

		$api_status = false;
		$api_auth = false;
		if($pingInfo) {
			$api_status = ((string)$pingInfo->Api_status == 'ok') ? true : false;
			$api_auth = ((string)$pingInfo->Auth == 'true') ? true : false;
		}

		$data['API_status'] = $api_status;
		$data['API_auth'] = $api_auth;

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_settings.tpl', $data));
	}

	private function is_serialized( $data ) {
		// if it isn't a string, it isn't serialized
		if (!is_string($data)) {
			return false;
		}
		$data = trim($data);
		if ('N;' == $data) {
			return true;
		}
		if (!preg_match('/^([adObis]):/', $data, $badions)) {
			return false;
		}
		switch ($badions[1]) {
			case 'a' :
			case 'O' :
			case 's' :
				if (preg_match("/^{$badions[1]}:[0-9]+:.*[;}]\$/s", $data)) {
					return true;
				}
				break;
			case 'b' :
			case 'i' :
			case 'd' :
				if (preg_match("/^{$badions[1]}:[0-9.E-]+;\$/", $data)) {
					return true;
				}
				break;
		}
		return false;
	}

	public function itemLinks() {
		$data = $this->load->language('openbay/amazonus_links');

		$this->document->setTitle($this->language->get('text_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['link_overview'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_amazon'),
		);

		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/itemLinks', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_title'),
		);

		$data['token'] = $this->session->data['token'];

		$data['add_item_link_ajax'] = $this->url->link('openbay/amazonus/addItemLinkAjax', 'token=' . $this->session->data['token'], 'SSL');
		$data['remove_item_link_ajax'] = $this->url->link('openbay/amazonus/removeItemLinkAjax', 'token=' . $this->session->data['token'], 'SSL');
		$data['get_item_links_ajax'] = $this->url->link('openbay/amazonus/getItemLinksAjax', 'token=' . $this->session->data['token'], 'SSL');
		$data['get_unlinked_items_ajax'] = $this->url->link('openbay/amazonus/getUnlinkedItemsAjax', 'token=' . $this->session->data['token'], 'SSL');
		$data['get_openstock_options_ajax'] = $this->url->link('openbay/amazonus/getOpenstockOptionsAjax', 'token=' . $this->session->data['token'], 'SSL');

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_item_links.tpl', $data));
	}

	public function savedListings() {
		$data = $this->load->language('openbay/amazonus_listingsaved');

		$this->document->setTitle($this->language->get('text_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['link_overview'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_amazon'),
		);

		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/savedListings', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_title'),
		);

		$data['token'] = $this->session->data['token'];
		$this->load->model('openbay/amazonus');
		$saved_products = $this->model_openbay_amazonus->getSavedProducts();

		$data['saved_products'] = array();

		foreach($saved_products as $saved_product) {
			$data['saved_products'][] = array(
				'product_id' => $saved_product['product_id'],
				'product_name' => $saved_product['product_name'],
				'product_model' => $saved_product['product_model'],
				'product_sku' => $saved_product['product_sku'],
				'amazonus_sku' => $saved_product['amazonus_sku'],
				'var' => $saved_product['var'],
				'edit_link' => $this->url->link('openbay/amazonus_product', 'token=' . $this->session->data['token'] . '&product_id=' . $saved_product['product_id'] . '&var=' . $saved_product['var'], 'SSL'),
			);
		}

		$data['deleteSavedAjax'] = $this->url->link('openbay/amazonus/deleteSavedAjax', 'token=' . $this->session->data['token'], 'SSL');
		$data['uploadSavedAjax'] = $this->url->link('openbay/amazonus_product/uploadSavedAjax', 'token=' . $this->session->data['token'], 'SSL');

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_saved_listings.tpl', $data));
	}

	public function install() {
		$this->load->model('openbay/amazonus');
		$this->load->model('setting/setting');
		$this->load->model('setting/extension');

		$this->model_openbay_amazonus->install();
		$this->model_setting_extension->install('openbay', $this->request->get['extension']);
	}

	public function uninstall() {
		$this->load->model('openbay/amazonus');
		$this->load->model('setting/setting');
		$this->load->model('setting/extension');

		$this->model_openbay_amazonus->uninstall();
		$this->model_setting_extension->uninstall('openbay', $this->request->get['extension']);
		$this->model_setting_setting->deleteSetting($this->request->get['extension']);
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'openbay/amazonus')) {
			$this->error = $this->language->get('error_permission');
		}

		if (empty($this->error)) {
			return true;
		}

		return false;
	}

	public function getOpenstockOptionsAjax() {
		$options = array();
		if ($this->openbay->addonLoad('openstock') && isset($this->request->get['product_id'])) {
			$this->load->model('openstock/openstock');
			$this->load->model('tool/image');
			$options = $this->model_openstock_openstock->getProductOptionStocks($this->request->get['product_id']);
		}
		if(empty($options)) {
			$options = false;
		}
		$this->response->setOutput(json_encode($options));
	}

	public function addItemLinkAjax() {
		if(isset($this->request->get['product_id']) && isset($this->request->get['amazonus_sku'])) {
			$amazonus_sku = $this->request->get['amazonus_sku'];
			$product_id = $this->request->get['product_id'];
			$var = isset($this->request->get['var']) ? $this->request->get['var'] : '';
		} else {
			$result = json_encode('error');
			$this->response->setOutput($result);
			return;
		}

		$this->load->model('openbay/amazonus');
		$this->model_openbay_amazonus->linkProduct($amazonus_sku, $product_id, $var);

		$logger = new Log('amazonus_stocks.log');
		$logger->write('addItemLink() called for product id: ' . $product_id . ', amazonus sku: ' . $amazonus_sku . ', var: ' . $var);

		if($var != '' && $this->openbay->addonLoad('openstock')) {
			$logger->write('Using openStock');
			$this->load->model('tool/image');
			$this->load->model('openstock/openstock');
			$optionStocks = $this->model_openstock_openstock->getProductOptionStocks($product_id);
			$quantityData = array();
			foreach($optionStocks as $optionStock) {
				if(isset($optionStock['var']) && $optionStock['var'] == $var) {
					$quantityData[$amazonus_sku] = $optionStock['stock'];
					break;
				}
			}
			if(!empty($quantityData)) {
				$logger->write('Updating quantities with data: ' . print_r($quantityData, true));
				$this->openbay->amazonus->updateQuantities($quantityData);
			} else {
				$logger->write('No quantity data will be posted.');
			}
		} else {
			$this->openbay->amazonus->putStockUpdateBulk(array($product_id));
		}

		$result = json_encode('ok');
		$this->response->setOutput($result);
		$logger->write('addItemLink() exiting');
	}

	public function removeItemLinkAjax() {
		if(isset($this->request->get['amazonus_sku'])) {
			$amazonus_sku = $this->request->get['amazonus_sku'];
		} else {
			$result = json_encode('error');
			$this->response->setOutput($result);
			return;
		}
		$this->load->model('openbay/amazonus');

		$this->model_openbay_amazonus->removeProductLink($amazonus_sku);

		$result = json_encode('ok');
		$this->response->setOutput($result);
	}

	public function getItemLinksAjax() {
		$this->load->model('openbay/amazonus');
		$this->load->model('catalog/product');

		$itemLinks = $this->model_openbay_amazonus->getProductLinks();
		$result = json_encode($itemLinks);
		$this->response->setOutput($result);
	}

	public function getUnlinkedItemsAjax() {
		$this->load->model('openbay/amazonus');
		$this->load->model('catalog/product');

		$unlinkedProducts = $this->model_openbay_amazonus->getUnlinkedProducts();
		$result = json_encode($unlinkedProducts);
		$this->response->setOutput($result);
	}

	public function deleteSavedAjax() {
		if(!isset($this->request->get['product_id']) || !isset($this->request->get['var'])) {
			return;
		}

		$this->load->model('openbay/amazonus');
		$this->model_openbay_amazonus->deleteSaved($this->request->get['product_id'], $this->request->get['var']);
	}

	public function doBulkList() {
		$this->load->language('openbay/amazonus_listing');

		if (empty($this->request->post['products'])) {
			$json = array(
				'message' => $this->language->get('error_not_searched'),
			);
		} else {
			$this->load->model('openbay/amazonus_listing');

			$delete_search_results = array();

			$bulk_list_products = array();

			foreach ($this->request->post['products'] as $product_id => $asin) {
				$delete_search_results[] = $product_id;

				if (!empty($asin)) {
					$bulk_list_products[$product_id] = $asin;
				}
			}

			$status = false;

			if ($bulk_list_products) {
				$data = array();

				$data['products'] = $bulk_list_products;

				if (!empty($this->request->post['start_selling'])) {
					$data['start_selling'] = $this->request->post['start_selling'];
				}

				if (!empty($this->request->post['condition']) && !empty($this->request->post['condition_note'])) {
					$data['condition'] = $this->request->post['condition'];
					$data['condition_note'] = $this->request->post['condition_note'];
				}

				$status = $this->model_openbay_amazonus_listing->doBulkListing($data);

				if ($status) {
					$message = $this->language->get('text_products_sent');

					if ($delete_search_results) {
						$this->model_openbay_amazonus_listing->deleteSearchResults($delete_search_results);
					}
				} else {
					$message = $this->language->get('error_sending_products');
				}
			} else {
				$message = $this->language->get('error_no_products_selected');
			}

			$json = array(
				'status' => $status,
				'message' => $message,
			);
		}

		$this->response->setOutput(json_encode($json));
	}

	public function doBulkSearch() {
		$this->load->model('catalog/product');
		$this->load->model('openbay/amazonus_listing');
		$this->load->language('openbay/amazonus_bulk');

		$json = array();
		$search_data = array();

		if (!empty($this->request->post['product_ids'])) {
			foreach ($this->request->post['product_ids'] as $product_id) {
				$product = $this->model_catalog_product->getProduct($product_id);

				if (empty($product['sku'])) {
					$json[$product_id] = array(
						'error' => $this->language->get('error_product_sku')
					);
				}

				$key = '';

				$id_types = array('isbn', 'upc', 'ean', 'jan');

				foreach ($id_types as $id_type) {
					if (!empty($product[$id_type])) {
						$key = $id_type;
						break;
					}
				}

				if (!$key) {
					$json[$product_id] = array(
						'error' => $this->language->get('error_product_no_searchable_fields')
					);
				}

				if (!isset($json[$product_id])) {
					$search_data[$key][] = array(
						'product_id' => $product['product_id'],
						'value' => trim($product[$id_type]),
					);

					$json[$product_id] = array(
						'success' => $this->language->get('text_searching')
					);
				}
			}
		}

		if ($search_data) {
			$this->model_openbay_amazonus_listing->doBulkSearch($search_data);
		}

		$this->response->setOutput(json_encode($json));
	}

	public function bulkListProducts() {
		$this->load->model('openbay/amazonus');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		$data = $this->load->language('openbay/amazonus_bulk_listing');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_overview'),
		);

		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/bulkListProducts', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_bulk_listing'),
		);

		$pingInfo = simplexml_load_string($this->openbay->amazonus->callWithResponse('ping/info'));

		$bulk_listing_status = false;
		if ($pingInfo) {
			$bulk_listing_status = ((string)$pingInfo->BulkListing == 'true') ? true : false;
		}

		$data['bulk_listing_status'] = $bulk_listing_status;

		$data['link_overview'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] = $this->session->data['token'];

		if ($bulk_listing_status) {
			$data['link_search'] = $this->url->link('openbay/amazonus/doBulkSearch', 'token=' . $this->session->data['token'], 'SSL');

			$data['default_condition'] = $this->config->get('openbay_amazonus_listing_default_condition');
			$data['conditions'] = array(
				'New' => $this->language->get('text_new'),
				'UsedLikeNew' => $this->language->get('text_used_like_new'),
				'UsedVeryGood' => $this->language->get('text_used_very_good'),
				'UsedGood' => $this->language->get('text_used_good'),
				'UsedAcceptable' => $this->language->get('text_used_acceptable'),
				'CollectibleLikeNew' => $this->language->get('text_collectible_like_new'),
				'CollectibleVeryGood' => $this->language->get('text_collectible_very_good'),
				'CollectibleGood' => $this->language->get('text_collectible_good'),
				'CollectibleAcceptable' => $this->language->get('text_collectible_acceptable'),
				'Refurbished' => $this->language->get('text_refurbished'),
			);

			if (!empty($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}

			$data = array();

			$data['start'] = ($page - 1) * $this->config->get('config_limit_admin');
			$data['limit'] = $this->config->get('config_limit_admin');

			$results = $this->model_openbay_amazonus->getProductSearch($data);
			$product_total = $this->model_openbay_amazonus->getProductSearchTotal($data);

			$data['products'] = array();

			foreach ($results as $result) {
				$product = $this->model_catalog_product->getProduct($result['product_id']);

				if ($product['image'] && file_exists(DIR_IMAGE . $product['image'])) {
					$image = $this->model_tool_image->resize($product['image'], 40, 40);
				} else {
					$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}

				if ($result['status'] == 'searching') {
					$search_status = $this->language->get('text_searching');
				} else if ($result['status'] == 'finished') {
					$search_status = $this->language->get('text_finished');
				} else {
					$search_status = '-';
				}

				$href = $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $product['product_id'], 'SSL');

				$search_results = array();

				if ($result['data']) {
					foreach ($result['data'] as $search_result) {

						$link = 'https://www.amazon.com/dp/' . $search_result['asin'] . '/';

						$search_results[] = array(
							'title' => $search_result['title'],
							'asin' => $search_result['asin'],
							'href' => $link,
						);
					}
				}

				$data['products'][] = array(
					'product_id' => $product['product_id'],
					'href' => $href,
					'name' => $product['name'],
					'model' => $product['model'],
					'image' => $image,
					'matches' => $result['matches'],
					'search_status' => $search_status,
					'search_results' => $search_results,
				);
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_limit_admin');
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('openbay/amazonus/bulkListProducts', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

			$data['pagination'] = $pagination->render();
		}

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_bulk_listing.tpl', $data));
	}

	public function bulkLinking() {
		$this->load->model('openbay/amazonus');

		$data = $this->load->language('openbay/amazonus_bulk_linking');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('view/javascript/openbay/faq.js');

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_openbay'),
		);
		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_overview'),
		);

		$data['breadcrumbs'][] = array(
			'href'      => $this->url->link('openbay/amazonus/bulkLinking', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_bulk_linking'),
		);

		$pingInfo = simplexml_load_string($this->openbay->amazonus->callWithResponse('ping/info'));

		$bulk_linking_status = false;
		if ($pingInfo) {
			$bulk_linking_status = ((string)$pingInfo->BulkLinking == 'true') ? true : false;
		}

		$data['bulk_linking_status'] = $bulk_linking_status;

		$total_linked = $this->model_openbay_amazonus->getTotalUnlinkedItemsFromReport();

		if(isset($this->request->get['linked_item_page'])){
			$linked_item_page = (int)$this->request->get['linked_item_page'];
		}else{
			$linked_item_page = 1;
		}

		if(isset($this->request->get['linked_item_limit'])){
			$linked_item_limit = (int)$this->request->get['linked_item_limit'];
		}else{
			$linked_item_limit = 25;
		}

		$pagination = new Pagination();
		$pagination->total = $total_linked;
		$pagination->page = $linked_item_page;
		$pagination->limit = $linked_item_limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('openbay/amazonus/bulkLinking', 'token=' . $this->session->data['token'] . '&linked_item_page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$results = $this->model_openbay_amazonus->getUnlinkedItemsFromReport($linked_item_limit, $linked_item_page);

		$products = array();

		foreach ($results as $result) {
			$products[] = array(
				'asin' => $result['asin'],
				'href_amazon' => 'https://www.amazon.com/dp/' . $result['asin'] . '/',
				'amazon_sku' => $result['amazon_sku'],
				'amazon_quantity' => $result['amazon_quantity'],
				'amazon_price' => $result['amazon_price'],
				'name' => $result['name'],
				'sku' => $result['sku'],
				'quantity' => $result['quantity'],
				'combination' => $result['combination'],
				'product_id' => $result['product_id'],
				'var' => $result['var'],
				'href_product' => $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'], 'SSL'),
			);
		}

		$data['unlinked_products'] = $products;

		$data['href_load_listings'] = $this->url->link('openbay/amazonus/loadListingReport', 'token=' . $this->session->data['token'], 'SSL');
		$data['marketplace_processing'] = $this->config->get('openbay_amazonus_processing_listing_reports');
		$data['href_return'] = $this->url->link('openbay/amazonus/overview', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_do_bulk_linking'] = $this->url->link('openbay/amazonus/doBulkLinking', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['menu'] = $this->load->controller('common/menu');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('openbay/amazonus_bulk_linking.tpl', $data));
	}

	public function loadListingReport() {
		$this->load->model('openbay/amazonus');
		$this->load->model('setting/setting');
		$this->load->language('openbay/amazonus_bulk_linking');

		$this->model_openbay_amazonus->deleteListingReports();

		$request_data = array('response_url' => HTTPS_CATALOG . 'index.php?route=amazonus/listing_report');

		$response = $this->openbay->amazonus->callWithResponse('report/listing', $request_data);

		$response = json_decode($response, 1);

		$json = array();
		$json['status'] = $response['status'];

		if ($json['status']) {
			$json['message'] = $this->language->get('text_report_requested');

			$settings = $this->model_setting_setting->getSetting('openbay_amazonus');
			$settings['openbay_amazonus_processing_listing_reports'] = true;

			$this->model_setting_setting->editSetting('openbay_amazonus', $settings);
		} else {
			$json['message'] = $this->language->get('text_report_request_failed');
		}

		$this->response->setOutput(json_encode($json));
	}

	public function doBulkLinking() {
		$this->load->model('openbay/amazonus');

		$links = array();
		$amazonSkus = array();

		if (!empty($this->request->post['link'])) {
			foreach ($this->request->post['link'] as $link) {
				if (!empty($link['product_id'])) {
					$links[] = $link;
					$amazonSkus[] = $link['amazon_sku'];
				}
			}
		}

		if (!empty($links)) {
			foreach ($links as $link) {
				$this->model_openbay_amazonus->linkProduct($link['amazon_sku'], $link['product_id'], $link['var']);
			}

			$this->model_openbay_amazonus->updateAmazonSkusQuantities($amazonSkus);
		}
	}
}