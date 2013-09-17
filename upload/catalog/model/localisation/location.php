<?php
class ModelLocalisationLocation extends Model {
    public function getLocation($location_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "location WHERE location_id = '" . (int)$location_id . "'");
        
        return $query->row; 
    }

    public function getLocations() {        
		$location_data = array();
		
		$locations = $this->config->get('config_location');
		
		if ($locations) {
			foreach ($locations as $location_id) {
				$location_data[] = (int)$location_id;
			}
		}
		
		$query = $this->db->query("SELECT l.location_id, l.name, l.address_1, l.address_2, l.city, l.postcode, c.name AS country, z.name AS zone, l.geocode, l.image, l.open, l.comment FROM " . DB_PREFIX . "location l LEFT JOIN " . DB_PREFIX . "country c ON (l.country_id = c.country_id) LEFT JOIN " . DB_PREFIX . "zone z ON (l.zone_id = z.zone_id) WHERE l.location_id IN('" . implode(',', $location_data) . "')");

		return $query->rows;
    }
}
?>