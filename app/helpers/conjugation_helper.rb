module ConjugationHelper
  def conjugations_for(verb, verb_tense)
    Conjugation.find_by(verb: verb, verb_tense: verb_tense)
  end
end
