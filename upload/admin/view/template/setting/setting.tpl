<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
    <h1 style="background: url('view/image/setting.png') 2px 9px no-repeat;"><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <div id="tabs" class="tabs"><a tab="#tab_shop"><?php echo $tab_shop; ?></a><a tab="#tab_local"><?php echo $tab_local; ?></a><a tab="#tab_option"><?php echo $tab_option; ?></a><a tab="#tab_image"><?php echo $tab_image; ?></a><a tab="#tab_mail"><?php echo $tab_mail; ?></a><a tab="#tab_server"><?php echo $tab_server; ?></a></div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <div id="tab_shop">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_store; ?></td>
            <td><input type="text" name="config_store" value="<?php echo $config_store; ?>" />
              <?php if ($error_store) { ?>
              <span class="error"><?php echo $error_store; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_title; ?></td>
            <td><input type="text" name="config_title" value="<?php echo $config_title; ?>" />
              <?php if ($error_title) { ?>
              <span class="error"><?php echo $error_title; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_meta_description; ?></td>
            <td><textarea name="config_meta_description" cols="40" rows="5"><?php echo $config_meta_description; ?></textarea></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_owner; ?></td>
            <td><input type="text" name="config_owner" value="<?php echo $config_owner; ?>" />
              <?php if ($error_owner) { ?>
              <span class="error"><?php echo $error_owner; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_address; ?></td>
            <td><textarea name="config_address" cols="40" rows="5"><?php echo $config_address; ?></textarea>
              <?php if ($error_address) { ?>
              <span class="error"><?php echo $error_address; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_email; ?></td>
            <td><input type="text" name="config_email" value="<?php echo $config_email; ?>" />
              <?php if ($error_email) { ?>
              <span class="error"><?php echo $error_email; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
            <td><input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" />
              <?php if ($error_telephone) { ?>
              <span class="error"><?php echo $error_telephone; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_fax; ?></td>
            <td><input type="text" name="config_fax" value="<?php echo $config_fax; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_template; ?></td>
            <td><select name="config_template" onchange="$('#template').load('index.php?route=setting/setting/template&template=' + encodeURIComponent(this.value));">
                <?php foreach ($templates as $template) { ?>
                <?php if ($template == $config_template) { ?>
                <option value="<?php echo $template; ?>" selected="selected"><?php echo $template; ?></option>
                <?php } else { ?>
                <option value="<?php echo $template; ?>"><?php echo $template; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td></td>
            <td id="template"></td>
          </tr>
        </table>
        <br />
        <div id="languages" class="tabs">
          <?php foreach ($languages as $language) { ?>
          <a tab="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
          <?php } ?>
        </div>
        <?php foreach ($languages as $language) { ?>
        <div id="language<?php echo $language['language_id']; ?>">
          <table class="form">
            <tr>
              <td><?php echo $entry_welcome; ?></td>
              <td><textarea name="config_welcome_<?php echo $language['language_id']; ?>" id="description<?php echo $language['language_id']; ?>"><?php echo ${'config_welcome_' . $language['language_id']}; ?></textarea></td>
            </tr>
          </table>
        </div>
        <?php } ?>
      </div>
      <div id="tab_local">
        <table class="form">
          <tr>
            <td><?php echo $entry_country; ?></td>
            <td><select name="config_country_id" id="country" onchange="$('#zone').load('index.php?route=setting/setting/zone&country_id=' + this.value + '&zone_id=<?php echo $config_zone_id; ?>');">
                <?php foreach ($countries as $country) { ?>
                <?php if ($country['country_id'] == $config_country_id) { ?>
                <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_zone; ?></td>
            <td><select name="config_zone_id" id="zone">
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_language; ?></td>
            <td><select name="config_language">
                <?php foreach ($languages as $language) { ?>
                <?php if ($language['code'] == $config_language) { ?>
                <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_admin_language; ?></td>
            <td><select name="config_admin_language">
                <?php foreach ($languages as $language) { ?>
                <?php if ($language['code'] == $config_admin_language) { ?>
                <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_currency; ?></td>
            <td><select name="config_currency">
                <?php foreach ($currencies as $currency) { ?>
                <?php if ($currency['code'] == $config_currency) { ?>
                <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_currency_auto; ?></td>
            <td><?php if ($config_currency_auto) { ?>
              <input type="radio" name="config_currency_auto" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_currency_auto" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_currency_auto" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_currency_auto" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_tax; ?></td>
            <td><?php if ($config_tax) { ?>
              <input type="radio" name="config_tax" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_tax" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_tax" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_tax" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_measurement_class; ?></td>
            <td><select name="config_measurement_class_id">
                <?php foreach ($measurement_classes as $measurement_class) { ?>
                <?php if ($measurement_class['measurement_class_id'] == $config_measurement_class_id) { ?>
                <option value="<?php echo $measurement_class['measurement_class_id']; ?>" selected="selected"><?php echo $measurement_class['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $measurement_class['measurement_class_id']; ?>"><?php echo $measurement_class['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_weight_class; ?></td>
            <td><select name="config_weight_class_id">
                <?php foreach ($weight_classes as $weight_class) { ?>
                <?php if ($weight_class['weight_class_id'] == $config_weight_class_id) { ?>
                <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
        </table>
      </div>
      <div id="tab_option">
        <table class="form">
          <tr>
            <td><?php echo $entry_alert_mail; ?></td>
            <td><?php if ($config_alert_mail) { ?>
              <input type="radio" name="config_alert_mail" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_alert_mail" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_alert_mail" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_alert_mail" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_customer_group; ?></td>
            <td><select name="config_customer_group_id">
                <?php foreach ($customer_groups as $customer_group) { ?>
                <?php if ($customer_group['customer_group_id'] == $config_customer_group_id) { ?>
                <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_customer_price; ?></td>
            <td><?php if ($config_customer_price) { ?>
              <input type="radio" name="config_customer_price" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_customer_price" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_customer_price" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_customer_price" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_customer_approval; ?></td>
            <td><?php if ($config_customer_approval) { ?>
              <input type="radio" name="config_customer_approval" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_customer_approval" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_customer_approval" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_customer_approval" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_guest_checkout; ?></td>
            <td><?php if ($config_guest_checkout) { ?>
              <input type="radio" name="config_guest_checkout" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_guest_checkout" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_guest_checkout" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_guest_checkout" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_account; ?></td>
            <td><select name="config_account">
                <option value="0"><?php echo $text_none; ?></option>
                <?php foreach ($informations as $information) { ?>
                <?php if ($information['information_id'] == $config_account) { ?>
                <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_checkout; ?></td>
            <td><select name="config_checkout">
                <option value="0"><?php echo $text_none; ?></option>
                <?php foreach ($informations as $information) { ?>
                <?php if ($information['information_id'] == $config_checkout) { ?>
                <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_stock_display; ?></td>
            <td><?php if ($config_stock_display) { ?>
              <input type="radio" name="config_stock_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_stock_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_stock_check; ?></td>
            <td><?php if ($config_stock_check) { ?>
              <input type="radio" name="config_stock_check" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_check" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_stock_check" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_check" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_stock_checkout; ?></td>
            <td><?php if ($config_stock_checkout) { ?>
              <input type="radio" name="config_stock_checkout" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_checkout" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_stock_checkout" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_checkout" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_stock_subtract; ?></td>
            <td><?php if ($config_stock_subtract) { ?>
              <input type="radio" name="config_stock_subtract" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_subtract" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_stock_subtract" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_stock_subtract" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_order_status; ?></td>
            <td><select name="config_order_status_id">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $config_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_stock_status; ?></td>
            <td><select name="config_stock_status_id">
                <?php foreach ($stock_statuses as $stock_status) { ?>
                <?php if ($stock_status['stock_status_id'] == $config_stock_status_id) { ?>
                <option value="<?php echo $stock_status['stock_status_id']; ?>" selected="selected"><?php echo $stock_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_download; ?></td>
            <td><?php if ($config_download) { ?>
              <input type="radio" name="config_download" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_download" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_download" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_download" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_download_status; ?></td>
            <td><select name="config_download_status">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $config_download_status) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
        </table>
      </div>
      <div id="tab_image">
        <table class="form">
          <tr>
            <td><?php echo $entry_logo; ?></td>
            <td><input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="config_logo" />
              <img src="<?php echo $preview_logo; ?>" alt="" id="preview_logo" style="border: 1px solid #EEEEEE;" />&nbsp;<img src="view/image/image.png" alt="" style="cursor: pointer;" align="top" onclick="image_upload('config_logo', 'preview_logo');" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_icon; ?></td>
            <td><input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="config_icon" />
              <img src="<?php echo $preview_icon; ?>" alt="" id="preview_icon" style="margin: 4px 0px; border: 1px solid #EEEEEE;" />&nbsp;<img src="view/image/image.png" alt="" style="cursor: pointer;" align="top" onclick="image_upload('config_icon', 'preview_icon');" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_thumb; ?></td>
            <td><input type="text" name="config_image_thumb_width" value="<?php echo $config_image_thumb_width; ?>" size="3" />
              x
              <input type="text" name="config_image_thumb_height" value="<?php echo $config_image_thumb_height; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_popup; ?></td>
            <td><input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" size="3" />
              x
              <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_category; ?></td>
            <td><input type="text" name="config_image_category_width" value="<?php echo $config_image_category_width; ?>" size="3" />
              x
              <input type="text" name="config_image_category_height" value="<?php echo $config_image_category_height; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_product; ?></td>
            <td><input type="text" name="config_image_product_width" value="<?php echo $config_image_product_width; ?>" size="3" />
              x
              <input type="text" name="config_image_product_height" value="<?php echo $config_image_product_height; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_additional; ?></td>
            <td><input type="text" name="config_image_additional_width" value="<?php echo $config_image_additional_width; ?>" size="3" />
              x
              <input type="text" name="config_image_additional_height" value="<?php echo $config_image_additional_height; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_related; ?></td>
            <td><input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" size="3" />
              x
              <input type="text" name="config_image_related_height" value="<?php echo $config_image_related_height; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_image_cart; ?></td>
            <td><input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" size="3" />
              x
              <input type="text" name="config_image_cart_height" value="<?php echo $config_image_cart_height; ?>" size="3" /></td>
          </tr>
        </table>
      </div>
      <div id="tab_mail">
        <table class="form">
          <tr>
            <td><?php echo $entry_mail_protocol; ?></td>
            <td><select name="config_mail_protocol">
                <?php if ($config_mail_protocol == 'mail') { ?>
                <option value="mail" selected="selected"><?php echo $text_mail; ?></option>
                <?php } else { ?>
                <option value="mail"><?php echo $text_mail; ?></option>
                <?php } ?>
                <?php if ($config_mail_protocol == 'smtp') { ?>
                <option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
                <?php } else { ?>
                <option value="smtp"><?php echo $text_smtp; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_smtp_host; ?></td>
            <td><input type="text" name="config_smtp_host" value="<?php echo $config_smtp_host; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_smtp_username; ?></td>
            <td><input type="text" name="config_smtp_username" value="<?php echo $config_smtp_username; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_smtp_password; ?></td>
            <td><input type="text" name="config_smtp_password" value="<?php echo $config_smtp_password; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_smtp_port; ?></td>
            <td><input type="text" name="config_smtp_port" value="<?php echo $config_smtp_port; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_smtp_timeout; ?></td>
            <td><input type="text" name="config_smtp_timeout" value="<?php echo $config_smtp_timeout; ?>" /></td>
          </tr>
        </table>
      </div>
      <div id="tab_server">
        <table class="form">
          <tr>
            <td><?php echo $entry_ssl; ?></td>
            <td><?php if ($config_ssl) { ?>
              <input type="radio" name="config_ssl" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_ssl" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_ssl" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_ssl" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_encryption; ?></td>
            <td><input type="text" name="config_encryption" value="<?php echo $config_encryption; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_seo_url; ?></td>
            <td><?php if ($config_seo_url) { ?>
              <input type="radio" name="config_seo_url" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_seo_url" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_seo_url" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_seo_url" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_compression; ?></td>
            <td><input type="text" name="config_compression" value="<?php echo $config_compression; ?>" size="3" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_error_display; ?></td>
            <td><?php if ($config_error_display) { ?>
              <input type="radio" name="config_error_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_error_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_error_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_error_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_error_log; ?></td>
            <td><?php if ($config_error_log) { ?>
              <input type="radio" name="config_error_log" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_error_log" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="config_error_log" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="config_error_log" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_error_filename; ?></td>
            <td><input type="text" name="config_error_filename" value="<?php echo $config_error_filename; ?>" />
              <?php if ($error_error_filename) { ?>
              <span class="error"><?php echo $error_error_filename; ?></span>
              <?php } ?></td>
          </tr>
        </table>
      </div>
    </form>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>');
<?php } ?>	
//--></script>
<script type="text/javascript" src="view/javascript/jquery/ui/ui.draggable.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/ui.resizable.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/ui.dialog.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/external/bgiframe/jquery.bgiframe.js"></script>
<script type="text/javascript"><!--
function image_upload(field, preview) {
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image',
					type: 'POST',
					data: 'image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" style="border: 1px solid #EEEEEE;" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script type="text/javascript"><!--
$('#template').load('index.php?route=setting/setting/template&template=' + encodeURIComponent($('select[name=\'config_template\']').attr('value')));

$('#zone').load('index.php?route=setting/setting/zone&country_id=' + $('#country').attr('value') + '&zone_id=<?php echo $config_zone_id; ?>');

$('#country_id').attr('value', '<?php echo $config_country_id; ?>');
$('#zone_id').attr('value', '<?php echo $config_zone_id; ?>');
//--></script>
<script type="text/javascript"><!--
$.tabs('#tabs a');
$.tabs('#languages a');
//--></script>
<?php echo $footer; ?>