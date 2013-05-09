function getURLVar(key) {
	var value = [];
	
	var query = String(document.location).split('?');
	
	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');
			
			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}
		
		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
} 

$(document).ready(function() {
	route = getURLVar('route');
	
	if (!route) {
		$('#dashboard').addClass('active');
	} else {
		part = route.split('/');
		
		url = part[0];
		
		if (part[1]) {
			url += '/' + part[1];
		}
		
		$('a[href*=\'' + url + '\']').parents('li[id]').addClass('selected');
	}
	
	$('[data-toggle=\'tooltip\']').tooltip({
		'placement': 'top',
		'animation': false,
		'html': true
	});
});

$('.ajax').on('submit', function(event) {
	event.preventDefault();
	
	$.ajax({
		url: $(this).attr('action'),
		type: $(this).attr('method'),
		data: $(this).serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('#button-option').prop('disabled', true);
		},	
		complete: function() {
			$('#button-option').prop('disabled', false);
		},		
		success: function(json) {
			$('.alert, .error .help-block').remove();
			$('.error').removeClass('error');
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('.box').before('<div class="alert alert-error">' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
				
				for (i in json['error']) {
					$('#input-' + i).parent().parent().addClass('error');
				
					$('#input-' + i).after('<span class="help-block">' + json['error'][i] + '</span>');
				}				
			}
						
			if (json['success']) {
				$('.box').before('<div class="alert alert-success">' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		},
		cache: false,
		contentType: false,
		processData: false
	});
});

// Added my own autocomplete method for jquery since bootstraps is pretty much useless	
(function($) {
	function Autocomplete(element, options) {
		this.element = element;
		this.options = options;
		this.timer = null;
		this.items = [];

		$(element).attr('autocomplete', 'off');
	  			
		$(element).after('<ul class="dropdown-menu"></ul>');

		$(element).on('focus', $.proxy(this.focus, this));
		$(element).on('blur', $.proxy(this.blur, this));
		$(element).on('keydown', $.proxy(this.keydown, this));
	}
	
	Autocomplete.prototype = {
		focus: function() {
			this.request();
		},
		blur: function() {
			setTimeout(function(object) {
				object.hide();
			}, 200, this);
		},
		click: function(event) {
			event.preventDefault();
			
			value = $(event.target).parent().attr('data-value');
			
			if (value && this.items[value]) {
				this.options.select(this.items[value]);
			}
		},	
		keydown: function(event) {
			switch(event.keyCode) {
				case 27: // escape
					this.hide();
					break
				default:
					this.request();
			}
		},
		show: function() {
			var pos = $(this.element).position();
			
			$(this.element).siblings('ul.dropdown-menu').css({
				top: pos.top + $(this.element).outerHeight(),
				left: pos.left
			});
						
			$(this.element).siblings('ul.dropdown-menu').show();			
		},
		hide: function() {
			$(this.element).siblings('ul.dropdown-menu').hide();
		},
		request: function() {
			clearTimeout(this.timer);
			
			this.timer = setTimeout(function(object) {
				object.options.source($(object.element).val(), $.proxy(object.response, object));
			}, 200, this);
		},		
		response: function(json) {
			html = '';
			
			if (json.length) {
				for (i = 0; i < json.length; i++) {
					this.items[json[i]['value']] = json[i];				
				}
				
				for (i = 0; i < json.length; i++) {
					// Check for categories to place them at the top
					if (json[i]['category']) {
						if (!$(this.element).siblings('ul.dropdown-menu').find('li.disabled a b:contains(\'' + json[i]['category'] + '\')').length) {
							$(this.element).siblings('ul.dropdown-menu').append('<li class="disabled"><a href="#"><b>' + json[i]['category'] + '</b></a></li>');
						}
						
						for (j = 0; j < json.length; j++) {
							if (json[j]['category'] && json[i]['category'] == json[j]['category']) {
								if (!$(this.element).siblings('ul.dropdown-menu').find('[data-value=\'' + json[j]['value'] + '\']').length) {
									$(this.element).siblings('ul.dropdown-menu').append('<li data-value="' + json[j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + json[j]['label'] + '</a></li>');
								}
							}
						}
					} else {
						if (!$(this.element).siblings('ul.dropdown-menu').find('[data-value=\'' + json[i]['value'] + '\']').length) {
							$(this.element).siblings('ul.dropdown-menu').append('<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>');
						}
					}
				}
			}
			
			if ($(this.element).siblings('ul.dropdown-menu').find('li').length) {
				this.show();
			} else {
				this.hide();
			}
			
			$(this.element).parent().find('ul.dropdown-menu a').on('click', $.proxy(this.click, this));			
			$(this.element).parent().find('ul.dropdown-menu a').on('mouseup', $.proxy(this.mouseup, this));		
		}
	};

	$.fn.autocomplete = function(option) {
		return this.each(function() {
			var data = $(this).data('autocomplete');
			
			if (!data) {
				data = new Autocomplete(this, option);
				
				$(this).data('autocomplete', data);
			}
		});	
	}
})(window.jQuery);