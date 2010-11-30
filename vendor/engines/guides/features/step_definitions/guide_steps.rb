Given /^I have no guides$/ do
  Guide.delete_all
end

Given /^I (only )?have guides titled "?([^"]*)"?$/ do |only, titles|
  Guide.delete_all if only
  titles.split(', ').each do |title|
    Guide.create(:title => title)
  end
end

Then /^I should have ([0-9]+) guides?$/ do |count|
  Guide.count.should == count.to_i
end
