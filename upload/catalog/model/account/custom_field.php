<?php
class ModelAccountCustomField extends Model {
	public function getCustomFields($location, $customer_group_id) {
		$custom_field_data = array();
		
		$custom_field_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "custom_field_customer_group` cfcg LEFT JOIN `" . DB_PREFIX . "custom_field` cf ON (cfcg.custom_field_id = cf.custom_field_id) LEFT JOIN `" . DB_PREFIX . "custom_field_description` cfd ON (cf.custom_field_id = cfd.custom_field_id) WHERE cfcg.customer_group_id = '" . (int)$customer_group_id . "' AND cf.location = '" . $this->db->escape($location) . "' AND cfd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY cf.sort_order ASC");
		
		foreach ($custom_field_query->rows as $custom_field) {
			$custom_field_value_data = array();
			
			if ($custom_field['type'] == 'select' || $custom_field['type'] == 'radio' || $custom_field['type'] == 'checkbox') {
				$custom_field_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "custom_field_value cfv LEFT JOIN " . DB_PREFIX . "custom_field_value_description cfvd ON (cfv.custom_field_value_id = cfvd.custom_field_value_id) WHERE cfv.custom_field_id = '" . (int)$custom_field['custom_field_id'] . "' AND cfvd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY cfv.sort_order ASC");
				
				foreach ($custom_field_value_query->rows as $custom_field_value) {
					$custom_field_value_data[] = array(
						'custom_field_value_id' => $custom_field_value['custom_field_value_id'],
						'name'                  => $custom_field_value['name']
					);
				}
			}
			
			$custom_field_data[] = array(
				'custom_field_id'    => $custom_field['custom_field_id'],
				'custom_field_value' => $custom_field_value_data,
				'name'               => $custom_field['name'],
				'type'               => $custom_field['type'],
				'value'              => $custom_field['value'],
				'required'           => ($custom_field['required'] > 0 ? true : false),
				'location'           => $custom_field['location'],
				'sort_order'         => $custom_field['sort_order']
			);			
		}
		
		return $custom_field_data;
	}
	
	public function getCustomField($custom_field_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "custom_field` WHERE custom_field_id = '" . (int)$custom_field_id . "'");
		
		return $query->row;		
	}	
}
?>