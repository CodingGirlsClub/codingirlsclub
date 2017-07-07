exports = this
exports.FRONTEND = exports.FRONTEND || {}
exports.FRONTEND.Profiles = exports.FRONTEND.Profiles || {}

class exports.FRONTEND.Profiles.UniversityStudent
  @chooseUniversityStudent: ->
    self = this
    self.monitorStudent()
    self.selectStudent()

  # 监听是否已选择是学生
  @monitorStudent: ->
    $(document).ready ->
      isUniversityStudentOptionSelected = $('.j-is_university_student-select option:selected').val()
      if isUniversityStudentOptionSelected == 'false'
        $('.j-user-university').addClass 'none'
        $('.j-user-id_photo').addClass 'none'
      else
        $('.j-user-university').removeClass 'none'
        $('.j-user-id_photo').removeClass 'none'

  # 选择是否是学生
  @selectStudent: ->
    $('.j-is_university_student-select select').on 'change', (e) ->
      optionSelected = $('option:selected', this)
      valueSelected  = this.value
      if valueSelected == 'false'
        $('.j-user-university').addClass 'none'
        $('.j-user-id_photo').addClass 'none'
      else
        $('.j-user-university').removeClass 'none'
        $('.j-user-id_photo').removeClass 'none'

# 城市与学校级连选择
class exports.FRONTEND.Profiles.SelectCityAndUniversity
  @selectCityAndUniversity: ->
    $(document).ready ->
      $('#user_city_id').select2(
        placeholder: '请选择或输入城市'
        allowClear: true
        ajax:
          url: ->
            $('#user_city_id').attr 'data-url'
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
        $('#user_university_id').select2 'val', ''
        return
      $('#user_university_id').select2
        placeholder: '请选择或输入学校'
        allowClear: true
        ajax:
          url: ->
            $('#user_university_id').attr('data-url').replace ':id', $('#user_city_id').val()
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
