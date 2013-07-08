<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_install) { ?>
  <div class="alert alert-error"><i class="icon-exclamation-sign"></i> <?php echo $error_install; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="box">
    <div class="box-heading">
      <h1><i class="icon-eye-open icon-large"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="box-content">
      <div class="row-fluid">
        <div class="span6">
          <div class="row-fluid">
            <div class="span6">
              <div class="stats">
                <div><span class="badge badge-success"><i class="icon-usd"></i></span></div>
                <div><span><?php echo $sale_growth; ?> </span> <?php echo $sale_total; ?></div>
              </div>
            </div>
            <div class="span6">
              <div class="stats">
                <div><i class="icon-shopping-cart"></i></div>
                <div>
                  <h5><?php echo $text_orders; ?></h5>
                  <?php echo $order_total; ?><br />
                  <span><?php echo $order_growth; ?>%</span></div>
              </div>
            </div>
          </div>
          <div class="row-fluid">
            <div class="span6">
              <div class="stats">
                <div><i class="icon-user"></i></div>
                <div>
                  <h5><?php echo $text_customers; ?></h5>
                  <?php echo $customer_total; ?><br />
                  <span><?php echo $customer_growth; ?>%</span></div>
              </div>
            </div>
            <div class="span6">
              <div class="stats">
                <div><i class="icon-globe"></i></div>
                <div>
                  <h5><?php echo $text_marketing; ?></h5>
                  Clicks: <?php echo $marketing_total; ?> / Orders: 1<br />
                  <span>+10%</span></div>
              </div>
            </div>
          </div>
        </div>
        <div class="span6">
          <h5><?php echo $text_activity; ?></h5>
          <table class="table table-striped table-bordered table-hover">
            <tbody>
              <?php if ($activities) { ?>
              <?php foreach ($activities as $activity) { ?>
              <tr>
                <td class="left"><?php echo $activity['action']; ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="center"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </div>
      <div class="row-fluid">
        <div class="span7">
          <fieldset>
            <legend>
            <?php echo $text_sales; ?>
            <div id="button-sale" class="btn-group pull-right" data-toggle="buttons-radio">
              <button class="btn btn-small active" value="day"><?php echo $text_day; ?></button>
              <button class="btn btn-small" value="week"><?php echo $text_week; ?></button>
              <button class="btn btn-small" value="month"><?php echo $text_month; ?></button>
              <button class="btn btn-small" value="year"><?php echo $text_year; ?></button>
            </div>
            </legend>
            <div id="chart-sale" class="chart" style="height: 250px;"></div>
          </fieldset>
        </div>
        <div class="span5">
          <fieldset>
            <legend style="font-size: 14px; margin-bottom: 5px;">
            <?php echo $text_marketing; ?>
            <div id="button-marketing" class="btn-group pull-right" data-toggle="buttons-radio">
              <button class="btn btn-small active" value="day"><?php echo $text_day; ?></button>
              <button class="btn btn-small" value="week"><?php echo $text_week; ?></button>
              <button class="btn btn-small" value="month"><?php echo $text_month; ?></button>
              <button class="btn btn-small" value="year"><?php echo $text_year; ?></button>
            </div>
            </legend>
            <div id="chart-marketing" class="chart" style="height: 115px;"></div>
          </fieldset>
          <fieldset>
            <legend style="font-size: 14px; margin-bottom: 5px;"> People Online</legend>
            <div id="chart-online" class="chart" style="height: 115px;"></div>
          </fieldset>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.js"></script> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.resize.min.js"></script> 
<script type="text/javascript"><!--
$('#button-sale button').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/dashboard/sale&token=<?php echo $token; ?>&range=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#button-sale button').prop('disabled', true);
		},
		complete: function() {
			$('#button-sale button').prop('disabled', false);
		},		
		success: function(json) {
			var option = {	
				shadowSize: 0,
				bars: { 
					show: true,
					fill: true,
					lineWidth: 1,
					barColor: '#000000'
				},
				grid: {
					backgroundColor: '#FFFFFF',
					hoverable: true
				},
				points: {
					show: false				
				},
				xaxis: {
					show: true,
            		ticks: json['xaxis']
				}
			}
			
			$.plot('#chart-sale', [json['orders'], json['customers']], option);	
					
			$('#chart-sale').bind('plothover', function(event, pos, item) {
				$('.tooltip').remove();
			  
				if (item) {
					$('<div id="tooltip" class="tooltip top in"><div class="tooltip-arrow"></div><div class="tooltip-inner">' + item.datapoint[1].toFixed(2) + '</div></div>').prependTo('body');
					
					$('#tooltip').css({
						position: 'absolute',
						left: item.pageX - ($('#tooltip').outerWidth() / 2),
						top: item.pageY - $('#tooltip').outerHeight(),
						pointer: 'cusror'
					}).fadeIn('slow');	
					
					$('#chart-sale').css('cursor', 'pointer');		
			  	} else {
					$('#chart-sale').css('cursor', 'auto');
				}
			});
		}
	});
});

