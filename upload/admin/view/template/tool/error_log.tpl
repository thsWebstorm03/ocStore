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
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="page-header">
    <div class="container">
      <div class="pull-right"><a href="<?php echo $clear; ?>" class="btn btn-danger"><i class="fa fa-eraser"></i> <?php echo $button_clear; ?></a></div>
      <h1><i class="fa fa-exclamation-circle fa-lg"></i> <?php echo $heading_title; ?></h1>
    </div>
  </div>
  <textarea wrap="off" rows="15" readonly="readonly" class="form-control"><?php echo $log; ?></textarea>
</div>
<?php echo $footer; ?>