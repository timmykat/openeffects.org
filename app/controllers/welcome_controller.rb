class WelcomeController < ApplicationController
  def index
    @companies = Company.build_panel
    @glossary = Content.build_panel('glossary')
    @news_items = NewsItem.build_panel
    @why_a_standard = Content.build_panel('why_a_standard')
    @info_for_implementers = Content.build_panel('info_for_implementers')
    @links_for_implementers = Content.build_panel('links_for_implementers')
    @agm_minutes = Minute.build_panel('agm')
    @dir_minutes = Minute.build_panel('dirm')
  end
end
