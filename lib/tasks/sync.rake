require 'httparty'

namespace :sync do
  task :brands => :environment do
    brands = JSON.parse(HTTParty.get('http://fipeapi.appspot.com/api/1/carros/marcas.json').body)
    brands.each do |brand|
      Brand.create(name: brand["fipe_name"], uid: brand["id"])
    end
  end
end
