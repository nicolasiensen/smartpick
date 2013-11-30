def to_url string
  return root_path                    if string == 'the homepage'
  return compare_path(Compare.first)  if string == 'the comparison result page'
  raise "I don't know what '#{string}' means"
end

def to_element string
  return 'form.new_compare'                           if string == 'the comparison form'
  return 'form.new_compare #error_explanation'        if string == 'the comparison form error message'
  return 'model_name_1'                               if string == 'the first comparison car field'
  return 'model_name_2'                               if string == 'the second comparison car field'
  raise "I don't know what '#{string}' means"
end
