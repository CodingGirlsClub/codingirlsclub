exports = this
exports.CGC.Users = exports.CGC.Users || {}

class exports.CGC.Users.SelectCityAndUniversity
  @selectCityAndUniversity: ->
    $('#q_city_id_eq').select2(
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
        minimumInputLength: 1).on 'change', ->
      $('#q_university_id_eq').select2 'val', ''
      return
    $('#q_university_id_eq').select2
      placeholder: '请选择或输入学校'
      allowClear: true
      ajax:
        url: ->
          $('#q_university_id_eq').attr('data-url').replace ':id', $('#q_city_id_eq').val()
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
                text: de.name
              i++
            results
          }
        cache: true
        minimumInputLength: 1
