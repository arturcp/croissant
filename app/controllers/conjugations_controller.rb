class ConjugationsController < ApplicationController
  def show
    @verb = Verb.find_by(verb: params[:verb])
    @tense_modes = TenseMode.all
  end
end
