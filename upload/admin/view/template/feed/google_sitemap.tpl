<?php echo $header; ?>
<div id="container"><?php echo $menu; ?><div id="content">
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
        <button type="submit" form="form-google-sitemap" class="btn btn-success"><i class="fa fa-check-circle"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a></div>
      <h1><i class="fa fa-upload fa-lg"></i> <?php echo $heading_title; ?></h1>
    </div>
  </div>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-google-sitemap" class="form-horizontal">
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
      <div class="col-sm-10">
        <select name="google_sitemap_status" id="input-status" class="form-control">
          <?php if ($google_sitemap_status) { ?>
          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
          <option value="0"><?php echo $text_disabled; ?></option>
          <?php } else { ?>
          <option value="1"><?php echo $text_enabled; ?></option>
          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
          <?php } ?>
        </select>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-data-feed"><?php echo $entry_data_feed; ?></label>
      <div class="col-sm-10">
        <textarea rows="5" readonly="readonly" id="input-data-feed" class="form-control"><?php echo $data_feed; ?></textarea>
      </div>
    </div>
  </form>
</div>
<?php echo $footer; ?>