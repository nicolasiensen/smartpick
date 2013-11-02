require 'httparty'

namespace :sync do
  task :brands => :environment do
    brands = JSON.parse(HTTParty.get('http://fipeapi.appspot.com/api/1/carros/marcas.json').body)
    brands.each do |brand|
      Brand.create name: brand["fipe_name"], uid: brand["id"]
    end
  end

  task :cars => :environment do
    Brand.all.each do |brand|
      cars = JSON.parse(HTTParty.get("http://fipeapi.appspot.com/api/1/carros/veiculos/#{brand.uid}.json").body)
      cars.each do |car|
        Car.create name: car["fipe_name"], brand_id: brand.id, uid: car["id"]
      end
    end
  end

  task :models => :environment do
    Car.all.each do |car|
      models = JSON.parse(HTTParty.get("http://fipeapi.appspot.com/api/1/carros/veiculo/#{car.brand.uid}/#{car.uid}.json").body)
      models.each do |model|
        Model.create name: model["name"], car_id: car.id, uid: model["id"]
      end
    end
  end

  task :values => :environment do
    browser = Watir::Browser.start  "http://www.fipe.org.br/web/indices/veiculos/default.aspx?azxp=1&azxp=1"
    browser.wait
    browser.frame(id: "fconteudo").select_list(:id, "ddlMarca").select("Acura")
    browser.frame(id: "fconteudo").select_list(:id, "ddlModelo").select("Integra GS 1.8")
    browser.frame(id: "fconteudo").select_list(:id, "ddlAnoValor").select("1992 Gasolina")
  end
end
