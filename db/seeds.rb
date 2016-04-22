require 'csv'

comapnies = {'Apple' => 'APPL',
             'Google' => 'GOOG',
             'Facebook' => 'FB',
             'Linkedin' => 'LNKD',
             'Cisco' => 'CSCO'
            }

comapnies.each do |name, symbol|
  company = Company.create name: name, symbol: symbol

  CSV.foreach(Rails.root.join("raw", symbol + '.csv')).each_with_index do |line, i|
    next if i == 0
    price = line[4]
    volumne = line[5]
    date = line[0]
    company.prices.create({price: price, volumne: volumne, timestamp: date})
  end
end