$('#button-sale .active').trigger('click');

$('#button-marketing button').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/dashboard/marketing&token=<?php echo $token; ?>&range=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#button-marketing button').prop('disabled', true);
		},
		complete: function() {
			$('#button-marketing button').prop('disabled', false);
		},		
		success: function(json) {
			var option = {	
				shadowSize: 0,
				bars: { 
					show: true,
					fill: true,
					lineWidth: 1,
					barColor: '#000000'
				},
				grid: {
					backgroundColor: '#FFFFFF',
					hoverable: true
				},
				points: {
					show: false		
				},
				xaxis: {
            		ticks: json['xaxis']
				}
			}		
			
			$.plot('#chart-marketing', [json['clicks'], json['orders']], option);
					
			$('#chart-marketing').bind('plothover', function(event, pos, item) {
				$('.tooltip').remove();
			  
				if (item) {
					$('<div id="tooltip" class="tooltip top in"><div class="tooltip-arrow"></div><div class="tooltip-inner">' + item.datapoint[1].toFixed(2) + '</div></div>').prependTo('body');
					
					$('#tooltip').css({
						position: 'absolute',
						left: item.pageX - ($('#tooltip').outerWidth() / 2),
						top: item.pageY - $('#tooltip').outerHeight(),
						pointer: 'cusror'
					}).fadeIn('slow');	
					
					$('#chart-marketing').css('cursor', 'pointer');		
				} else {
					$('#chart-marketing').css('cursor', 'auto');
				}
			});
		}
	});
});

$('#button-marketing .active').trigger('click');

function online() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/dashboard/online&token=<?php echo $token; ?>&range=' + this.value,
		dataType: 'json',		
		success: function(json) {
			var option = {	
				shadowSize: 0,
				colors: ['#B94A48'],
				lines: { 
					show: true,
					fill: true,
					lineWidth: 1,
					barColor: '#000000'
				},
				grid: {
					backgroundColor: '#FFFFFF',
					hoverable: true
				},
				points: {
					show: false		
				},	
				xaxis: {
					ticks: json['xaxis']
				},
			}		
			
			$.plot('#chart-online', [json['online']], option);
					
			$('#chart-online').bind('plothover', function(event, pos, item) {
				$('.tooltip').remove();
			  
				if (item) {
					$('<div id="tooltip" class="tooltip top in"><div class="tooltip-arrow"></div><div class="tooltip-inner">' + item.datapoint[1].toFixed(2) + '</div></div>').prependTo('body');
					
					$('#tooltip').css({
						position: 'absolute',
						left: item.pageX - ($('#tooltip').outerWidth() / 2),
						top: item.pageY - $('#tooltip').outerHeight(),
						pointer: 'cusror'
					}).fadeIn('slow');	
					
					$('#chart-online').css('cursor', 'pointer');		
				} else {
					$('#chart-online').css('cursor', 'auto');
				}
			});
		}
	});
	
	setTimeout(online, 2000);
}

online();
//--></script> 
<?php echo $footer; ?>