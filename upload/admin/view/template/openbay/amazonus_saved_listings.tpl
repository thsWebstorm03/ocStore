<?php echo $header; ?><?php echo $menu; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a href="<?php echo $link_overview; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h1>
    </div>
  </div>
  <div class="container-fluid">
    <div class="well">
      <div class="row">
        <div class="col-sm-12">
          <p><?php echo $text_description; ?></p>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <div class="pull-right">
            <?php if (!empty($saved_products)) { ?>
              <a id="upload_button" onclick="upload()" class="btn btn-primary"><i class="fa fa-cloud-upload fa-lg"></i> <?php echo $button_upload; ?></a>
            <?php } ?>
          </div>
        </div>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th><?php echo $column_name; ?></th>
          <th><?php echo $column_model; ?></th>
          <th><?php echo $column_sku; ?></th>
          <th><?php echo $column_amazon_sku; ?></th>
          <th class="text-center"><?php echo $column_action; ?></th>
        </tr>
      </thead>
      <tbody>
        <?php if (!empty($saved_products)) { ?>
          <?php foreach ($saved_products as $saved_product) { ?>
            <tr>
              <td class="text-left"><?php echo $saved_product['product_name']; ?></td>
              <td class="text-left"><?php echo $saved_product['product_model']; ?></td>
              <td class="text-left"><?php echo $saved_product['product_sku']; ?></td>
              <td class="text-left"><?php echo $saved_product['amazon_sku']; ?></td>
              <td class="text-center">
                <a href="<?php echo $saved_product['edit_link']; ?>">[<?php echo $button_edit; ?>]</a>
                <a onclick="removeSaved('<?php echo $saved_product['product_id']; ?>', '<?php echo $saved_product['var']; ?>')">[<?php echo $button_remove; ?>]</a>
              </td>
            </tr>
          <?php } ?>
        <?php } else { ?>
          <tr>
            <td colspan="5" class="text-center"><?php echo $text_no_results; ?></td>
          </tr>
        <?php } ?>
      </tbody>
    </table>
  </div>
</div>
<script type="text/javascript">
  function removeSaved(id, option_var) {
    if (!confirm("<?php echo $text_delete_confirm; ?>")) {
      return;
    }
    $.ajax({
      url: '<?php echo html_entity_decode($deleteSavedAjax); ?>',
      type: 'get',
      data: 'product_id=' + id + '&var=' + option_var,
      success: function () {
        window.location.href = window.location.href;
      },
      error: function (xhr, ajaxOptions, thrownError) {
        if (xhr.status != 0) { alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText); }
      }
    });
  }

  $('#button-upload').bind('click', function() {
    $.ajax({
      url: '<?php echo html_entity_decode($uploadSavedAjax); ?>',
      dataType: 'json',
      beforeSend: function () {
        $('#upload_button').empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
      },
      complete: function () {
        $('#upload_button').empty().html('<i class="fa fa-cloud-upload fa-lg"></i> <?php echo $button_upload; ?>').removeAttr('disabled');
      },
      success: function (data) {
        if (data['status'] == 'ok') {
          alert('<?php echo $text_uploaded_alert; ?>');
        } else if (data['error_message'] !== undefined) {
          alert(data['error_message']);
          return;
        } else {
          alert('Unknown error.');
          return;
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        if (xhr.status != 0) { alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText); }
      }
    });
  });
</script>
<?php echo $footer; ?>