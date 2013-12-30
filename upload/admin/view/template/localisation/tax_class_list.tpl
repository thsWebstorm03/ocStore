<?php echo $header; ?>
<div class="page-header">
  <div class="container">
    <div class="pull-right"><a href="<?php echo $insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> <?php echo $button_insert; ?></a>
      <button type="button" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-tax-class').submit() : false;"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?></button>
    </div>
    <h1><i class="fa fa-bars fa-lg"></i> <?php echo $heading_title; ?></h1>
  </div>
</div>
<div id="content" class="container">
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-tax-class">
    <div class="table-responsive">
      <table class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <td width="1" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
            <td class="text-left"><?php if ($sort == 'title') { ?>
              <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
              <?php } else { ?>
              <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a>
              <?php } ?></td>
            <td class="text-right"><?php echo $column_action; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php if ($tax_classes) { ?>
          <?php foreach ($tax_classes as $tax_class) { ?>
          <tr>
            <td class="text-center"><?php if (in_array($tax_class['tax_class_id'], $selected)) { ?>
              <input type="checkbox" name="selected[]" value="<?php echo $tax_class['tax_class_id']; ?>" checked="checked" />
              <?php } else { ?>
              <input type="checkbox" name="selected[]" value="<?php echo $tax_class['tax_class_id']; ?>" />
              <?php } ?></td>
            <td class="text-left"><?php echo $tax_class['title']; ?></td>
            <td class="text-right"><a href="<?php echo $tax_class['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="text-center" colspan="3"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>
  </form>
  <div class="row">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
  </div>
</div>
<?php echo $footer; ?>