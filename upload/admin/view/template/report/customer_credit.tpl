<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel">
    <div class="panel-heading">
      <h1><i class="icon-bar-chart icon-large"></i> <?php echo $heading_title; ?></h1>
    </div>
    <table class="table table-striped table-bordered table-hover">
      <thead>
        <tr>
          <td class="text-left"><?php echo $column_customer; ?></td>
          <td class="text-left"><?php echo $column_email; ?></td>
          <td class="text-left"><?php echo $column_customer_group; ?></td>
          <td class="text-left"><?php echo $column_status; ?></td>
          <td class="text-right"><?php echo $column_total; ?></td>
          <td class="text-right"><?php echo $column_action; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php if ($customers) { ?>
        <?php foreach ($customers as $customer) { ?>
        <tr>
          <td class="text-left"><?php echo $customer['customer']; ?></td>
          <td class="text-left"><?php echo $customer['email']; ?></td>
          <td class="text-left"><?php echo $customer['customer_group']; ?></td>
          <td class="text-left"><?php echo $customer['status']; ?></td>
          <td class="text-right"><?php echo $customer['total']; ?></td>
          <td class="text-right"><?php foreach ($customer['action'] as $action) { ?>
            [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
            <?php } ?></td>
        </tr>
        <?php } ?>
        <?php } else { ?>
        <tr>
          <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
    <div class="row">
      <div class="col-lg-6 text-left"><?php echo $pagination; ?></div>
      <div class="col-lg-6 text-right"><?php echo $results; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>