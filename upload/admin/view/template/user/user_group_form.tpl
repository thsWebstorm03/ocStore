<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="page-header">
    <div class="container">
      <div class="pull-right">
        <button type="submit" form="form-user-group" class="btn btn-success"><i class="fa fa-check-circle"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a></div>
      <h1><i class="fa fa-pencil-square fa-lg"></i> <?php echo $heading_title; ?></h1>
    </div>
  </div>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-user-group" class="form-horizontal">
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
      <div class="col-sm-10">
        <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
        <?php if ($error_name) { ?>
        <div class="text-danger"><?php echo $error_name; ?></div>
        <?php  } ?>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label"><?php echo $entry_access; ?></label>
      <div class="col-sm-10">
        <div class="well well-sm" style="height: 150px; overflow: auto;">
          <?php foreach ($permissions as $permission) { ?>
          <div class="checkbox">
            <label>
              <?php if (in_array($permission, $access)) { ?>
              <input type="checkbox" name="permission[access][]" value="<?php echo $permission; ?>" checked="checked" />
              <?php echo $permission; ?>
              <?php } else { ?>
              <input type="checkbox" name="permission[access][]" value="<?php echo $permission; ?>" />
              <?php echo $permission; ?>
              <?php } ?>
            </label>
          </div>
          <?php } ?>
        </div>
        <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label"><?php echo $entry_modify; ?></label>
      <div class="col-sm-10">
        <div class="well well-sm" style="height: 150px; overflow: auto;">
          <?php foreach ($permissions as $permission) { ?>
          <div class="checkbox">
            <label>
              <?php if (in_array($permission, $modify)) { ?>
              <input type="checkbox" name="permission[modify][]" value="<?php echo $permission; ?>" checked="checked" />
              <?php echo $permission; ?>
              <?php } else { ?>
              <input type="checkbox" name="permission[modify][]" value="<?php echo $permission; ?>" />
              <?php echo $permission; ?>
              <?php } ?>
            </label>
          </div>
          <?php } ?>
        </div>
        <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
    </div>
  </form>
</div>
</div>
<?php echo $footer; ?> 