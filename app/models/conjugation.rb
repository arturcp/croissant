# frozen_literal_string: true

class Conjugation < ApplicationRecord
  belongs_to :verb
  belongs_to :verb_tense
end
