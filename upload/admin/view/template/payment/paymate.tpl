<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="heading">
  <h1><?php echo $heading_title; ?></h1>
  <div class="buttons"><a onclick="$('#form').submit();" class="button"><span class="button_left button_save"></span><span class="button_middle"><?php echo $button_save; ?></span><span class="button_right"></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span class="button_left button_cancel"></span><span class="button_middle"><?php echo $button_cancel; ?></span><span class="button_right"></span></a></div>
</div>
<div class="tabs"><a tab="#tab_general"><?php echo $tab_general; ?></a></div>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
  <div id="tab_general" class="page">
    <table class="form">
      <tr>
        <td width="25%"><span class="required">*</span> <?php echo $entry_username; ?><br /></td>
        <td><input type="text" name="paymate_username" value="<?php echo $paymate_username; ?>" />
          <br />
          <?php if ($error_username) { ?>
          <span class="error"><?php echo $error_username; ?></span>
          <?php } ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_order_status; ?></td>
        <td><select name="paymate_order_status_id">
            <?php foreach ($order_statuses as $order_status) { ?>
            <?php if ($order_status['order_status_id'] == $paymate_order_status_id) { ?>
            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_include_order; ?></td>
        <td><select name="paymate_include_order">
            <?php if ($paymate_include_order) { ?>
            <option value="1" selected="selected"><?php echo $text_yes; ?></option>
            <option value="0"><?php echo $text_no; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_yes; ?></option>
            <option value="0" selected="selected"><?php echo $text_no; ?></option>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_geo_zone; ?></td>
        <td><select name="paymate_geo_zone_id">
            <option value="0"><?php echo $text_all_zones; ?></option>
            <?php foreach ($geo_zones as $geo_zone) { ?>
            <?php if ($geo_zone['geo_zone_id'] == $paymate_geo_zone_id) { ?>
            <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_status; ?></td>
        <td><select name="paymate_status">
            <?php if ($paymate_status) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_sort_order; ?></td>
        <td><input type="text" name="paymate_sort_order" value="<?php echo $paymate_sort_order; ?>" size="1" /></td>
      </tr>
      <tr>
        <td height="24"></td>
        <td></td>
      </tr>
      <tr>
        <td style="vertical-align: middle;"><?php echo $entry_version_status ?></td>
        <td style="vertical-align: middle;">Version 1.0 <a href="http://www.pixeldrift.net/opencart/" target="PixelDrift.NET"><img src="http://www.pixeldrift.net/opencart/opencart.paymate.1_0.png" alt="Update Check" border="0"></a></td>
      </tr>
      <tr>
        <td><?php echo $entry_author; ?></td>
        <td>SuperJuice (Sam) (portions based on OpenCart GPL'd code)<br />
          Email: <a href="mailto:opencart@pixeldrift.net">opencart@pixeldrift.net</a><br />
          Web: <a href="http://www.pixeldrift.net/opencart/" target="PixelDrift.NET">http://www.pixeldrift.net/opencart/</a><br /></td>
      </tr>
    </table>
  </div>
</form>
<script type="text/javascript"><!--
$.tabs('.tabs a'); 
//--></script>
<?php echo $footer; ?>