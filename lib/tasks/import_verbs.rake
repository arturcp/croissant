desc 'Import verbs from https://leconjugueur.lefigaro.fr/'
task import_verbs: :environment do
  agent = Mechanize.new
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  page = agent.get('https://leconjugueur.lefigaro.fr/conjugaison/verbe/dire.html')

  div = page.search("#Top")

  puts "Mode: #{div.children[3].text}"

  puts "Temp: #{div.children[4].children[0].text}"

  div.children[4].children[1].to_s.split('<br>').each {|x| puts x.gsub('<p>','')}
  # puts conjugation = div.children[4].children[1].text.split('<br>')

end
