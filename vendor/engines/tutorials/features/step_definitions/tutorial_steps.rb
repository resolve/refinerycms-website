Given /^I have no tutorials$/ do
  Tutorial.delete_all
end

Given /^I (only )?have tutorials titled "?([^"]*)"?$/ do |only, titles|
  Tutorial.delete_all if only
  titles.split(', ').each do |title|
    Tutorial.create(:title => title)
  end
end

Then /^I should have ([0-9]+) tutorials?$/ do |count|
  Tutorial.count.should == count.to_i
end
