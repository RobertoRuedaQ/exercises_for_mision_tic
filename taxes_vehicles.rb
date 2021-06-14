require 'faker'

##declare all variables
number_of_cases = 10
charge_twenty_percent = []
charge_forty_percent = []
personal_vehicle = []
public_vehicle = []
suv_vehicle = []
taxes_payed_by_personal_vehicle = []
taxes_payed_by_public_vehicle = []
taxes_payed_by_suv_vehicle = []
datas = []

##create basic data
number_of_cases.times do
datas.push({
  fullname: Faker::Name.name, 
  plate: Faker::Number.within(range: 100..999),
  month: Faker::Number.within(range: 1..12),
  comercial_price: Faker::Commerce.price(range: 20_000_000..40_000_000)})
end

##calculate the base of the taxes depending the second number of the plate
datas.each do |data|
  type_of_car = data[:plate].to_s.split(//)[1].to_i
  
  case type_of_car
  when 0..5
    data[:tax_base] = data[:comercial_price] * 0.15
    data[:type_of_vehicle] = 'personal_vehicle'
  when 6..7
    data[:tax_base] = data[:comercial_price] * 0.18
    data[:type_of_vehicle] = 'public_vehicle'
  when 8..9
    data[:tax_base] = data[:comercial_price] * 0.2
    data[:type_of_vehicle] = 'suv_vehicle'
  end
end

##calculate the basic descount, if the sum of the first and last digit are even or odd
datas.each do |data|
  first_digit = data[:plate].to_s.split(//)[0].to_i
  last_digit = data[:plate].to_s.split(//)[0].to_i
  sum_of_digits = first_digit + last_digit
  ## if using ternary operator
  sum_of_digits.even? ? data[:basic_discount] = 0.02 : data[:basic_discount] = 0.03
end


##calculate the discount
datas.each do |data|
  tax_base = data[:tax_base]
  basic_discount = tax_base * data[:basic_discount]

  case data[:month]
  when 1...4
    data[:to_pay] = tax_base - basic_discount - (tax_base*0.15)
  when 5
    data[:to_pay] = tax_base - basic_discount
  when 6...7
    data[:to_pay] = tax_base - basic_discount + (tax_base*0.2)
  else
    data[:to_pay] = tax_base - basic_discount + (tax_base*0.4)
  end
end

## selecting vehicles with extra charge
datas.each do |data| 
  if data[:month] == 6 || data[:month] == 7
    charge_twenty_percent << data
  elsif data[:month] >= 8
    charge_forty_percent << data
  end
end


## selecting number of vehicles per type
datas.each do |data| 
  case data[:type_of_vehicle]
  when 'personal_vehicle'
    personal_vehicle << data
  when 'public_vehicle'
    public_vehicle << data
  else
    suv_vehicle << data
  end
end



## selecting payed tax per vehicle type
datas.each do |data| 
  case data[:type_of_vehicle]
  when 'personal_vehicle'
    taxes_payed_by_personal_vehicle << data[:to_pay]
  when 'public_vehicle'
    taxes_payed_by_public_vehicle << data[:to_pay]
  else
    taxes_payed_by_suv_vehicle << data[:to_pay]
  end
end


puts "\n \n fueron sancionadas con un 20%: #{charge_twenty_percent.size} personas"
puts "\n \n fueron sancionadas con un 40%: #{charge_forty_percent.size} personas"
puts "\n \n fueron reportados #{personal_vehicle.size} vehiculos personales"
puts "\n \n fueron reportados #{public_vehicle.size} de servicio publico"
puts "\n \n fueron reportados #{suv_vehicle.size} camionestas"

puts "\n \n se pago un total de $#{taxes_payed_by_personal_vehicle.reduce(:+)} en impuesto por vehiculos personales"
puts "\n \n se pago un total de $#{taxes_payed_by_public_vehicle.reduce(:+)} en impuesto por vehiculos personales"
puts "\n \n se pago un total de $#{taxes_payed_by_suv_vehicle.reduce(:+)} en impuesto por vehiculos personales"


