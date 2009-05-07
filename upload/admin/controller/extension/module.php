<?php
class ControllerExtensionModule extends Controller {
	public function index() {
		$this->load->language('extension/module');
		 
		$this->document->title = $this->language->get('heading_title'); 

  		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('common/home'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => $this->url->https('extention/module'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_position'] = $this->language->get('column_position');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['success'] = @$this->session->data['success'];
		
		unset($this->session->data['success']);

		$this->load->model('setting/extension');

		$extensions = $this->model_setting_extension->getInstalled('module');
		
		$this->data['extensions'] = array();
						
		$files = glob(DIR_APPLICATION . 'controller/module/*.php');
		
		foreach ($files as $file) {
			$extension = basename($file, '.php');
			
			$this->load->language('module/' . $extension);

			$action = array();
			
			if (!in_array($extension, $extensions)) {
				$action[] = array(
					'text' => $this->language->get('text_install'),
					'href' => $this->url->https('extension/module/install&extension=' . $extension)
				);
			} else {
				$action[] = array(
					'text' => $this->language->get('text_edit'),
					'href' => $this->url->https('module/' . $extension)
				);
							
				$action[] = array(
					'text' => $this->language->get('text_uninstall'),
					'href' => $this->url->https('extension/module/uninstall&extension=' . $extension)
				);
			}
									
			$this->data['extensions'][] = array(
				'name'        => $this->language->get('heading_title'),
				'position'    => $this->config->get($extension . '_position'),
				'status'      => $this->config->get($extension . '_status') ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'sort_order'  => $this->config->get($extension . '_sort_order'),
				'action'      => $action
			);
		}
						
		$this->id       = 'content';
		$this->template = 'extension/module.tpl';
		$this->layout   = 'common/layout';
				
		$this->render();
	}
	
	public function install() {
		$this->load->model('setting/extension');
		
		$this->model_setting_extension->install('module', $this->request->get['extension']);

		$this->load->model('user/user_group');
		
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/' . $this->request->get['extension']);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/' . $this->request->get['extension']);

		$this->redirect($this->url->https('extension/module'));
	}
	
	public function uninstall() {
		$this->load->model('setting/extension');
		$this->load->model('setting/setting');
		
		$this->model_setting_extension->uninstall('module', $this->request->get['extension']);
		
		$this->model_setting_setting->deleteSetting($this->request->get['extension']);
		
		$this->redirect($this->url->https('extension/module'));	
	}
}
?>