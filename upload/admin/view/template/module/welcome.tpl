<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-error"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="box-heading">
      <h1><i class="icon-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="box-content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <div class="buttons"><button type="submit" class="btn"><i class="icon-ok"></i> <?php echo $button_save; ?></button> <a href="<?php echo $cancel; ?>" class="btn"><i class="icon-remove"></i> <?php echo $button_cancel; ?></a></div>
        <div class="tabbable tabs-left">
        <ul class="nav nav-tabs" id="module">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <li><a href="#tab-module<?php echo $module_row; ?>" data-toggle="tab"><?php echo $tab_module . ' ' . $module_row; ?> <img src="view/image/icon-delete.png" alt="" onclick="$('a[href=\'#tab-module<?php echo $module_row; ?>\']').parent().remove(); $('#tab-module<?php echo $module_row; ?>').remove(); $('#module a:first').tab('show');" /></a></li>
          <?php $module_row++; ?>
          <?php } ?>
          <li id="module-add"><?php echo $button_add_module; ?> <img src="view/image/icon-add.png" alt="" onclick="addModule();" /></li>
        </ul>
        <div class="tab-content">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <div class="tab-pane" id="tab-module<?php echo $module_row; ?>">
            <ul class="nav nav-tabs" id="language<?php echo $module_row; ?>">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#tab-module<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="tab-module<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>">
                <div class="control-group">
                  <label class="control-label" for="input-description<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                  <div class="controls">
                    <textarea name="welcome_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
            <div class="control-group">
              <label class="control-label" for="input-layout<?php echo $module_row; ?>"><?php echo $entry_layout; ?></label>
              <div class="controls">
                <select name="welcome_module[<?php echo $module_row; ?>][layout_id]" id="input-layout<?php echo $module_row; ?>">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input-position<?php echo $module_row; ?>"><?php echo $entry_position; ?></label>
              <div class="controls">
                <select name="welcome_module[<?php echo $module_row; ?>][position]" id="input-position<?php echo $module_row; ?>">
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php echo $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php echo $text_column_right; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input-status<?php echo $module_row; ?>"><?php echo $entry_status; ?></label>
              <div class="controls">
                <select name="welcome_module[<?php echo $module_row; ?>][status]" id="input-status<?php echo $module_row; ?>">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input-sort-order<?php echo $module_row; ?>"><?php echo $entry_sort_order; ?></label>
              <div class="controls">
                <input type="text" name="welcome_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order<?php echo $module_row; ?>" class="input-mini" />
              </div>
            </div>
          </div>
          <?php $module_row++; ?>
          <?php } ?>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('input-description<?php echo $module_row; ?>-language<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<div class="tab-pane" id="tab-module' + module_row + '">';
	
	html += '  <ul class="nav nav-tabs" id="language' + module_row + '">';
    <?php foreach ($languages as $language) { ?>
    html += '    <li><a href="#tab-module' + module_row + '-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
    <?php } ?>
	html += '  </ul>';

	html += '  <div class="tab-content">';

	<?php foreach ($languages as $language) { ?>
	html += '    <div class="tab-pane" id="tab-module' + module_row + '-language<?php echo $language['language_id']; ?>">';
	html += '      <div class="control-group">';
	html += '        <label class="control-label" for="input-name"><?php echo $entry_description; ?></label>';
	html += '        <div class="controls"><textarea name="welcome_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $entry_description; ?>" id="description' + module_row + '-language<?php echo $language['language_id']; ?>"></textarea></div>';
	html += '      </div>'; 	
	html += '    </div>';
	<?php } ?>

	html += '  </div>';

	html += '  <div class="control-group">';
	html += '    <label class="control-label" for="input-name"><?php echo $entry_layout; ?></label>';
	html += '    <div class="controls"><select name="welcome_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></div>';
	html += '  </div>';

	html += '  <div class="control-group">';
	html += '    <label class="control-label" for="input-name"><?php echo $entry_position; ?></label>';
	html += '    <div class="controls"><select name="welcome_module[' + module_row + '][position]">';
	html += '        <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '        <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '        <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '        <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '      </select></div>';
	html += '  </div>';
	html += '  <div class="control-group">';
	html += '    <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>';
	html += '    <div class="controls"><select name="welcome_module[' + module_row + '][status]">';
	html += '          <option value="1"><?php echo $text_enabled; ?></option>';
	html += '          <option value="0"><?php echo $text_disabled; ?></option>';
	html += '        </select></div>';
	html += '  </div>';
	html += '  <div class="control-group">';
	html += '    <label class="control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>';
	html += '    <div class="controls"><input type="text" name="welcome_module[' + module_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="input-mini" /></div>';
	html += '  </div>';
	html += '</div>';
	
	$('.form-horizontal > .tabbable > .tab-content').append(html);

	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description' + module_row + '-language<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	<?php } ?>
	
	$('#module-add').before('<li><a href="#tab-module' + module_row + '" data-toggle="tab"><?php echo $tab_module; ?> ' + module_row + ' <img src="view/image/icon-delete.png" alt="" onclick="$(\'a[href=\\\'#tab-module' + module_row + '\\\']\').parent().remove(); $(\'#tab-module' + module_row + '\').remove(); $(\'#module a:first\').tab(\'show\');" /></a></li>');
	
	$('#module a[href=\'#tab-module' + module_row + '\']').tab('show');
	
	$('#language' + module_row + ' a:first').tab('show');
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('#module a:first').tab('show');

<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language<?php echo $module_row; ?> a:first').tab('show');
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<?php echo $footer; ?>