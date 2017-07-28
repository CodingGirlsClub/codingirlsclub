exports = this
exports.CGC.Mentors = exports.CGC.Mentors || {}

class exports.CGC.Mentors.SelectCity
  @selectCity: ->
    $('#q_city_id_eq').select2
      placeholder: '请选择或输入城市'
      allowClear: true
      ajax:
        url: ->
          $('#q_city_id_eq').attr 'data-url'
        dataType: 'json'
        processResults: (data, page) ->
          de = undefined
          { results: do ->
            i = undefined
            len = undefined
            results = undefined
            results = []
            i = 0
            len = data.length
            while i < len
              de = data[i]
              results.push
                id: de.id
                text: de.province
              i++
            results
          }
        cache: true
        minimumInputLength: 1
