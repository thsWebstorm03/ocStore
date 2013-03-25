<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-error"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><i class="icon-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <div class="buttons"><a onclick="$('#form').submit();" class="btn"><i class="icon-ok"></i> <?php echo $button_save; ?></a> <a href="<?php echo $cancel; ?>" class="btn"><i class="icon-remove"></i> <?php echo $button_cancel; ?></a></div>
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
          <li><a href="#tab-log" data-toggle="tab"><?php echo $tab_log ?></a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="tab-general"><a href="https://merchants.klarna.com/signup?locale=en&partner_id=d5c87110cebc383a826364769047042e777da5e8&utm_campaign=Platform&utm_medium=Partners&utm_source=Opencart" target="_blank" style="float: right;"><img src="view/image/payment/klarna_banner.gif" /></a>
            <div class="tabbable tabs-left">
              <ul class="nav nav-tabs" id="country">
                <?php foreach ($countries as $country) { ?>
                <li><a href="#tab-<?php echo $country['code']; ?>" data-toggle="tab"><?php echo $country['name']; ?></a></li>
                <?php } ?>
              </ul>
              <div class="tab-content">
                <?php foreach ($countries as $country) { ?>
                <div class="tab-pane" id="tab-<?php echo $country['code']; ?>">
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_merchant; ?></label>
                    <div class="controls">
                      <input type="text" name="klarna_invoice[<?php echo $country['code']; ?>][merchant]" value="<?php echo isset($klarna_invoice[$country['code']]) ? $klarna_invoice[$country['code']]['merchant'] : ''; ?>" />
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_secret; ?></label>
                    <div class="controls">
                      <input type="text" name="klarna_invoice[<?php echo $country['code']; ?>][secret]" value="<?php echo isset($klarna_invoice[$country['code']]) ? $klarna_invoice[$country['code']]['secret'] : ''; ?>" />
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_server; ?></label>
                    <div class="controls">
                      <select name="klarna_invoice[<?php echo $country['code']; ?>][server]">
                        <?php if (isset($klarna_invoice[$country['code']]) && $klarna_invoice[$country['code']]['server'] == 'live') { ?>
                        <option value="live" selected="selected"><?php echo $text_live; ?></option>
                        <?php } else { ?>
                        <option value="live"><?php echo $text_live; ?></option>
                        <?php } ?>
                        <?php if (isset($klarna_invoice[$country['code']]) && $klarna_invoice[$country['code']]['server'] == 'beta') { ?>
                        <option value="beta" selected="selected"><?php echo $text_beta; ?></option>
                        <?php } else { ?>
                        <option value="beta"><?php echo $text_beta; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_total; ?></label>
                    <div class="controls">
                      <input type="text" name="klarna_invoice[<?php echo $country['code']; ?>][total]" value="<?php echo isset($klarna_invoice[$country['code']]) ? $klarna_invoice[$country['code']]['total'] : ''; ?>" />
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_pending_status; ?></label>
                    <div class="controls">
                      <select name="klarna_invoice[<?php echo $country['code']; ?>][pending_status_id]">
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if (isset($klarna_invoice[$country['code']]) && $order_status['order_status_id'] == $klarna_invoice[$country['code']]['pending_status_id']) { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_accepted_status; ?></label>
                    <div class="controls">
                      <select name="klarna_invoice[<?php echo $country['code']; ?>][accepted_status_id]">
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if (isset($klarna_invoice[$country['code']]) && $order_status['order_status_id'] == $klarna_invoice[$country['code']]['accepted_status_id']) { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_geo_zone; ?></label>
                    <div class="controls">
                      <select name="klarna_invoice[<?php echo $country['code']; ?>][geo_zone_id]">
                        <option value="0"><?php echo $text_all_zones; ?></option>
                        <?php foreach ($geo_zones as $geo_zone) { ?>
                        <?php if (isset($klarna_invoice[$country['code']]) && $geo_zone['geo_zone_id'] == $klarna_invoice[$country['code']]['geo_zone_id']) {  ?>
                        <option value="<?php echo $geo_zone['geo_zone_id'] ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $geo_zone['geo_zone_id'] ?>"><?php echo $geo_zone['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_status; ?></label>
                    <div class="controls">
                      <select name="klarna_invoice[<?php echo $country['code']; ?>][status]">
                        <?php if (isset($klarna_invoice[$country['code']]) && $klarna_invoice[$country['code']]['status']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="input-name"><?php echo $entry_sort_order ?></label>
                    <div class="controls">
                      <input type="text" name="klarna_invoice[<?php echo $country['code']; ?>][sort_order]" value="<?php echo isset($klarna_invoice[$country['code']]) ? $klarna_invoice[$country['code']]['sort_order'] : ''; ?>" />
                    </div>
                  </div>
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-log">
            <textarea wrap="off" style="width: 98%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $log ?></textarea>
            <a href="<?php echo $clear; ?>" class="btn"><?php echo $button_clear ?></a> </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#country a:first').tab('show');
//--></script> 
<?php echo $footer; ?> 