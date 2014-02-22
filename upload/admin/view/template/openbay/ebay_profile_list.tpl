<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/product.png" alt=""/> <?php echo $lang_title_list; ?></h1>

      <div class="buttons">
        <form action="<?php echo $btn_add; ?>" method="post" id="addForm">
          <input type="hidden" name="step1" value="1"/> <select name="type">
          <?php foreach($types as $key => $val){ ?>
          <option value="<?php echo $key; ?>"><?php echo $val['name']; ?></option>
          <?php } ?>
        </select> <a onclick="$('#addForm').submit();" class="button"><span><?php echo $lang_btn_add; ?></span></a>
        </form>
      </div>
    </div>
    <div class="content">
      <table class="list">
        <thead>
        <tr>
          <td class="left"><?php echo $lang_profile_name; ?></td>
          <td class="left" width="150"><?php echo $lang_profile_type; ?></td>
          <td class="left"><?php echo $lang_profile_desc; ?></td>
          <td class="left" width="150"></td>
        </tr>
        </thead>
        <tbody>
        <?php if ($profiles) { ?><?php foreach ($profiles as $profile) { ?>
        <tr>
          <td class="left"><?php if($profile['default'] == 1){ echo '<strong>['.$lang_profile_default.'] </strong>'; } echo $profile['name'];?></td>
          <td class="left"><?php echo $types[$profile['type']]['name']; ?></td>
          <td class="left"><?php echo $profile['description']; ?></td>
          <td class="right">
            <div class="buttons">
              <a href="<?php echo $profile['link_edit']; ?>" class="button profileEdit"><?php echo $lang_btn_edit; ?></a>&nbsp;
              <a href="<?php echo $profile['link_delete']; ?>" class="button profileDelete"><?php echo $lang_btn_delete; ?></a>
            </div>
          </td>
        </tr>
        <?php } ?><?php } else { ?>
        <tr>
          <td class="center" colspan="4"><?php echo $lang_no_results; ?></td>
        </tr>
        <?php } ?>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function () {
  $('a.profileDelete').click(function (event) {
    event.preventDefault();
    var url = $(this).attr('href');
    var confirm_box = confirm('<?php echo $lang_confirm_delete; ?>');
    if (confirm_box) {
      window.location = url;
    }
  });
});
//--></script>

<?php echo $footer; ?>