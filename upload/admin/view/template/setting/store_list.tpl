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
      <h1><i class="icon-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="box-content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="buttons"><a href="<?php echo $insert; ?>" class="btn"><i class="icon-plus"></i> <?php echo $button_insert; ?></a> <a onclick="$('#form').submit();" class="btn"><i class="icon-trash"></i> <?php echo $button_delete; ?></a></div>
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
              <td class="left"><?php echo $column_name; ?></a></td>
              <td class="left"><?php echo $column_url; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($stores) { ?>
            <?php foreach ($stores as $store) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($store['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $store['store_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $store['name']; ?></td>
              <td class="left"><?php echo $store['url']; ?></td>
              <td class="right"><?php foreach ($store['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?> 