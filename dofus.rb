require 'httparty'
class StackExchange
  include HTTParty
  base_uri 'fr.dofus.dofapi.fr'

  def initialize(service, page)
    @options = { query: { site: service, page: page } }
  end

  def questions(types) 
    self.class.get("/monsters?filter"+"[where][type]="+"#{types}", @options)
  end

end

stack_exchange = StackExchange.new("dofus", 1)
monstre_larve = stack_exchange.questions("Larves")
monstre_caverne = stack_exchange.questions("Monstres des cavernes")
monstre_plaine_herbeuse = stack_exchange.questions("Monstres des Plaines herbeuses")

#creation du fichier sur le dossier db selon le type de monstre
file = File.new("./db/monstre_larve.json", "w")
file.puts "#{monstre_larve}"
file.close

file = File.new("./db/monstre_caverne.json", "w")
file.puts "#{monstre_caverne}"
file.close

file = File.new("./db/monstre_plaine_herbeuse.json", "w")
file.puts "#{monstre_plaine_herbeuse}"
file.close

puts "File created"