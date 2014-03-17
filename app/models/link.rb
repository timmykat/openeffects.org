class Link < ActiveRecord::Base
  def self.build_panel
    Link.all.to_a
  end
end
