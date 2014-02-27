<?php echo $header; ?><?php echo $menu; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <a data-toggle="tooltip" title="<?php echo $text_load; ?>" class="btn" onclick="loadUsage();"><i class="fa fa-refresh"></i></a>
        <a href="<?php echo $return; ?>" data-toggle="tooltip" title="<?php echo $text_btn_return; ?>" class="btn"><i class="fa fa-reply"></i></a>
      </div>
      <h1 class="panel-title"><i class="fa fa-pencil-square fa-lg"></i> <?php echo $text_heading; ?></h1>
    </div>
    <div class="panel-body">
      <h4><div class="btn btn-primary" id="load_usage_loading"><i class="fa fa-refresh fa-spin"></i></div></h4>
      <div id="usageTable" class="displayNone"></div>
    </div>
</div>

<script type="text/javascript"><!--
  function loadUsage(){
	    $.ajax({
        url: 'index.php?route=openbay/ebay/getUsage&token=<?php echo $token; ?>',
        type: 'post',
        dataType: 'json',
        beforeSend: function(){
            $('#usageTable').hide();
            $('#load_usage_loading').show();
        },
        success: function(json) {
            $('#load_usage_loading').hide();
            $('#usageTable').html(json.html).show();
            if(json.lasterror){ alert(json.lastmsg); }
        },
        failure: function(){
            $('#load_usage_loading').hide();
            $('#usageTable').hide();
            alert('<?php echo $text_ajax_load_error; ?>');
        },
        error: function(){
            $('#load_usage_loading').hide();
            $('#usageTable').hide();
            alert('<?php echo $text_ajax_load_error; ?>');
        }
	    });
  }

  $(document).ready(function() {
    loadUsage();
  });
//--></script>
<?php echo $footer; ?>