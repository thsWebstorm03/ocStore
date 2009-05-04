<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="heading">
  <h1><?php echo $heading_title; ?></h1>
  <div class="buttons"><a onclick="location='<?php echo $insert; ?>'" class="button"><span class="button_left button_insert"></span><span class="button_middle"><?php echo $button_insert; ?></span><span class="button_right"></span></a><a onclick="document.getElementById('form').submit();" class="button"><span class="button_left button_delete"></span><span class="button_middle"><?php echo $button_delete; ?></span><span class="button_right"></span></a></div>
</div>
<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
  <table class="list">
    <thead>
      <tr>
        <td width="1" style="align: center;"><input type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);" /></td>
        <td class="left"><?php if ($sort == 'cd.name') { ?>
          <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
          <?php } ?></td>
        <td class="left"><?php if ($sort == 'c.code') { ?>
          <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_code; ?>"><?php echo $column_code; ?></a>
          <?php } ?></td>
        <td class="right"><?php if ($sort == 'c.discount') { ?>
          <a href="<?php echo $sort_discount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_discount; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_discount; ?>"><?php echo $column_discount; ?></a>
          <?php } ?></td>
        <td class="left"><?php if ($sort == 'c.date_start') { ?>
          <a href="<?php echo $sort_date_start; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_start; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_date_start; ?>"><?php echo $column_date_start; ?></a>
          <?php } ?></td>
        <td class="left"><?php if ($sort == 'c.date_end') { ?>
          <a href="<?php echo $sort_date_end; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_end; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_date_end; ?>"><?php echo $column_date_end; ?></a>
          <?php } ?></td>
        <td class="left"><?php if ($sort == 'c.status') { ?>
          <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
          <?php } ?></td>
        <td class="right"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($coupons) { ?>
      <?php $class = 'odd'; ?>
      <?php foreach ($coupons as $coupon) { ?>
      <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
      <tr class="<?php echo $class; ?>">
        <td style="align: center;"><?php if ($coupon['delete']) { ?>
          <input type="checkbox" name="delete[]" value="<?php echo $coupon['coupon_id']; ?>" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="delete[]" value="<?php echo $coupon['coupon_id']; ?>" />
          <?php } ?></td>
        <td class="left"><?php echo $coupon['name']; ?></td>
        <td class="left"><?php echo $coupon['code']; ?></td>
        <td class="right"><?php echo $coupon['discount']; ?></td>
        <td class="left"><?php echo $coupon['date_start']; ?></td>
        <td class="left"><?php echo $coupon['date_end']; ?></td>
        <td class="left"><?php echo $coupon['status']; ?></td>
        <td class="right"><?php foreach ($coupon['action'] as $action) { ?>
          [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
          <?php } ?></td>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr class="even">
        <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</form>
<div class="pagination"><?php echo $pagination; ?></div>
