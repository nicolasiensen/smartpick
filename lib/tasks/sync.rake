require 'httparty'

namespace :sync do
  task :brands => :environment do
    browser = Watir::Browser.new :phantomjs
    browser.goto "http://www.fipe.org.br/web/index.asp?azxp=1&azxp=1&aspx=/web/indices/veiculos/default.aspx"
    frame = browser.frame(id: "fconteudo")
    brands = frame.select_list(:id, "ddlMarca").options
    brands.each do |brand|
      next if brand.value == "0"
      Brand.create name: brand.text, uid: brand.value
    end
  end

  task :cars => :environment do
    browser = Watir::Browser.new :phantomjs
    browser.goto "http://www.fipe.org.br/web/index.asp?azxp=1&azxp=1&aspx=/web/indices/veiculos/default.aspx"
    frame = browser.frame(id: "fconteudo")

    Brand.all.each do |brand|
      frame.select_list(:id, "ddlMarca").select_value(brand.uid)
      while frame.div(id: "UpdateProgress1").visible? do sleep 0.5 end
      cars = frame.select_list(:id, "ddlModelo").options

      cars.each do |car|
        next if car.value == "0"
        Car.create name: "#{brand.name} #{car.text}", uid: car.value, brand: brand
      end
    end
  end

  task :models => :environment do
    car = Car.where("((SELECT count(*) FROM models WHERE models.car_id = cars.id) = 0)").first
    if car.present?
      Rake::Task["sync:models_by_car"].invoke(car.uid)
    else
      model = Model.order(:updated_at).first
      Rake::Task["sync:models_by_car"].invoke(model.car.uid)
    end
  end

  task :models => :environment do
    car = Car.where("((SELECT count(*) FROM models WHERE models.car_id = cars.id) = 0)").first
    car = Model.order(:updated_at).first.car if car.nil?

    browser = Watir::Browser.new :phantomjs
    browser.goto "http://www.fipe.org.br/web/index.asp?azxp=1&azxp=1&aspx=/web/indices/veiculos/default.aspx"
    frame = browser.frame(id: "fconteudo")

    frame.select_list(:id, "ddlMarca").select_value(car.brand.uid)
    while frame.div(id: "UpdateProgress1").visible? do sleep 0.5 end
    frame.select_list(:id, "ddlModelo").select_value(car.uid)
    while frame.div(id: "UpdateProgress1").visible? do sleep 0.5 end
    models = frame.select_list(:id, "ddlAnoValor").options.map{|o| {value: o.value, text: o.text}}

    models.each do |model|
      next if model[:value] == "0"
      begin
        frame.select_list(:id, "ddlAnoValor").select_value(model[:value])
        while frame.div(id: "UpdateProgress1").visible? do sleep 0.5 end
        value = frame.span(id: "lblValor").text.gsub(".", "").gsub(",", ".").delete("R$ ").to_f
        m = Model.where(uid: model[:value]).first

        if m.present?
          m.update_attribute :value, value
        else
          m = Model.create name: model[:text], value: value, car: car, uid: model[:value]
        end
      rescue Exception => e
        puts e.message
      end
    end
  end
end
