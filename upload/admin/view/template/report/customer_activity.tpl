<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="box">
    <div class="box-heading">
      <h1><i class="icon-bar-chart icon-large"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="box-content">
      <div class="well">
        <div class="row-fluid">
          <div class="span4">
            <div class="control-group">
              <label class="control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
              <div class="controls">
                <input type="date" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="input-date-start" class="input-medium" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
              <div class="controls">
                <input type="date" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="input-date-end" class="input-medium" />
              </div>
            </div>
          </div>
          <div class="span4">
            <div class="control-group">
              <label class="control-label" for="input-customer"><?php echo $entry_customer; ?></label>
              <div class="controls">
                <input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" id="input-customer" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input-ip"><?php echo $entry_ip; ?></label>
              <div class="controls">
                <input type="text" name="filter_ip" value="<?php echo $filter_ip; ?>" id="input-ip" />
              </div>
            </div>
          </div>
          <div class="span4">
            <button type="button" id="button-filter" class="btn"><i class="icon-search"></i> <?php echo $button_filter; ?></button>
          </div>
        </div>
      </div>
      <table class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <td class="left"><?php echo $column_customer; ?></td>
            <td class="left"><?php echo $column_action; ?></td>
            <td class="left"><?php echo $column_ip; ?></td>
            <td class="left"><?php echo $column_date_added; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php if ($activities) { ?>
          <?php foreach ($activities as $activity) { ?>
          <tr>
            <td class="left"><?php echo $activity['customer']; ?></td>
            <td class="left"><?php echo $activity['action']; ?></td>
            <td class="left"><?php echo $activity['ip']; ?></td>
            <td class="left"><?php echo $activity['date_added']; ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
      <div class="row-fluid">
        <div class="span6">
          <div class="pagination"><?php echo $pagination; ?></div>
        </div>
        <div class="span6">
          <div class="results"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=report/customer_activity&token=<?php echo $token; ?>';
	
	var filter_customer = $('input[name=\'filter_customer\']').val();
	
	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}
	var filter_ip = $('input[name=\'filter_ip\']').val();
	
	if (filter_ip) {
		url += '&filter_ip=' + encodeURIComponent(filter_ip);
	}
	
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