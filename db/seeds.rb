%w[Nurudeen Ibrahim].each do |name|
  customer = Customer.create!(name: name)
  puts "Customer ID: #{customer.id}"
end