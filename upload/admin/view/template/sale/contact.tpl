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
    <h1 style="background-image: url('view/image/mail.png');"><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_send; ?></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><?php echo $entry_store; ?></td>
          <td><select name="store_id">
              <?php foreach ($stores as $store) { ?>
              <?php if ($store['store_id'] == $store_id) { ?>
              <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_to; ?></td>
          <td><select name="group">
              <option value=""></option>
              <?php if ($group == 'newsletter') { ?>
              <option value="newsletter" selected="selected"><?php echo $text_newsletter; ?></option>
              <?php } else { ?>
              <option value="newsletter"><?php echo $text_newsletter; ?></option>
              <?php } ?>
              <?php if ($group == 'customer') { ?>
              <option value="customer" selected="selected"><?php echo $text_customer; ?></option>
              <?php } else { ?>
              <option value="customer"><?php echo $text_customer; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td></td>
          <td><table width="100%">
              <tr>
                <td style="padding: 0;" colspan="3"><input type="text" id="search" value="" style="margin-bottom: 5px;" />
                  <a onclick="getCustomers();" style="margin-bottom: 5px;" class="button"><span><?php echo $text_search; ?></span></a></td>
              </tr>
              <tr>
                <td width="49%" style="padding: 0;"><select multiple="multiple" id="customer" size="10" style="width: 100%; margin-bottom: 3px;">
                  </select></td>
                <td width="2%" style="text-align: center; vertical-align: middle;"><input type="button" value="--&gt;" onclick="addCustomer();" />
                  <br />
                  <input type="button" value="&lt;--" onclick="removeCustomer();" /></td>
                <td width="49%" style="padding: 0;"><select multiple="multiple" id="to" size="10" style="width: 100%; margin-bottom: 3px;">
                    <?php foreach ($customers as $customer) { ?>
                    <option value="<?php echo $customer['customer_id']; ?>"><?php echo $customer['name']; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_subject; ?></td>
          <td><input name="subject" value="<?php echo $subject; ?>" />
            <?php if ($error_subject) { ?>
            <span class="error"><?php echo $error_subject; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_message; ?></td>
          <td><textarea name="message" id="message"><?php echo $message; ?></textarea>
            <?php if ($error_message) { ?>
            <span class="error"><?php echo $error_message; ?></span>
            <?php } ?></td>
        </tr>
      </table>
      <div id="customer_to">
        <?php foreach ($customers as $customer) { ?>
        <input type="hidden" name="to[]" value="<?php echo $customer['customer_id']; ?>" />
        <?php } ?>
      </div>
    </form>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
CKEDITOR.replace('message');
//--></script>
<script type="text/javascript"><!--
function addCustomer() {
	$('#customer :selected').each(function() {
		$(this).remove();
		
		$('#to option[value=\'' + $(this).attr('value') + '\']').remove();
		
		$('#to').append('<option value="' + $(this).attr('value') + '">' + $(this).text() + '</option>');
		
		$('#customer_to').append('<input type="hidden" name="to[]" value="' + $(this).attr('value') + '" />');
	});
}

function removeCustomer() {
	$('#to :selected').each(function() {
		$(this).remove();
		
		$('#customer_to input[value=\'' + $(this).attr('value') + '\']').remove();
	});
}

function getCustomers() {
	$('#customer option').remove();
	
	$.ajax({
		url: 'index.php?route=sale/contact/customers&keyword=' + encodeURIComponent($('#search').attr('value')),
		dataType: 'json',
		success: function(data) {
			for (i = 0; i < data.length; i++) {
	 			$('#customer').append('<option value="' + data[i]['customer_id'] + '">' + data[i]['name'] + '</option>');
			}
		}
	});
}
//--></script>
<?php echo $footer; ?>