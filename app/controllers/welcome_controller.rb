class WelcomeController < ApplicationController
  def index
    @hero = HomeHero.where(active: true).first
    @ofx_welcome = Content.build_panel('ofx_welcome')
    @companies = Company.build_panel
    @glossary = Content.build_panel('glossary')
    @news_items = NewsItem.build_panel
    @why_a_standard = Content.build_panel('why_a_standard')
    @info_for_implementers = Content.build_panel('info_for_implementers')
    @links_for_implementers = Link.build_panel
    @agm_minutes = Minute.build_panel('agm')
    @dir_minutes = Minute.build_panel('dirm')
    @proposed_standard_changes = StandardChange.build_panel('proposed')
  end
end
