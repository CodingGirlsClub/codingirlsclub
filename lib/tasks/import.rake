namespace :import do
  
  desc "import cities data from json file"
  task :cities_from_json => :environment do
    puts "Loading Cities JSON File"
    cities = JSON.parse IO.read("#{Rails.root}/lib/cgc/data/china-city-area-zip.json")
    
    puts "Importing ..."
    country = City.create(country: "China", level: 0)
    cities.each do |p|
      puts "----- Import #{p["name"]} ----- "
      province = City.create(country: country.country, province: p["name"], parent_id: country.id, level: 1)
      p["child"].each do |c| 
        puts "Import #{c["name"]}"
        city = City.create(country: country.country, province: p["name"], name: c['name'], parent_id: province.id, level: 2)
        c["child"].each do |d|
          puts "Import #{d["name"]}"
          district = City.create(country: country.country, province: p["name"], name: c['name'], district: d["name"], zipcode: d["zipcode"],parent_id: city.id, level: 3)
        end
      end
      puts "----- next -----"
    end
    puts "Import Finished!"
  end

  desc "import universities data from json file"
  task :universities_from_json => :environment do
    puts "Loading Cities JSON File"
    universities = JSON.parse IO.read("#{Rails.root}/lib/cgc/data/china-university.json")
    
    universities.each do |u|
      puts "----- Import #{u["id"]} ----- "
      province = City.find_by_province_and_level(u["id"], 1)
      u["school"].each do |s|
        puts "----- Import #{s["name"]} ----- "
        University.create(city_id: province.id, name: s["name"])
      end
      puts "----- next -----"
    end
    puts "----- Import Finished ----- "
  end

end