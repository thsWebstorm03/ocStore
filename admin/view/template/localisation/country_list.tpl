<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="heading">
  <h1><?php echo $heading_title; ?></h1>
  <div class="buttons"><a onclick="location='<?php echo $insert; ?>'" class="button"><span class="button_left button_insert"></span><span class="button_middle"><?php echo $button_insert; ?></span><span class="button_right"></span></a><a onclick="$('form').submit();" class="button"><span class="button_left button_delete"></span><span class="button_middle"><?php echo $button_delete; ?></span><span class="button_right"></span></a></div>
</div>
<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
  <table class="list">
    <thead>
      <tr>
        <td width="1" style="align: center;"><input type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);" /></td>
        <td class="left"><?php if ($sort == 'name') { ?>
          <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
          <?php } ?></td>
        <td class="left"><?php if ($sort == 'iso_code_2') { ?>
          <a href="<?php echo $sort_iso_code_2; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_iso_code_2; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_iso_code_2; ?>"><?php echo $column_iso_code_2; ?></a>
          <?php } ?></td>
        <td class="left"><?php if ($sort == 'iso_code_3') { ?>
          <a href="<?php echo $sort_iso_code_3; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_iso_code_3; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_iso_code_3; ?>"><?php echo $column_iso_code_3; ?></a>
          <?php } ?></td>
        <td class="right"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($countries) { ?>
      <?php $class = 'odd'; ?>
      <?php foreach ($countries as $country) { ?>
      <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
      <tr class="<?php echo $class; ?>">
        <td style="align: center;"><?php if ($country['delete']) { ?>
          <input type="checkbox" name="delete[]" value="<?php echo $country['country_id']; ?>" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="delete[]" value="<?php echo $country['country_id']; ?>" />
          <?php } ?></td>
        <td class="left"><?php echo $country['name']; ?></td>
        <td class="left"><?php echo $country['iso_code_2']; ?></td>
        <td class="left"><?php echo $country['iso_code_3']; ?></td>
        <td class="right"><?php foreach ($country['action'] as $action) { ?>
          [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
          <?php } ?></td>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr class="even">
        <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</form>
<div class="pagination"><?php echo $pagination; ?></div>
