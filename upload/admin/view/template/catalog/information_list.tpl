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
        <td class="left"><?php if ($sort == 'id.title') { ?>
          <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a>
          <?php } ?></td>
        <td class="right"><?php if ($sort == 'i.sort_order') { ?>
          <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
          <?php } ?></td>
        <td class="right"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($informations) { ?>
      <?php $class = 'odd'; ?>
      <?php foreach ($informations as $information) { ?>
      <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
      <tr class="<?php echo $class; ?>">
        <td style="align: center;"><?php if ($information['delete']) { ?>
          <input type="checkbox" name="delete[]" value="<?php echo $information['information_id']; ?>" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="delete[]" value="<?php echo $information['information_id']; ?>" />
          <?php } ?></td>
        <td class="left"><?php echo $information['title']; ?></td>
        <td class="right"><?php echo $information['sort_order']; ?></td>
        <td class="right"><?php foreach ($information['action'] as $action) { ?>
          [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
          <?php } ?></td>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr class="even">
        <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</form>
<div class="pagination"><?php echo $pagination; ?></div>