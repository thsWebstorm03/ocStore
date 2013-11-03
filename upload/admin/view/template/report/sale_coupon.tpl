<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h1 class="panel-title"><i class="fa fa-bar-chart-o"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <div class="well">
        <div class="row">
          <div class="col-sm-6">
            <div class="form-group">
              <label class="control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
              <input type="date" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="input-date-start" class="form-control" />
            </div>
          </div>
          <div class="col-sm-6">
            <div class="form-group">
              <label class="control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
              <input type="date" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="input-date-end" class="form-control" />
            </div>
            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
          </div>
        </div>
      </div>
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left"><?php echo $column_name; ?></td>
              <td class="text-left"><?php echo $column_code; ?></td>
              <td class="text-right"><?php echo $column_orders; ?></td>
              <td class="text-right"><?php echo $column_total; ?></td>
              <td class="text-right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($coupons) { ?>
            <?php foreach ($coupons as $coupon) { ?>
            <tr>
              <td class="text-left"><?php echo $coupon['name']; ?></td>
              <td class="text-left"><?php echo $coupon['code']; ?></td>
              <td class="text-right"><?php echo $coupon['orders']; ?></td>
              <td class="text-right"><?php echo $coupon['total']; ?></td>
              <td class="text-right"><a href="<?php echo $coupon['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=report/sale_coupon&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').val();
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').val();
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}

	location = url;
});
//--></script> 
<?php echo $footer; ?>