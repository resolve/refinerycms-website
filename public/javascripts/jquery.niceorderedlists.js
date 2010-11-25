(function ($)
{
	jQuery.fn.niceOrderedLists = function (options) {
		settings = $.extend ({
			includePeriod: true,
			alternatingClasses: false,
			inlineStyling: true,
			numberSize: '32pt',
			numberColor: '#006699',
			numberFont: 'Georgia, serif',
			numberClass: 'drop_number',
			contentClass: 'li_content',
			startingNumber: 1
		}, options);
		return this.each(function()
		{
			$(this).find ("li").each (function (index)
			{
				$(this).css("list-style-type","none");
				var clss = (index%2) ?  'even' : 'odd';
				str = '<div class="' + settings['numberClass'];
				if (settings['alternatingClasses'])
				{
					str += ' ' + clss + ' ';
				}
				str += '" ';
				
				if (settings['inlineStyling'])
				{
					str += ' style="font-size:'+settings['numberSize']+';width:65px;float:left;clear:both;text-align:right;padding-right:10px;color:'+settings['numberColor']+';font-family:'+settings['numberFont']+'"'
				}
				str += '>' + (index+settings['startingNumber']);
				if (settings['includePeriod'])
				{
					str += '.';
				}
				str += '</div><div class="' + settings['contentClass'];
				if (settings['alternatingClasses'])
				{
					str += ' ' + clss + ' ';
				}
				str += '" ';
				if (settings['inlineStyling'])
				{
					str += ' style="float: left;width:300px;padding-left:8px;margin-bottom:1em;padding-top: 8px;" ';
				}
				str += '>' + $(this).html() + '</div>';
				$(this).html(str);
			});
			$(this).append('<br style="clear: both" />');
		});
	};
})(jQuery);