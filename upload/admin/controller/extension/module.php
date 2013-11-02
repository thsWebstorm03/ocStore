<?php
class ControllerExtensionModule extends Controller {
	private $error = array();
	
  	public function index() {
		$this->language->load('extension/module');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/extension');
		
    	$this->getList();
  	}
	
	public function install() {
		$this->language->load('extension/module');
    	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/extension');
				
		if ($this->validate()) {
			$this->model_setting_extension->install('module', $this->request->get['extension']);

			$this->load->model('user/user_group');
		
			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/' . $this->request->get['extension']);
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/' . $this->request->get['extension']);
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->getList();
	}
	
	public function uninstall() {
		$this->language->load('extension/module');
    	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/extension');
				
		if ($this->validate()) {		
			$this->model_setting_extension->uninstall('module', $this->request->get['extension']);
		
			$this->load->model('setting/setting');
		
			$this->model_setting_setting->deleteSetting($this->request->get['extension']);
			
			$this->session->data['success'] = $this->language->get('text_success');
				
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));	
		}
		
		$this->getList();
	}
		
	public function getList() {
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
   		);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_confirm'] = $this->language->get('text_confirm');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['button_edit'] = $this->language->get('button_edit');
		$this->data['button_install'] = $this->language->get('button_install');
		$this->data['button_uninstall'] = $this->language->get('button_uninstall');

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

		$this->load->model('setting/extension');

		$extensions = $this->model_setting_extension->getInstalled('module');
		
		foreach ($extensions as $key => $value) {
			if (!file_exists(DIR_APPLICATION . 'controller/module/' . $value . '.php')) {
				$this->model_setting_extension->uninstall('module', $value);
				
				unset($extensions[$key]);
			}
		}
		
		$this->data['extensions'] = array();
						
		$files = glob(DIR_APPLICATION . 'controller/module/*.php');
		
		if ($files) {
			foreach ($files as $file) {
				$extension = basename($file, '.php');
				
				$this->language->load('module/' . $extension);
												
				$this->data['extensions'][] = array(
					'name'      => $this->language->get('heading_title'),
					'edit'      => $this->url->link('module/' . $extension . '', 'token=' . $this->session->data['token'], 'SSL'),
					'install'   => $this->url->link('extension/module/install', 'token=' . $this->session->data['token'] . '&extension=' . $extension, 'SSL'),
					'uninstall' => $this->url->link('extension/module/uninstall', 'token=' . $this->session->data['token'] . '&extension=' . $extension, 'SSL'),
					'installed' => in_array($extension, $extensions)
				);
			}
		}

		$this->template = 'extension/module.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
    	if (!$this->user->hasPermission('modify', 'extension/module')) {
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