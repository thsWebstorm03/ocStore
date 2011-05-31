<?php  
class ControllerModuleSlideshow extends Controller {
	protected function index($module) {
		$this->load->model('design/banner');
		$this->load->model('tool/image');
		
		$this->document->addScript('catalog/view/javascript/jquery/nivo-slider/jquery.nivo.slider.pack.js');
		$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/slideshow.css');
		
		$this->data['width'] = $this->config->get('slideshow_' . $module . '_width');
		$this->data['height'] = $this->config->get('slideshow_' . $module . '_height');
		
		$this->data['banners'] = array();
		
		$results = $this->model_design_banner->getBanner($this->config->get('slideshow_' . $module . '_banner_id'));
		  
		foreach ($results as $result) {
			if (file_exists(DIR_IMAGE . $result['image'])) {
				$this->data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $this->config->get('slideshow_' . $module . '_width'), $this->config->get('slideshow_' . $module . '_height'))
				);
			}
		}
		
		$this->data['module'] = $module;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/slideshow.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/slideshow.tpl';
		} else {
			$this->template = 'default/template/module/slideshow.tpl';
		}
		
		$this->render();
	}
}
?>