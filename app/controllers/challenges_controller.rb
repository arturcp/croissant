class ChallengesController < ApplicationController
  VALID_TENSES = {
    'Indicatif': ['Présent', 'Passé composé', 'Imparfait', 'Plus-que-parfait', 'Futur simple'],
    'Conditionnel': ['Présent'],
    'Impératif': ['Présent'],
    'Participe': ['Présent'],
    'Gérondif': ['Présent']
  }.freeze

  def index
  end

  def create
    @verb = Verb.all.sample
    @verb_tense = choose_verb_tense
    @pronoun = choose_pronoun

    render :index
  end

  private

  def choose_verb_tense
    tense_mode_name = VALID_TENSES.keys.sample
    tense_mode = TenseMode.find_by(name: tense_mode_name)

    VerbTense.where(tense_mode: tense_mode, tense: VALID_TENSES[tense_mode_name]).sample
  end

  def choose_pronoun
    ['Je', 'Tu', 'Il', 'Elle', 'On', 'Nous', 'Vous', 'Ils', 'elles'].sample
  end
end
