require_relative('./property.rb')
require('pry')

details1 = {
  'address' => '9 Old Edinburgh Rd.',
  'value' => '1000',
  'no_of_bedrooms' => '6',
  'build' =>  'detatched'
}

details2 = {
  'address' => '12 Academy St.',
  'value' => '2000',
  'no_of_bedrooms' => '6',
  'build' =>  'detatched'
}


property1 = Property.new(details1)
property2 = Property.new(details2)
# binding.pry

property1.save
property2.save

property2.value = 4000
property2.update

all_properties = Property.all
found_property_id = Property.find_by_id(28)
found_property_address = Property.find_by_address(12)
# p found_property_id
p found_property_address
# property2.delete
