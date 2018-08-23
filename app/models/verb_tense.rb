# frozen_literal_string: true

class VerbTense < ApplicationRecord
  belongs_to :tense_mode

  def to_s
    "#{tense_mode.name} #{tense}"
  end
end
