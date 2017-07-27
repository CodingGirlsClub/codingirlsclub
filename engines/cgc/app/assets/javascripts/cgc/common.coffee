exports = this
exports.CGC = exports.CGC || {}

# 显示提示消息
exports.CGC.alert = (type, message) ->
  if $.isPlainObject(type)
    message = type
    type = 'block'
  $('.js-alert').remove()
  $alertWrap = $('<div class="js-alert alert"></div>').addClass("alert-#{type}")
  $alertWrap.append('<button type="button" class="close" data-dismiss="alert">&times;</button>')
  $alertWrap.append("<p>#{message}</p>")
  $alertWrap.prependTo('.panel-body')
