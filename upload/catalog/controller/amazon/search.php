<?php
class ControllerAmazonSearch extends Controller {
	public function index() {
		if ($this->config->get('amazon_status') != '1') {
			return;
		}

		$this->load->model('openbay/amazon_product');

		$logger = new Log('amazon.log');
		$logger->write('amazon/search - started');

		$token = $this->config->get('openbay_amazon_token');

		$incoming_token = isset($this->request->post['token']) ? $this->request->post['token'] : '';

		if ($incoming_token !== $token) {
			$logger->write('amazon/search - Incorrect token: ' . $incoming_token);
			return;
		}

		$decrypted = $this->openbay->amazon->decryptArgs($this->request->post['data']);

		if (!$decrypted) {
			$logger->write('amazon/search Failed to decrypt data');
			return;
		}

		$logger->write($decrypted);

		$json = json_decode($decrypted, 1);

		$this->model_openbay_amazon_product->updateSearch($json);
	}
}