<?php
class ControllerSettingSetting extends Controller {
	private $error = array();
 
	public function index() {
		$this->language->load('setting/setting'); 

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('config', $this->request->post);

			if ($this->config->get('config_currency_auto')) {
				$this->load->model('localisation/currency');
		
				$this->model_localisation_currency->updateCurrencies();
			}	
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_items'] = $this->language->get('text_items');
		$data['text_product'] = $this->language->get('text_product');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_stock'] = $this->language->get('text_stock');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_shipping'] = $this->language->get('text_shipping');	
		$data['text_payment'] = $this->language->get('text_payment');					
		$data['text_mail'] = $this->language->get('text_mail');
		$data['text_smtp'] = $this->language->get('text_smtp');
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_owner'] = $this->language->get('entry_owner');
		$data['entry_address'] = $this->language->get('entry_address');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_telephone'] = $this->language->get('entry_telephone');
		$data['entry_fax'] = $this->language->get('entry_fax');	
		$data['entry_location'] = $this->language->get('entry_location');
		$data['entry_locations'] = $this->language->get('entry_locations');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_template'] = $this->language->get('entry_template');
		$data['entry_country'] = $this->language->get('entry_country');
		$data['entry_zone'] = $this->language->get('entry_zone');		
		$data['entry_language'] = $this->language->get('entry_language');
		$data['entry_admin_language'] = $this->language->get('entry_admin_language');
		$data['entry_currency'] = $this->language->get('entry_currency');
		$data['entry_currency_auto'] = $this->language->get('entry_currency_auto');
		$data['entry_length_class'] = $this->language->get('entry_length_class');
		$data['entry_weight_class'] = $this->language->get('entry_weight_class');
		$data['entry_catalog_limit'] = $this->language->get('entry_catalog_limit');
		$data['entry_list_description_limit'] = $this->language->get('entry_list_description_limit');
		$data['entry_admin_limit'] = $this->language->get('entry_admin_limit');
		$data['entry_product_count'] = $this->language->get('entry_product_count');
		$data['entry_review'] = $this->language->get('entry_review');
		$data['entry_guest_review'] = $this->language->get('entry_guest_review');
		$data['entry_voucher_min'] = $this->language->get('entry_voucher_min');
		$data['entry_voucher_max'] = $this->language->get('entry_voucher_max');
		$data['entry_tax'] = $this->language->get('entry_tax');
		$data['entry_tax_default'] = $this->language->get('entry_tax_default');
		$data['entry_tax_customer'] = $this->language->get('entry_tax_customer');
		$data['entry_customer_online'] = $this->language->get('entry_customer_online');
		$data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$data['entry_customer_group_display'] = $this->language->get('entry_customer_group_display');
		$data['entry_customer_price'] = $this->language->get('entry_customer_price');
		$data['entry_account'] = $this->language->get('entry_account');
		$data['entry_cart_weight'] = $this->language->get('entry_cart_weight');		
		$data['entry_guest_checkout'] = $this->language->get('entry_guest_checkout');
		$data['entry_checkout'] = $this->language->get('entry_checkout');		
		$data['entry_order_edit'] = $this->language->get('entry_order_edit');
		$data['entry_invoice_prefix'] = $this->language->get('entry_invoice_prefix');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_complete_status'] = $this->language->get('entry_complete_status');	
		$data['entry_stock_display'] = $this->language->get('entry_stock_display');
		$data['entry_stock_warning'] = $this->language->get('entry_stock_warning');
		$data['entry_stock_checkout'] = $this->language->get('entry_stock_checkout');
		$data['entry_stock_status'] = $this->language->get('entry_stock_status');
		$data['entry_affiliate'] = $this->language->get('entry_affiliate');
		$data['entry_commission'] = $this->language->get('entry_commission');
		$data['entry_return'] = $this->language->get('entry_return');
		$data['entry_return_status'] = $this->language->get('entry_return_status');
		$data['entry_logo'] = $this->language->get('entry_logo');
		$data['entry_icon'] = $this->language->get('entry_icon');
		$data['entry_image_category'] = $this->language->get('entry_image_category');
		$data['entry_image_thumb'] = $this->language->get('entry_image_thumb');
		$data['entry_image_popup'] = $this->language->get('entry_image_popup');
		$data['entry_image_product'] = $this->language->get('entry_image_product');
		$data['entry_image_additional'] = $this->language->get('entry_image_additional');
		$data['entry_image_related'] = $this->language->get('entry_image_related');
		$data['entry_image_compare'] = $this->language->get('entry_image_compare');
		$data['entry_image_wishlist'] = $this->language->get('entry_image_wishlist');
		$data['entry_image_cart'] = $this->language->get('entry_image_cart');	
		$data['entry_image_location'] = $this->language->get('entry_image_location');	
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');	
		$data['entry_ftp_host'] = $this->language->get('entry_ftp_host');
		$data['entry_ftp_port'] = $this->language->get('entry_ftp_port');
		$data['entry_ftp_username'] = $this->language->get('entry_ftp_username');
		$data['entry_ftp_password'] = $this->language->get('entry_ftp_password');
		$data['entry_ftp_root'] = $this->language->get('entry_ftp_root');
		$data['entry_ftp_status'] = $this->language->get('entry_ftp_status');
		$data['entry_mail_protocol'] = $this->language->get('entry_mail_protocol');
		$data['entry_mail_parameter'] = $this->language->get('entry_mail_parameter');
		$data['entry_smtp_host'] = $this->language->get('entry_smtp_host');
		$data['entry_smtp_username'] = $this->language->get('entry_smtp_username');
		$data['entry_smtp_password'] = $this->language->get('entry_smtp_password');
		$data['entry_smtp_port'] = $this->language->get('entry_smtp_port');
		$data['entry_smtp_timeout'] = $this->language->get('entry_smtp_timeout');
		$data['entry_alert_mail'] = $this->language->get('entry_alert_mail');
		$data['entry_account_mail'] = $this->language->get('entry_account_mail');
		$data['entry_review_mail'] = $this->language->get('entry_review_mail');
		$data['entry_alert_emails'] = $this->language->get('entry_alert_emails');
		$data['entry_fraud_detection'] = $this->language->get('entry_fraud_detection');
		$data['entry_fraud_key'] = $this->language->get('entry_fraud_key');
		$data['entry_fraud_score'] = $this->language->get('entry_fraud_score');
		$data['entry_fraud_status'] = $this->language->get('entry_fraud_status');
		$data['entry_secure'] = $this->language->get('entry_secure');
		$data['entry_shared'] = $this->language->get('entry_shared');
		$data['entry_robots'] = $this->language->get('entry_robots');
		$data['entry_image_file_size'] = $this->language->get('entry_image_file_size');
		$data['entry_file_extension_allowed'] = $this->language->get('entry_file_extension_allowed');
		$data['entry_file_mime_allowed'] = $this->language->get('entry_file_mime_allowed');		
		$data['entry_maintenance'] = $this->language->get('entry_maintenance');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['entry_encryption'] = $this->language->get('entry_encryption');
		$data['entry_seo_url'] = $this->language->get('entry_seo_url');
		$data['entry_compression'] = $this->language->get('entry_compression');
		$data['entry_error_display'] = $this->language->get('entry_error_display');
		$data['entry_error_log'] = $this->language->get('entry_error_log');
		$data['entry_error_filename'] = $this->language->get('entry_error_filename');
		$data['entry_google_analytics'] = $this->language->get('entry_google_analytics');
		
