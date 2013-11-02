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
    date = Date.today.at_beginning_of_month - 1.month

    4.times do |i|
      date = date - i.year
      Model.all.each do |model|
        next if model.references.find_by_date(date).present?
        begin
          browser.frame(id: "fconteudo").select_list(:id, "ddlTabelaReferencia").when_present.select(I18n.l(date, format: :fipe))
          browser.frame(id: "fconteudo").select_list(:id, "ddlMarca").when_present.select(model.car.brand.name)
          browser.frame(id: "fconteudo").select_list(:id, "ddlModelo").when_present.select(model.car.name)
          browser.frame(id: "fconteudo").select_list(:id, "ddlAnoValor").when_present.select(model.name)
          price = browser.frame(id: "fconteudo").span(id: "lblValor").when_present.text

          Reference.create model_id: model.id, price: price.gsub(".", "").gsub(",", ".").delete("R$ ").to_f, date: date
        rescue
        end
      end
    end
  end
end
