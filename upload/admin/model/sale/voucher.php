<?php
class ModelSaleVoucher extends Model {
	public function addVoucher($data) {
      	$this->db->query("INSERT INTO " . DB_PREFIX . "voucher SET code = '" . $this->db->escape($data['code']) . "', from_name = '" . $this->db->escape($data['from_name']) . "', from_email = '" . $this->db->escape($data['from_email']) . "', to_name = '" . $this->db->escape($data['to_name']) . "', to_email = '" . $this->db->escape($data['to_email']) . "', message = '" . $this->db->escape($data['message']) . "', amount = '" . (float)$data['amount'] . "', voucher_theme_id = '" . (int)$data['voucher_theme_id'] . "', status = '" . (int)$data['status'] . "', date_added = NOW()");
	}
	
	public function editVoucher($voucher_id, $data) {
      	$this->db->query("UPDATE " . DB_PREFIX . "voucher SET code = '" . $this->db->escape($data['code']) . "', from_name = '" . $this->db->escape($data['from_name']) . "', from_email = '" . $this->db->escape($data['from_email']) . "', to_name = '" . $this->db->escape($data['to_name']) . "', to_email = '" . $this->db->escape($data['to_email']) . "', message = '" . $this->db->escape($data['message']) . "', amount = '" . (float)$data['amount'] . "', voucher_theme_id = '" . (int)$data['voucher_theme_id'] . "', status = '" . (int)$data['status'] . "' WHERE voucher_id = '" . (int)$voucher_id . "'");
	}
	
	public function deleteVoucher($voucher_id) {
      	$this->db->query("DELETE FROM " . DB_PREFIX . "voucher WHERE voucher_id = '" . (int)$voucher_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "voucher_history WHERE voucher_id = '" . (int)$voucher_id . "'");
	}
	
	public function getVoucher($voucher_id) {
      	$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "voucher WHERE voucher_id = '" . (int)$voucher_id . "'");
		
		return $query->row;
	}
	
	public function getVouchers($data = array()) {
		$sql = "SELECT v.voucher_id, v.code, v.from_name, v.from_email, v.to_name, v.to_email, v.amount, (SELECT vtd.name FROM " . DB_PREFIX . "voucher_theme_description vtd WHERE vtd.voucher_theme_id = v.voucher_theme_id AND vtd.language_id = '" . (int)$this->config->get('config_language_id') . "' ) AS theme, v.status, v.date_added FROM " . DB_PREFIX . "voucher v";
		
		$sort_data = array(
			'v.code',
			'v.from_name',
			'v.from_email',
			'v.to_name',
			'v.to_email',
			'v.amount',
			'v.theme',
			'v.status',
			'v.date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY v.date_added";	
		}
			
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
			
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}		
		
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	
	public function getTotalVouchers() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "voucher");
		
		return $query->row['total'];
	}	
	
	public function getTotalVouchersByVoucherThemeId($voucher_theme_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "voucher WHERE voucher_theme_id = '" . (int)$voucher_theme_id . "'");
		
		return $query->row['total'];
	}	
	
	public function getVoucherHistories($voucher_id, $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT vh.order_id, CONCAT(o.firstname, ' ', o.lastname) AS customer, vh.amount, vh.date_added FROM " . DB_PREFIX . "voucher_history vh LEFT JOIN " . DB_PREFIX . "order o ON (vh.order_id = o.order_id) WHERE vh.voucher_id = '" . (int)$voucher_id . "' ORDER BY vh.date_added ASC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}
	
	public function getTotalVoucherHistories($voucher_id) {
	  	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "voucher_history WHERE voucher_id = '" . (int)$voucher_id . "'");

		return $query->row['total'];
	}			
}
?>