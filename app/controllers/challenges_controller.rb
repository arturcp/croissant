class ChallengesController < ApplicationController
  def index
  end

  def create
    @verb = Verb.all.sample
    @verb_tense = VerbTense.all.sample

    render :index
  end
end
