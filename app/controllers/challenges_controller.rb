class ChallengesController < ApplicationController
  def index
  end

  def create
    @verb = Verb.all.sample
    @verb_tense = VerbTense.all.sample
    @pronoun = ['Je', 'Tu', 'Il', 'Elle', 'On', 'Nous', 'Vous', 'Ils', 'elles'].sample

    render :index
  end
end
