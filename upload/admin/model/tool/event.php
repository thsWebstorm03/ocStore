<?php
class ModelToolEvent extends Model {
	public function addEvent($code, $trigger, $action) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "event WHERE code = '" . $this->db->escape($code) . "'");
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "event SET code = '" . $this->db->escape($code) . "', trigger = '" . $this->db->escape($trigger) . "', action = '" . $this->db->escape($action) . "'");
	}

	public function deleteEvent($code, $trigger, $action) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "event WHERE code = '" . $this->db->escape($code) . "'");
	}
}
