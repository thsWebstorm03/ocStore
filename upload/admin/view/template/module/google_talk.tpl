<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
    <h1 style="background-image: url('view/image/module.png');"><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_code; ?></td>
          <td><textarea name="google_talk_code" cols="40" rows="5"><?php echo $google_talk_code; ?></textarea>
            <?php if ($error_code) { ?>
            <span class="error"><?php echo $error_code; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_position; ?></td>
          <td><select name="google_talk_position">
              <?php if ($google_talk_position == 'left') { ?>
              <option value="left" selected="selected"><?php echo $text_left; ?></option>
              <?php } else { ?>
              <option value="left"><?php echo $text_left; ?></option>
              <?php } ?>
              <?php if ($google_talk_position == 'right') { ?>
              <option value="right" selected="selected"><?php echo $text_right; ?></option>
              <?php } else { ?>
              <option value="right"><?php echo $text_right; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_status; ?></td>
          <td><select name="google_talk_status">
              <?php if ($google_talk_status) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_sort_order; ?></td>
          <td><input type="text" name="google_talk_sort_order" value="<?php echo $google_talk_sort_order; ?>" size="1" /></td>
        </tr>
      </table>
    </form>
  </div>
</div>
<?php echo $footer; ?>