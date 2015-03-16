$('.popover').on('shown.bs.popover', function () {
  var off = $(this).offset(),
       delta = 50,
       newY = parseInt( off.top ) + delta + 'px';

   $(this).css({top: newY });
})