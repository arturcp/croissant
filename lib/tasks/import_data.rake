def save_modes(agent)
  TenseMode.find_or_create_by(name: 'Indicatif')
  TenseMode.find_or_create_by(name: 'Subjonctif')
  TenseMode.find_or_create_by(name: 'Conditionnel')
  TenseMode.find_or_create_by(name: 'Impératif')
  TenseMode.find_or_create_by(name: 'Participe')
  TenseMode.find_or_create_by(name: 'Infinitif')
  TenseMode.find_or_create_by(name: 'Gérondif')
end

def create_verb_tenses(agent, verb = '')
  verb = I18n.transliterate(verb)
  puts "Verb #{verb}"
  page = agent.get("https://leconjugueur.lefigaro.fr/conjugaison/verbe/#{verb}.html")
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

    if klass == 'verbe'
      verb_name = div.children[1].text.split(' ')
      current_verb = Verb.find_or_create_by(verb: verb_name)
    elsif klass == 'modeBloc'
      current_mode = TenseMode.find_by(name: div.text)
    elsif klass == 'conjugBloc'
      content = div.children[0].children[0].to_s
      unless content.blank?
        verb_tense = content.gsub('<p>', '').gsub('</p>', '')
        current_verb_tense = VerbTense.find_or_create_by(tense_mode: current_mode, tense: verb_tense)
        conjugations = div.children[1].to_s.gsub('<p>', '').gsub('</p>', '').split('<br>')

        Conjugation.create!(
          verb: current_verb,
          verb_tense: current_verb_tense,
          je: conjugations[0],
          tu: conjugations[1],
          il: conjugations[2],
          nous: conjugations[3],
          vous: conjugations[4],
          ils: conjugations[5]
        )
      end

    end

    index += 1
  end
end

desc 'Import conjugations from https://leconjugueur.lefigaro.fr/'
task import_conjugations: :environment do
  agent = Mechanize.new
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  save_modes(agent)
  Verb.all.each do |verb|
    create_verb_tenses(agent, verb.verb)
  end
end

desc 'Import verbs from https://leconjugueur.lefigaro.fr/frlistedeverbe.php'
task import_verbs: :environment do
  agent = Mechanize.new
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  page = agent.get('https://leconjugueur.lefigaro.fr/frlistedeverbe.php')
  container = page.search('#pop')

  parts = container.text.split("\n")
  parts.each do |part|
    if part.include?('-')
      part.split(' - ').each do |verb|
        Verb.find_or_create_by(verb: verb)
      end
    end
  end
end

desc 'Import all verbs for all tenses and modes'
task import_all: :environment do
  Conjugation.delete_all
  VerbTense.delete_all
  TenseMode.delete_all
  Verb.delete_all

  tasks = %i(import_verbs import_conjugations)
  tasks.each { |task| Rake::Task[task].execute }
end
