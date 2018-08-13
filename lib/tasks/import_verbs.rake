def save_modes(agent)
  TenseMode.find_or_create_by(name: 'Indicatif')
  TenseMode.find_or_create_by(name: 'Subjonctif')
  TenseMode.find_or_create_by(name: 'Conditionnel')
  TenseMode.find_or_create_by(name: 'Impératif')
  TenseMode.find_or_create_by(name: 'Participe')
  TenseMode.find_or_create_by(name: 'Infinitif')
  TenseMode.find_or_create_by(name: 'Gérondif')
end

def create_verb_tenses(agent)
  page = agent.get('https://leconjugueur.lefigaro.fr/conjugaison/verbe/dire.html')
  container = page.search('#Top')

  index = 0
  divs = container.children
  current_mode = nil
  current_verb = nil

  while (index < divs.length) do
    div = divs[index]
    index += 1 and next if div.name != 'div'

    klass = div.attributes['class']&.value
    text = div.text
    puts klass

    if klass == 'verbe'
      verb = div.children[1].text.split(' ')
      current_verb = Verb.find_or_create_by(name: verb)
    elsif klass == 'modeBloc'
      current_mode = TenseMode.find_by(name: div.text)
    elsif klass == 'conjugBloc'
      conjugations = div.children[1].to_s.split('<br>')
      # Conjugation.create!(
      #
      # )
    end

    index += 1
  end

  # (0..7).each do |index|
  #   puts "Temp: #{div.children[4 + index].children[0].text}"
  # end
end

desc 'Import verbs from https://leconjugueur.lefigaro.fr/'
task import_verbs: :environment do
  agent = Mechanize.new
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  page = agent.get('https://leconjugueur.lefigaro.fr/conjugaison/verbe/dire.html')

  # div = page.search("#Top")
  #
  # puts "Mode: #{div.children[3].text}"
  # (0..7).each do |index|
  #   puts "Temp: #{div.children[4 + index].children[0].text}"
  # end
  #
  # div.children[4].children[1].to_s.split('<br>').each {|x| puts x.gsub('<p>','')}
  # puts conjugation = div.children[4].children[1].text.split('<br>')

  puts ''
  puts ''
  puts ''
  save_modes(agent)
  create_verb_tenses(agent)
end
