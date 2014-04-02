require 'httparty'

namespace :sync do
  task :brands => :environment do
    browser = Watir::Browser.new :phantomjs
    browser.goto "http://www.fipe.org.br/web/index.asp?azxp=1&azxp=1&aspx=/web/indices/veiculos/default.aspx"
    frame = browser.frame(id: "fconteudo")
    brands = frame.select_list(:id, "ddlMarca").options
    brands.each do |brand|
      next if brand.value == "0"
      Brand.create name: brand.text, uid: brand.text
    end
  end

  task :cars => :environment do
    Brand.all.each do |brand|
      cars = JSON.parse(HTTParty.get("http://fipeapi.appspot.com/api/1/carros/veiculos/#{brand.uid}.json").body)
      cars.each do |car|
        Car.create name: "#{brand.name} #{car["fipe_name"]}", brand_id: brand.id, uid: car["id"]
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

  task :prices => :environment do |t, args|
    browser = Watir::Browser.new :phantomjs
    browser.goto "http://www.fipe.org.br/web/index.asp?azxp=1&azxp=1&aspx=/web/indices/veiculos/default.aspx"
    frame = browser.frame(id: "fconteudo")

    frame.select_list(:id, "ddlTabelaReferencia").select("Atual")
    while frame.div(id: "UpdateProgress1").visible? do sleep 1 end

    Brand.order("random()").all.each do |brand|
      begin
        frame.select_list(:id, "ddlMarca").select(brand.name)
        while frame.div(id: "UpdateProgress1").visible? do sleep 1 end
      rescue Exception => e
        puts e.message
      end
      brand.cars.select("cars.id").joins(:models).where("models.value IS NULL").group("cars.id").each do |car|
        car = Car.find(car.id)
        begin
          frame.select_list(:id, "ddlModelo").select(car.name.gsub("#{brand.name} ", ""))
          while frame.div(id: "UpdateProgress1").visible? do sleep 1 end
        rescue Exception => e
          puts e.message
        end
        car.models.each do |model|
          next if model.value.present?
          begin
            frame.select_list(:id, "ddlAnoValor").select(model.name)
            while frame.div(id: "UpdateProgress1").visible? do sleep 1 end
            value = frame.span(id: "lblValor").text
            model.value = value.gsub(".", "").gsub(",", ".").delete("R$ ").to_f
            model.save
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
  end
end
