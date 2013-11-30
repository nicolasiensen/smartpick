Given(/^I'm in "(.*?)"$/) do |arg1|
  visit to_url(arg1)
end

Given(/^I choose "(.*?)" in "(.*?)"$/) do |text, arg2|
  fill_in to_element(arg2), with: text
  page.execute_script "$('.ui-autocomplete-input').trigger('keydown');"
  sleep 1
  page.execute_script "$('.ui-menu-item a:contains(\"#{text}\")').trigger('mouseenter').trigger('click');"  
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in to_element(arg1), with: arg2
end

When(/^I submit "(.*?)"$/) do |arg1|
  page.find(to_element(arg1)).find('input[type="submit"]').click
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_css(to_element(arg1))
end

Then(/^I should not see "(.*?)"$/) do |arg1|
  page.should_not have_css(to_element(arg1))
end

Then(/^I should be in "(.*?)"$/) do |arg1|
  page.current_path.should be == to_url(arg1)
end