		$data['help_location'] = $this->language->get('help_location');
		$data['help_locations'] = $this->language->get('help_locations');
		$data['help_currency'] = $this->language->get('help_currency');
		$data['help_currency_auto'] = $this->language->get('help_currency_auto');
		$data['help_catalog_limit'] = $this->language->get('help_catalog_limit');
		$data['help_list_description_limit'] = $this->language->get('help_list_description_limit');
		$data['help_admin_limit'] = $this->language->get('help_admin_limit');
		$data['help_product_count'] = $this->language->get('help_product_count');
		$data['help_review'] = $this->language->get('help_review');
		$data['help_guest_review'] = $this->language->get('help_guest_review');
		$data['help_voucher_min'] = $this->language->get('help_voucher_min');
		$data['help_voucher_max'] = $this->language->get('help_voucher_max');
		$data['help_tax_default'] = $this->language->get('help_tax_default');
		$data['help_tax_customer'] = $this->language->get('help_tax_customer');
		$data['help_customer_online'] = $this->language->get('help_customer_online');
		$data['help_customer_group'] = $this->language->get('help_customer_group');
		$data['help_customer_group_display'] = $this->language->get('help_customer_group_display');
		$data['help_customer_price'] = $this->language->get('help_customer_price');
		$data['help_account'] = $this->language->get('help_account');
		$data['help_cart_weight'] = $this->language->get('help_cart_weight');
		$data['help_guest_checkout'] = $this->language->get('help_guest_checkout');
		$data['help_checkout'] = $this->language->get('help_checkout');
		$data['help_order_edit'] = $this->language->get('help_order_edit');
		$data['help_invoice_prefix'] = $this->language->get('help_invoice_prefix');
		$data['help_order_status'] = $this->language->get('help_order_status');
		$data['help_complete_status'] = $this->language->get('help_complete_status');
		$data['help_stock_display'] = $this->language->get('help_stock_display');
		$data['help_stock_warning'] = $this->language->get('help_stock_warning');
		$data['help_stock_checkout'] = $this->language->get('help_stock_checkout');
		$data['help_stock_status'] = $this->language->get('help_stock_status');
		$data['help_affiliate'] = $this->language->get('help_affiliate');
		$data['help_commission'] = $this->language->get('help_commission');
		$data['help_return'] = $this->language->get('help_return');
		$data['help_return_status'] = $this->language->get('help_return_status');
		$data['help_icon'] = $this->language->get('help_icon');
		$data['help_ftp_root'] = $this->language->get('help_ftp_root');
		$data['help_mail_protocol'] = $this->language->get('help_mail_protocol');
		$data['help_mail_parameter'] = $this->language->get('help_mail_parameter');
		$data['help_account_mail'] = $this->language->get('help_account_mail');
		$data['help_alert_mail'] = $this->language->get('help_alert_mail');
		$data['help_review_mail'] = $this->language->get('help_review_mail');
		$data['help_alert_emails'] = $this->language->get('help_alert_emails');
		$data['help_fraud_detection'] = $this->language->get('help_fraud_detection');
		$data['help_fraud_score'] = $this->language->get('help_fraud_score');
		$data['help_fraud_status'] = $this->language->get('help_fraud_status');
		$data['help_secure'] = $this->language->get('help_secure');
		$data['help_shared'] = $this->language->get('help_shared');
		$data['help_robots'] = $this->language->get('help_robots');
		$data['help_seo_url'] = $this->language->get('help_seo_url');
		$data['help_image_file_size'] = $this->language->get('help_image_file_size');
		$data['help_file_extension_allowed'] = $this->language->get('help_file_extension_allowed');
		$data['help_file_mime_allowed'] = $this->language->get('help_file_mime_allowed');
		$data['help_maintenance'] = $this->language->get('help_maintenance');
		$data['help_password'] = $this->language->get('help_password');
		$data['help_encryption'] = $this->language->get('help_encryption');
		$data['help_compression'] = $this->language->get('help_compression');
		$data['help_google_analytics'] = $this->language->get('help_google_analytics');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_store'] = $this->language->get('tab_store');
		$data['tab_local'] = $this->language->get('tab_local');
		$data['tab_option'] = $this->language->get('tab_option');
		$data['tab_image'] = $this->language->get('tab_image');
		$data['tab_ftp'] = $this->language->get('tab_ftp');
		$data['tab_mail'] = $this->language->get('tab_mail');
		$data['tab_fraud'] = $this->language->get('tab_fraud');
		$data['tab_server'] = $this->language->get('tab_server');

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
 		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}
		
 		if (isset($this->error['owner'])) {
			$data['error_owner'] = $this->error['owner'];
		} else {
			$data['error_owner'] = '';
		}
		
		if (isset($this->error['address_1'])) {
			$data['error_address'] = $this->error['address'];
		} else {
			$data['error_address'] = '';
		}
		
 		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}
 
  		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = '';
		}
		
		if (isset($this->error['country'])) {
			$data['error_country'] = $this->error['country'];
		} else {
			$data['error_country'] = '';
		}
		
		if (isset($this->error['zone'])) {
			$data['error_zone'] = $this->error['zone'];
		} else {
			$data['error_zone'] = '';
		}
				
  		if (isset($this->error['customer_group_display'])) {
			$data['error_customer_group_display'] = $this->error['customer_group_display'];
		} else {
			$data['error_customer_group_display'] = '';
		}
				
  		if (isset($this->error['voucher_min'])) {
			$data['error_voucher_min'] = $this->error['voucher_min'];
		} else {
			$data['error_voucher_min'] = '';
		}	
			
  		if (isset($this->error['voucher_max'])) {
			$data['error_voucher_max'] = $this->error['voucher_max'];
		} else {
			$data['error_voucher_max'] = '';
		}
		
 		if (isset($this->error['ftp_host'])) {
			$data['error_ftp_host'] = $this->error['ftp_host'];
		} else {
			$data['error_ftp_host'] = '';
		}
		
 		if (isset($this->error['ftp_port'])) {
			$data['error_ftp_port'] = $this->error['ftp_port'];
		} else {
			$data['error_ftp_port'] = '';
		}
		
 		if (isset($this->error['ftp_username'])) {
			$data['error_ftp_username'] = $this->error['ftp_username'];
		} else {
			$data['error_ftp_username'] = '';
		}
		
 		if (isset($this->error['ftp_password'])) {
			$data['error_ftp_password'] = $this->error['ftp_password'];
		} else {
			$data['error_ftp_password'] = '';
		}
														
 		if (isset($this->error['image_category'])) {
			$data['error_image_category'] = $this->error['image_category'];
		} else {
			$data['error_image_category'] = '';
		}
				
 		if (isset($this->error['image_thumb'])) {
			$data['error_image_thumb'] = $this->error['image_thumb'];
		} else {
			$data['error_image_thumb'] = '';
		}
		
 		if (isset($this->error['image_popup'])) {
			$data['error_image_popup'] = $this->error['image_popup'];
		} else {
			$data['error_image_popup'] = '';
		}
		
 		if (isset($this->error['image_product'])) {
			$data['error_image_product'] = $this->error['image_product'];
		} else {
			$data['error_image_product'] = '';
		}
		
 		if (isset($this->error['image_additional'])) {
			$data['error_image_additional'] = $this->error['image_additional'];
		} else {
			$data['error_image_additional'] = '';
		}	
		
 		if (isset($this->error['image_related'])) {
			$data['error_image_related'] = $this->error['image_related'];
		} else {
			$data['error_image_related'] = '';
		}
		
 		if (isset($this->error['image_compare'])) {
			$data['error_image_compare'] = $this->error['image_compare'];
		} else {
			$data['error_image_compare'] = '';
		}
		
  		if (isset($this->error['image_wishlist'])) {
			$data['error_image_wishlist'] = $this->error['image_wishlist'];
		} else {
			$data['error_image_wishlist'] = '';
		}
				
		if (isset($this->error['image_cart'])) {
			$data['error_image_cart'] = $this->error['image_cart'];
		} else {
			$data['error_image_cart'] = '';
		}
		
 		if (isset($this->error['image_location'])) {
			$data['error_image_location'] = $this->error['image_location'];
		} else {
			$data['error_image_location'] = '';
		}
						
		if (isset($this->error['error_filename'])) {
			$data['error_error_filename'] = $this->error['error_filename'];
		} else {
			$data['error_error_filename'] = '';
		}
		
		if (isset($this->error['catalog_limit'])) {
			$data['error_catalog_limit'] = $this->error['catalog_limit'];
		} else {
			$data['error_catalog_limit'] = '';
		}
		
		if (isset($this->error['list_description_limit'])) {
			$data['error_list_description_limit'] = $this->error['list_description_limit'];
		} else {
			$data['error_list_description_limit'] = '';
		}
		
		if (isset($this->error['admin_limit'])) {
			$data['error_admin_limit'] = $this->error['admin_limit'];
		} else {
			$data['error_admin_limit'] = '';
		}
		
		if (isset($this->error['encryption'])) {
			$data['error_encryption'] = $this->error['encryption'];
		} else {
			$data['error_encryption'] = '';
		}		
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$data['breadcrumbs'][] = array(
       		'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL')
   		);
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['action'] = $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['config_name'])) {
			$data['config_name'] = $this->request->post['config_name'];
		} else {
			$data['config_name'] = $this->config->get('config_name');
		}
		
		if (isset($this->request->post['config_owner'])) {
			$data['config_owner'] = $this->request->post['config_owner'];
		} else {
			$data['config_owner'] = $this->config->get('config_owner');
		}
		
		if (isset($this->request->post['config_address_1'])) {
			$data['config_address'] = $this->request->post['config_address'];
		} else {
			$data['config_address'] = $this->config->get('config_address');
		}
		
		if (isset($this->request->post['config_email'])) {
			$data['config_email'] = $this->request->post['config_email'];
		} else {
			$data['config_email'] = $this->config->get('config_email');
		}
		
		if (isset($this->request->post['config_telephone'])) {
			$data['config_telephone'] = $this->request->post['config_telephone'];
		} else {
			$data['config_telephone'] = $this->config->get('config_telephone');
		}

		if (isset($this->request->post['config_fax'])) {
			$data['config_fax'] = $this->request->post['config_fax'];
		} else {
			$data['config_fax'] = $this->config->get('config_fax');
		}	
		
		$this->load->model('localisation/location');
		
		$data['locations'] = $this->model_localisation_location->getLocations();
		
		if (isset($this->request->post['config_location_id'])) {
			$data['config_location_id'] = $this->request->post['config_location_id'];
		} else {
			$data['config_location_id'] = $this->config->get('config_location_id');
		}
		
		if (isset($this->request->post['config_location'])) {
			$data['config_location'] = $this->request->post['config_location'];
		} elseif ($this->config->get('config_location')) {
			$data['config_location'] = $this->config->get('config_location');
		} else {
			$data['config_location'] = array();			
		}		
						
		if (isset($this->request->post['config_title'])) {
			$data['config_title'] = $this->request->post['config_title'];
		} else {
			$data['config_title'] = $this->config->get('config_title');
		}
		
		if (isset($this->request->post['config_meta_description'])) {
			$data['config_meta_description'] = $this->request->post['config_meta_description'];
		} else {
			$data['config_meta_description'] = $this->config->get('config_meta_description');
		}
		
		if (isset($this->request->post['config_layout_id'])) {
			$data['config_layout_id'] = $this->request->post['config_layout_id'];
		} else {
			$data['config_layout_id'] = $this->config->get('config_layout_id');
		}
				
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
				
		if (isset($this->request->post['config_template'])) {
			$data['config_template'] = $this->request->post['config_template'];
		} else {
			$data['config_template'] = $this->config->get('config_template');
		}
		
		$data['templates'] = array();

		$directories = glob(DIR_CATALOG . 'view/theme/*', GLOB_ONLYDIR);
		
		foreach ($directories as $directory) {
			$data['templates'][] = basename($directory);
		}					

		if (isset($this->request->post['config_country_id'])) {
			$data['config_country_id'] = $this->request->post['config_country_id'];
		} else {
			$data['config_country_id'] = $this->config->get('config_country_id');
		}
		
		$this->load->model('localisation/country');
		
		$data['countries'] = $this->model_localisation_country->getCountries();

		if (isset($this->request->post['config_zone_id'])) {
			$data['config_zone_id'] = $this->request->post['config_zone_id'];
		} else {
			$data['config_zone_id'] = $this->config->get('config_zone_id');
		}	
						
		if (isset($this->request->post['config_language'])) {
			$data['config_language'] = $this->request->post['config_language'];
		} else {
			$data['config_language'] = $this->config->get('config_language');
		}

		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
				
		if (isset($this->request->post['config_admin_language'])) {
			$data['config_admin_language'] = $this->request->post['config_admin_language'];
		} else {
			$data['config_admin_language'] = $this->config->get('config_admin_language');
		}

		if (isset($this->request->post['config_currency'])) {
			$data['config_currency'] = $this->request->post['config_currency'];
		} else {
			$data['config_currency'] = $this->config->get('config_currency');
		}

		if (isset($this->request->post['config_currency_auto'])) {
			$data['config_currency_auto'] = $this->request->post['config_currency_auto'];
		} else {
			$data['config_currency_auto'] = $this->config->get('config_currency_auto');
		}
		
		$this->load->model('localisation/currency');
		
		$data['currencies'] = $this->model_localisation_currency->getCurrencies();
		
		if (isset($this->request->post['config_length_class_id'])) {
			$data['config_length_class_id'] = $this->request->post['config_length_class_id'];
		} else {
			$data['config_length_class_id'] = $this->config->get('config_length_class_id');
		}
		
		$this->load->model('localisation/length_class');
		
		$data['length_classes'] = $this->model_localisation_length_class->getLengthClasses();
		
		if (isset($this->request->post['config_weight_class_id'])) {
			$data['config_weight_class_id'] = $this->request->post['config_weight_class_id'];
		} else {
			$data['config_weight_class_id'] = $this->config->get('config_weight_class_id');
		}
		
		$this->load->model('localisation/weight_class');
		
		$data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();
	
		if (isset($this->request->post['config_catalog_limit'])) {
			$data['config_catalog_limit'] = $this->request->post['config_catalog_limit'];
		} else {
			$data['config_catalog_limit'] = $this->config->get('config_catalog_limit');
		}	
	
		if (isset($this->request->post['config_list_description_limit'])) {
			$data['config_list_description_limit'] = $this->request->post['config_list_description_limit'];
		} else {
			$data['config_list_description_limit'] = $this->config->get('config_list_description_limit');
		}	
						
		if (isset($this->request->post['config_admin_limit'])) {
			$data['config_admin_limit'] = $this->request->post['config_admin_limit'];
		} else {
			$data['config_admin_limit'] = $this->config->get('config_admin_limit');
		}
		
		if (isset($this->request->post['config_product_count'])) {
			$data['config_product_count'] = $this->request->post['config_product_count'];
		} else {
			$data['config_product_count'] = $this->config->get('config_product_count');
		}
				
		if (isset($this->request->post['config_review_status'])) {
			$data['config_review_status'] = $this->request->post['config_review_status'];
		} else {
			$data['config_review_status'] = $this->config->get('config_review_status');
		}
				
		if (isset($this->request->post['config_guest_review'])) {
			$data['config_guest_review'] = $this->request->post['config_guest_review'];
		} else {
			$data['config_guest_review'] = $this->config->get('config_guest_review');
		}
		
		if (isset($this->request->post['config_voucher_min'])) {
			$data['config_voucher_min'] = $this->request->post['config_voucher_min'];
		} else {
			$data['config_voucher_min'] = $this->config->get('config_voucher_min');
		}	
		
		if (isset($this->request->post['config_voucher_max'])) {
			$data['config_voucher_max'] = $this->request->post['config_voucher_max'];
		} else {
			$data['config_voucher_max'] = $this->config->get('config_voucher_max');
		}				
		
		if (isset($this->request->post['config_tax'])) {
			$data['config_tax'] = $this->request->post['config_tax'];
		} else {
			$data['config_tax'] = $this->config->get('config_tax');			
		}
		
		if (isset($this->request->post['config_vat'])) {
			$data['config_vat'] = $this->request->post['config_vat'];
		} else {
			$data['config_vat'] = $this->config->get('config_vat');			
		}
				
		if (isset($this->request->post['config_tax_default'])) {
			$data['config_tax_default'] = $this->request->post['config_tax_default'];
		} else {
			$data['config_tax_default'] = $this->config->get('config_tax_default');			
		}	
			
		if (isset($this->request->post['config_tax_customer'])) {
			$data['config_tax_customer'] = $this->request->post['config_tax_customer'];
		} else {
			$data['config_tax_customer'] = $this->config->get('config_tax_customer');			
		}	
		
		if (isset($this->request->post['config_customer_online'])) {
			$data['config_customer_online'] = $this->request->post['config_customer_online'];
		} else {
			$data['config_customer_online'] = $this->config->get('config_customer_online');			
		}
						
		if (isset($this->request->post['config_customer_group_id'])) {
			$data['config_customer_group_id'] = $this->request->post['config_customer_group_id'];
		} else {
			$data['config_customer_group_id'] = $this->config->get('config_customer_group_id');			
		}
		
		$this->load->model('sale/customer_group');
		
		$data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();

		if (isset($this->request->post['config_customer_group_display'])) {
			$data['config_customer_group_display'] = $this->request->post['config_customer_group_display'];
		} elseif ($this->config->get('config_customer_group_display')) {
			$data['config_customer_group_display'] = $this->config->get('config_customer_group_display');	
		} else {
			$data['config_customer_group_display'] = array();			
		}
								
		if (isset($this->request->post['config_customer_price'])) {
			$data['config_customer_price'] = $this->request->post['config_customer_price'];
		} else {
			$data['config_customer_price'] = $this->config->get('config_customer_price');			
		}
						
		if (isset($this->request->post['config_account_id'])) {
			$data['config_account_id'] = $this->request->post['config_account_id'];
		} else {
			$data['config_account_id'] = $this->config->get('config_account_id');			
		}
				
		$this->load->model('catalog/information');
		
		$data['informations'] = $this->model_catalog_information->getInformations();
								
		if (isset($this->request->post['config_cart_weight'])) {
			$data['config_cart_weight'] = $this->request->post['config_cart_weight'];
		} else {
			$data['config_cart_weight'] = $this->config->get('config_cart_weight');
		}							
						
		if (isset($this->request->post['config_guest_checkout'])) {
			$data['config_guest_checkout'] = $this->request->post['config_guest_checkout'];
		} else {
			$data['config_guest_checkout'] = $this->config->get('config_guest_checkout');		
		}

		if (isset($this->request->post['config_checkout_id'])) {
			$data['config_checkout_id'] = $this->request->post['config_checkout_id'];
		} else {
			$data['config_checkout_id'] = $this->config->get('config_checkout_id');		
		}

		if (isset($this->request->post['config_order_edit'])) {
			$data['config_order_edit'] = $this->request->post['config_order_edit'];
		} elseif ($this->config->get('config_order_edit')) {
			$data['config_order_edit'] = $this->config->get('config_order_edit');			
		} else {
			$data['config_order_edit'] = 7;
		}
									
		if (isset($this->request->post['config_invoice_prefix'])) {
			$data['config_invoice_prefix'] = $this->request->post['config_invoice_prefix'];
		} elseif ($this->config->get('config_invoice_prefix')) {
			$data['config_invoice_prefix'] = $this->config->get('config_invoice_prefix');			
		} else {
			$data['config_invoice_prefix'] = 'INV-' . date('Y') . '-00';
		}
		
		if (isset($this->request->post['config_order_status_id'])) {
			$data['config_order_status_id'] = $this->request->post['config_order_status_id'];
		} else {
			$data['config_order_status_id'] = $this->config->get('config_order_status_id');		
		}
		
		if (isset($this->request->post['config_complete_status_id'])) {
			$data['config_complete_status_id'] = $this->request->post['config_complete_status_id'];
		} else {
			$data['config_complete_status_id'] = $this->config->get('config_complete_status_id');
		}	
		
		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();	

		if (isset($this->request->post['config_stock_display'])) {
			$data['config_stock_display'] = $this->request->post['config_stock_display'];
		} else {
			$data['config_stock_display'] = $this->config->get('config_stock_display');			
		}
		
		if (isset($this->request->post['config_stock_warning'])) {
			$data['config_stock_warning'] = $this->request->post['config_stock_warning'];
		} else {
			$data['config_stock_warning'] = $this->config->get('config_stock_warning');		
		}

		if (isset($this->request->post['config_stock_checkout'])) {
			$data['config_stock_checkout'] = $this->request->post['config_stock_checkout'];
		} else {
			$data['config_stock_checkout'] = $this->config->get('config_stock_checkout');		
		}

		if (isset($this->request->post['config_stock_status_id'])) {
			$data['config_stock_status_id'] = $this->request->post['config_stock_status_id'];
		} else {
			$data['config_stock_status_id'] = $this->config->get('config_stock_status_id');			
		}
		
		$this->load->model('localisation/stock_status');
		
		$data['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();

		if (isset($this->request->post['config_affiliate_id'])) {
			$data['config_affiliate_id'] = $this->request->post['config_affiliate_id'];
		} else {
			$data['config_affiliate_id'] = $this->config->get('config_affiliate_id');		
		}
		
		if (isset($this->request->post['config_commission'])) {
			$data['config_commission'] = $this->request->post['config_commission'];
		} elseif ($this->config->has('config_commission')) {
			$data['config_commission'] = $this->config->get('config_commission');		
		} else {
			$data['config_commission'] = '5.00';
		}

		if (isset($this->request->post['config_return_id'])) {
			$data['config_return_id'] = $this->request->post['config_return_id'];
		} else {
			$data['config_return_id'] = $this->config->get('config_return_id');		
		}
						
		if (isset($this->request->post['config_return_status_id'])) {
			$data['config_return_status_id'] = $this->request->post['config_return_status_id'];
		} else {
			$data['config_return_status_id'] = $this->config->get('config_return_status_id');		
		}
		
		$this->load->model('localisation/return_status');
		
		$data['return_statuses'] = $this->model_localisation_return_status->getReturnStatuses();	
			
		$this->load->model('tool/image');

		if (isset($this->request->post['config_logo'])) {
			$data['config_logo'] = $this->request->post['config_logo'];
		} else {
			$data['config_logo'] = $this->config->get('config_logo');			
		}

		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo')) && is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $this->model_tool_image->resize($this->config->get('config_logo'), 100, 100);		
		} else {
			$data['logo'] = '';
		}

		if (isset($this->request->post['config_icon'])) {
			$data['config_icon'] = $this->request->post['config_icon'];
		} else {
			$data['config_icon'] = $this->config->get('config_icon');			
		}
		
		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon')) && is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$data['icon'] = $this->model_tool_image->resize($this->config->get('config_icon'), 100, 100);		
		} else {
			$data['icon'] = '';
		}

		if (isset($this->request->post['config_image_category_width'])) {
			$data['config_image_category_width'] = $this->request->post['config_image_category_width'];
		} else {
			$data['config_image_category_width'] = $this->config->get('config_image_category_width');
		}
		
		if (isset($this->request->post['config_image_category_height'])) {
			$data['config_image_category_height'] = $this->request->post['config_image_category_height'];
		} else {
			$data['config_image_category_height'] = $this->config->get('config_image_category_height');
		}
				
		if (isset($this->request->post['config_image_thumb_width'])) {
			$data['config_image_thumb_width'] = $this->request->post['config_image_thumb_width'];
		} else {
			$data['config_image_thumb_width'] = $this->config->get('config_image_thumb_width');
		}
		
		if (isset($this->request->post['config_image_thumb_height'])) {
			$data['config_image_thumb_height'] = $this->request->post['config_image_thumb_height'];
		} else {
			$data['config_image_thumb_height'] = $this->config->get('config_image_thumb_height');
		}
		
		if (isset($this->request->post['config_image_popup_width'])) {
			$data['config_image_popup_width'] = $this->request->post['config_image_popup_width'];
		} else {
			$data['config_image_popup_width'] = $this->config->get('config_image_popup_width');
		}
		
		if (isset($this->request->post['config_image_popup_height'])) {
			$data['config_image_popup_height'] = $this->request->post['config_image_popup_height'];
		} else {
			$data['config_image_popup_height'] = $this->config->get('config_image_popup_height');
		}
		
		if (isset($this->request->post['config_image_product_width'])) {
			$data['config_image_product_width'] = $this->request->post['config_image_product_width'];
		} else {
			$data['config_image_product_width'] = $this->config->get('config_image_product_width');
		}
		
		if (isset($this->request->post['config_image_product_height'])) {
			$data['config_image_product_height'] = $this->request->post['config_image_product_height'];
		} else {
			$data['config_image_product_height'] = $this->config->get('config_image_product_height');
		}

		if (isset($this->request->post['config_image_additional_width'])) {
			$data['config_image_additional_width'] = $this->request->post['config_image_additional_width'];
		} else {
			$data['config_image_additional_width'] = $this->config->get('config_image_additional_width');
		}
		
		if (isset($this->request->post['config_image_additional_height'])) {
			$data['config_image_additional_height'] = $this->request->post['config_image_additional_height'];
		} else {
			$data['config_image_additional_height'] = $this->config->get('config_image_additional_height');
		}
		
		if (isset($this->request->post['config_image_related_width'])) {
			$data['config_image_related_width'] = $this->request->post['config_image_related_width'];
		} else {
			$data['config_image_related_width'] = $this->config->get('config_image_related_width');
		}
		
		if (isset($this->request->post['config_image_related_height'])) {
			$data['config_image_related_height'] = $this->request->post['config_image_related_height'];
		} else {
			$data['config_image_related_height'] = $this->config->get('config_image_related_height');
		}
		
		if (isset($this->request->post['config_image_compare_width'])) {
			$data['config_image_compare_width'] = $this->request->post['config_image_compare_width'];
		} else {
			$data['config_image_compare_width'] = $this->config->get('config_image_compare_width');
		}
		
		if (isset($this->request->post['config_image_compare_height'])) {
			$data['config_image_compare_height'] = $this->request->post['config_image_compare_height'];
		} else {
			$data['config_image_compare_height'] = $this->config->get('config_image_compare_height');
		}	
		
		if (isset($this->request->post['config_image_wishlist_width'])) {
			$data['config_image_wishlist_width'] = $this->request->post['config_image_wishlist_width'];
		} else {
			$data['config_image_wishlist_width'] = $this->config->get('config_image_wishlist_width');
		}
		
		if (isset($this->request->post['config_image_wishlist_height'])) {
			$data['config_image_wishlist_height'] = $this->request->post['config_image_wishlist_height'];
		} else {
			$data['config_image_wishlist_height'] = $this->config->get('config_image_wishlist_height');
		}	
						
		if (isset($this->request->post['config_image_cart_width'])) {
			$data['config_image_cart_width'] = $this->request->post['config_image_cart_width'];
		} else {
			$data['config_image_cart_width'] = $this->config->get('config_image_cart_width');
		}
		
		if (isset($this->request->post['config_image_cart_height'])) {
			$data['config_image_cart_height'] = $this->request->post['config_image_cart_height'];
		} else {
			$data['config_image_cart_height'] = $this->config->get('config_image_cart_height');
		}		
		
		if (isset($this->request->post['config_image_location_width'])) {
			$data['config_image_location_width'] = $this->request->post['config_image_location_width'];
		} else {
			$data['config_image_location_width'] = $this->config->get('config_image_location_width');
		}
		
		if (isset($this->request->post['config_image_location_height'])) {
			$data['config_image_location_height'] = $this->request->post['config_image_location_height'];
		} else {
			$data['config_image_location_height'] = $this->config->get('config_image_location_height');
		}
						
		if (isset($this->request->post['config_ftp_host'])) {
			$data['config_ftp_host'] = $this->request->post['config_ftp_host'];
		} elseif ($this->config->get('config_ftp_host')) {
			$data['config_ftp_host'] = $this->config->get('config_ftp_host');		
		} else {
			$data['config_ftp_host'] = str_replace('www.', '', $this->request->server['HTTP_HOST']);
		}
		
		if (isset($this->request->post['config_ftp_port'])) {
			$data['config_ftp_port'] = $this->request->post['config_ftp_port'];
		} elseif ($this->config->get('config_ftp_port')) {
			$data['config_ftp_port'] = $this->config->get('config_ftp_port');
		} else {
			$data['config_ftp_port'] = 21;
		}
		
		if (isset($this->request->post['config_ftp_username'])) {
			$data['config_ftp_username'] = $this->request->post['config_ftp_username'];
		} else {
			$data['config_ftp_username'] = $this->config->get('config_ftp_username');
		}
		
		if (isset($this->request->post['config_ftp_password'])) {
			$data['config_ftp_password'] = $this->request->post['config_ftp_password'];
		} else {
			$data['config_ftp_password'] = $this->config->get('config_ftp_password');
		}
		
		if (isset($this->request->post['config_ftp_root'])) {
			$data['config_ftp_root'] = $this->request->post['config_ftp_root'];
		} else {
			$data['config_ftp_root'] = $this->config->get('config_ftp_root');
		}
		
		if (isset($this->request->post['config_ftp_status'])) {
			$data['config_ftp_status'] = $this->request->post['config_ftp_status'];
		} else {
			$data['config_ftp_status'] = $this->config->get('config_ftp_status');
		}
												
		if (isset($this->request->post['config_mail_protocol'])) {
			$data['config_mail_protocol'] = $this->request->post['config_mail_protocol'];
		} else {
			$data['config_mail_protocol'] = $this->config->get('config_mail_protocol');
		}
		
		if (isset($this->request->post['config_mail_parameter'])) {
			$data['config_mail_parameter'] = $this->request->post['config_mail_parameter'];
		} else {
			$data['config_mail_parameter'] = $this->config->get('config_mail_parameter');
		}
				
		if (isset($this->request->post['config_smtp_host'])) {
			$data['config_smtp_host'] = $this->request->post['config_smtp_host'];
		} else {
			$data['config_smtp_host'] = $this->config->get('config_smtp_host');
		}		

		if (isset($this->request->post['config_smtp_username'])) {
			$data['config_smtp_username'] = $this->request->post['config_smtp_username'];
		} else {
			$data['config_smtp_username'] = $this->config->get('config_smtp_username');
		}	
		
		if (isset($this->request->post['config_smtp_password'])) {
			$data['config_smtp_password'] = $this->request->post['config_smtp_password'];
		} else {
			$data['config_smtp_password'] = $this->config->get('config_smtp_password');
		}	
		
		if (isset($this->request->post['config_smtp_port'])) {
			$data['config_smtp_port'] = $this->request->post['config_smtp_port'];
		} elseif ($this->config->get('config_smtp_port')) {
			$data['config_smtp_port'] = $this->config->get('config_smtp_port');
		} else {
			$data['config_smtp_port'] = 25;
		}	
		
		if (isset($this->request->post['config_smtp_timeout'])) {
			$data['config_smtp_timeout'] = $this->request->post['config_smtp_timeout'];
		} elseif ($this->config->get('config_smtp_timeout')) {
			$data['config_smtp_timeout'] = $this->config->get('config_smtp_timeout');
		} else {
			$data['config_smtp_timeout'] = 5;	
		}	
		
		if (isset($this->request->post['config_alert_mail'])) {
			$data['config_alert_mail'] = $this->request->post['config_alert_mail'];
		} else {
			$data['config_alert_mail'] = $this->config->get('config_alert_mail');
		}

		if (isset($this->request->post['config_account_mail'])) {
			$data['config_account_mail'] = $this->request->post['config_account_mail'];
		} else {
			$data['config_account_mail'] = $this->config->get('config_account_mail');
		}

		if (isset($this->request->post['config_review_mail'])) {
			$data['config_review_mail'] = $this->request->post['config_review_mail'];
		} else {
			$data['config_review_mail'] = $this->config->get('config_review_mail');
		}
		
		if (isset($this->request->post['config_alert_emails'])) {
			$data['config_alert_emails'] = $this->request->post['config_alert_emails'];
		} else {
			$data['config_alert_emails'] = $this->config->get('config_alert_emails');
		}
		
		if (isset($this->request->post['config_fraud_detection'])) {
			$data['config_fraud_detection'] = $this->request->post['config_fraud_detection']; 
		} else {
			$data['config_fraud_detection'] = $this->config->get('config_fraud_detection');
		}	
				
		if (isset($this->request->post['config_fraud_key'])) {
			$data['config_fraud_key'] = $this->request->post['config_fraud_key']; 
		} else {
			$data['config_fraud_key'] = $this->config->get('config_fraud_key');
		}		

		if (isset($this->request->post['config_fraud_score'])) {
			$data['config_fraud_score'] = $this->request->post['config_fraud_score']; 
		} else {
			$data['config_fraud_score'] = $this->config->get('config_fraud_score');
		}	
			
		if (isset($this->request->post['config_fraud_status_id'])) {
			$data['config_fraud_status_id'] = $this->request->post['config_fraud_status_id']; 
		} else {
			$data['config_fraud_status_id'] = $this->config->get('config_fraud_status_id');
		}		
				
		if (isset($this->request->post['config_secure'])) {
			$data['config_secure'] = $this->request->post['config_secure'];
		} else {
			$data['config_secure'] = $this->config->get('config_secure');
		}

		if (isset($this->request->post['config_shared'])) {
			$data['config_shared'] = $this->request->post['config_shared'];
		} else {
			$data['config_shared'] = $this->config->get('config_shared');
		}
		
		if (isset($this->request->post['config_robots'])) {
			$data['config_robots'] = $this->request->post['config_robots'];
		} else {
			$data['config_robots'] = $this->config->get('config_robots');
		}
						
		if (isset($this->request->post['config_seo_url'])) {
			$data['config_seo_url'] = $this->request->post['config_seo_url'];
		} else {
			$data['config_seo_url'] = $this->config->get('config_seo_url');
		}
		
		if (isset($this->request->post['config_image_file_size'])) {
			$data['config_image_file_size'] = $this->request->post['config_image_file_size'];
		} elseif ($this->config->get('config_image_file_size')) {
			$data['config_image_file_size'] = $this->config->get('config_image_file_size');
		} else {
			$data['config_image_file_size'] = 300000;	
		}
		
		if (isset($this->request->post['config_file_extension_allowed'])) {
			$data['config_file_extension_allowed'] = $this->request->post['config_file_extension_allowed'];
		} else {
			$data['config_file_extension_allowed'] = $this->config->get('config_file_extension_allowed');
		}
		
		if (isset($this->request->post['config_file_mime_allowed'])) {
			$data['config_file_mime_allowed'] = $this->request->post['config_file_mime_allowed'];
		} else {
			$data['config_file_mime_allowed'] = $this->config->get('config_file_mime_allowed');
		}		
				
		if (isset($this->request->post['config_maintenance'])) {
			$data['config_maintenance'] = $this->request->post['config_maintenance'];
		} else {
			$data['config_maintenance'] = $this->config->get('config_maintenance');
		}
		
		if (isset($this->request->post['config_password'])) {
			$data['config_password'] = $this->request->post['config_password'];
		} else {
			$data['config_password'] = $this->config->get('config_password');
		}
				
		if (isset($this->request->post['config_encryption'])) {
			$data['config_encryption'] = $this->request->post['config_encryption'];
		} else {
			$data['config_encryption'] = $this->config->get('config_encryption');
		}
		
		if (isset($this->request->post['config_compression'])) {
			$data['config_compression'] = $this->request->post['config_compression']; 
		} else {
			$data['config_compression'] = $this->config->get('config_compression');
		}

		if (isset($this->request->post['config_error_display'])) {
			$data['config_error_display'] = $this->request->post['config_error_display']; 
		} else {
			$data['config_error_display'] = $this->config->get('config_error_display');
		}

		if (isset($this->request->post['config_error_log'])) {
			$data['config_error_log'] = $this->request->post['config_error_log']; 
		} else {
			$data['config_error_log'] = $this->config->get('config_error_log');
		}

		if (isset($this->request->post['config_error_filename'])) {
			$data['config_error_filename'] = $this->request->post['config_error_filename']; 
		} else {
			$data['config_error_filename'] = $this->config->get('config_error_filename');
		}
				
		if (isset($this->request->post['config_google_analytics'])) {
			$data['config_google_analytics'] = $this->request->post['config_google_analytics']; 
		} else {
			$data['config_google_analytics'] = $this->config->get('config_google_analytics');
		}
						
		$this->template = 'setting/setting.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'setting/setting')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['config_name']) {
			$this->error['name'] = $this->language->get('error_name');
		}	
		
		if ((utf8_strlen($this->request->post['config_owner']) < 3) || (utf8_strlen($this->request->post['config_owner']) > 64)) {
			$this->error['owner'] = $this->language->get('error_owner');
		}

		if ((utf8_strlen($this->request->post['config_address']) < 3) || (utf8_strlen($this->request->post['config_address']) > 256)) {
			$this->error['address'] = $this->language->get('error_address');
		}
		
    	if ((utf8_strlen($this->request->post['config_email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['config_email'])) {
      		$this->error['email'] = $this->language->get('error_email');
    	}

    	if ((utf8_strlen($this->request->post['config_telephone']) < 3) || (utf8_strlen($this->request->post['config_telephone']) > 32)) {
      		$this->error['telephone'] = $this->language->get('error_telephone');
    	}

		if (!$this->request->post['config_title']) {
			$this->error['title'] = $this->language->get('error_title');
		}	
		
		if (!empty($this->request->post['config_customer_group_display']) && !in_array($this->request->post['config_customer_group_id'], $this->request->post['config_customer_group_display'])) {
			$this->error['customer_group_display'] = $this->language->get('error_customer_group_display');
		}	
		
		if (!$this->request->post['config_voucher_min']) {
			$this->error['voucher_min'] = $this->language->get('error_voucher_min');
		}	
		
		if (!$this->request->post['config_voucher_max']) {
			$this->error['voucher_max'] = $this->language->get('error_voucher_max');
		}	
								
		if (!$this->request->post['config_image_category_width'] || !$this->request->post['config_image_category_height']) {
			$this->error['image_category'] = $this->language->get('error_image_category');
		} 
				
		if (!$this->request->post['config_image_thumb_width'] || !$this->request->post['config_image_thumb_height']) {
			$this->error['image_thumb'] = $this->language->get('error_image_thumb');
		}	
		
		if (!$this->request->post['config_image_popup_width'] || !$this->request->post['config_image_popup_height']) {
			$this->error['image_popup'] = $this->language->get('error_image_popup');
		}	
		
		if (!$this->request->post['config_image_product_width'] || !$this->request->post['config_image_product_height']) {
			$this->error['image_product'] = $this->language->get('error_image_product');
		}
				
		if (!$this->request->post['config_image_additional_width'] || !$this->request->post['config_image_additional_height']) {
			$this->error['image_additional'] = $this->language->get('error_image_additional');
		}
		
		if (!$this->request->post['config_image_related_width'] || !$this->request->post['config_image_related_height']) {
			$this->error['image_related'] = $this->language->get('error_image_related');
		}
		
		if (!$this->request->post['config_image_compare_width'] || !$this->request->post['config_image_compare_height']) {
			$this->error['image_compare'] = $this->language->get('error_image_compare');
		}
		
		if (!$this->request->post['config_image_wishlist_width'] || !$this->request->post['config_image_wishlist_height']) {
			$this->error['image_wishlist'] = $this->language->get('error_image_wishlist');
		}			
		
		if (!$this->request->post['config_image_cart_width'] || !$this->request->post['config_image_cart_height']) {
			$this->error['image_cart'] = $this->language->get('error_image_cart');
		}
		
		if (!$this->request->post['config_image_location_width'] || !$this->request->post['config_image_location_height']) {
			$this->error['image_location'] = $this->language->get('error_image_location');
		}		
		
		if ($this->request->post['config_ftp_status']) {
			if (!$this->request->post['config_ftp_host']) {
				$this->error['ftp_host'] = $this->language->get('error_ftp_host');
			}
			
			if (!$this->request->post['config_ftp_port']) {
				$this->error['ftp_port'] = $this->language->get('error_ftp_port');
			}
			
			if (!$this->request->post['config_ftp_username']) {
				$this->error['ftp_username'] = $this->language->get('error_ftp_username');
			}	
			
			if (!$this->request->post['config_ftp_password']) {
				$this->error['ftp_password'] = $this->language->get('error_ftp_password');
			}											
		}
	
		if (!$this->request->post['config_error_filename']) {
			$this->error['error_filename'] = $this->language->get('error_error_filename');
		}
		
		if (!$this->request->post['config_catalog_limit']) {
			$this->error['catalog_limit'] = $this->language->get('error_limit');
		}
		
		if (!$this->request->post['config_list_description_limit']) {
			$this->error['list_description_limit'] = $this->language->get('error_limit');
		}
		
		if (!$this->request->post['config_admin_limit']) {
			$this->error['admin_limit'] = $this->language->get('error_limit');
		}
				
		if ((utf8_strlen($this->request->post['config_encryption']) < 3) || (utf8_strlen($this->request->post['config_encryption']) > 32)) {
			$this->error['encryption'] = $this->language->get('error_encryption');
		}
				
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
			
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	public function template() {
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = HTTPS_CATALOG;
		} else {
			$server = HTTP_CATALOG;
		}
		
		if (file_exists(DIR_IMAGE . 'templates/' . basename($this->request->get['template']) . '.png')) {
			$this->response->setOutput($server . 'image/templates/' . basename($this->request->get['template']) . '.png');
		} else {
			$this->response->setOutput($server . 'image/no_image.jpg');
		}
	}		
		
	public function country() {
		$json = array();
		
		$this->load->model('localisation/country');

    	$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>