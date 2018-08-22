module ConjugationHelper
  def conjugations_for(verb, verb_tense)
    Conjugation.find_by(verb: verb, verb_tense: verb_tense)
  end

  def omit_verb(conjugation)
    plain_text = strip_tags(conjugation)
    parts = plain_text.split(' ')
    response = parts.pop
    visible_parts = parts.join(' ').capitalize

    Struct.new(:visible_parts, :response).new(visible_parts, response)
  end
end
