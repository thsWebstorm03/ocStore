<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-error"><i class="icon-exclamation-sign"></i> <?php echo $error_warning; ?> <button type="button" class="close" data-dismiss="alert">&times;</button></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="icon-ok-sign"></i> <?php echo $success; ?> <button type="button" class="close" data-dismiss="alert">&times;</button></div>
  <?php } ?>
  <div class="box">
    <div class="box-heading">
      <h1><i class=""></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="box-content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data">
        <div class="buttons"><a href="<?php echo $insert; ?>" class="btn"><i class="icon-plus"></i> <?php echo $button_insert; ?></a> <button type="submit" class="btn"><i class="icon-trash"></i> <?php echo $button_delete; ?></button></div>
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td width="1" class="center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($voucher_themes) { ?>
            <?php foreach ($voucher_themes as $voucher_theme) { ?>
            <tr>
              <td class="center"><?php if ($voucher_theme['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $voucher_theme['name']; ?></td>
              <td class="right"><?php foreach ($voucher_theme['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="3"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
      <div class="results"><?php echo $results; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>