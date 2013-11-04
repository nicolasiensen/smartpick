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

  task :references, [:year] => :environment do |t, args|
    browser = Watir::Browser.start  "http://www.fipe.org.br/web/index.asp?azxp=1&azxp=1&aspx=/web/indices/veiculos/default.aspx"
    frame = browser.frame(id: "fconteudo")
    date = Date.parse("1/1/#{args[:year]}")

    frame.select_list(:id, "ddlTabelaReferencia").select(I18n.l(date, format: :fipe))
    while frame.div(id: "UpdateProgress1").visible? do sleep 1 end

    Brand.all.each do |brand|
      frame.select_list(:id, "ddlMarca").select(brand.name)
      while frame.div(id: "UpdateProgress1").visible? do sleep 1 end
      brand.cars.each do |car|
        begin
          frame.select_list(:id, "ddlModelo").select(car.name)
          while frame.div(id: "UpdateProgress1").visible? do sleep 1 end
        rescue Exception => e
          puts e.message
        end
        car.models.each do |model|
          next if model.references.find_by_date(date).present?
          begin
            frame.select_list(:id, "ddlAnoValor").select(model.name)
            while frame.div(id: "UpdateProgress1").visible? do sleep 1 end
            price = frame.span(id: "lblValor").text
            Reference.create model_id: model.id, price: price.gsub(".", "").gsub(",", ".").delete("R$ ").to_f, date: date
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
  end
end
