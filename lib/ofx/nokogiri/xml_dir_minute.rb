module Ofx
  module Nokogiri
    class XmlDirMinute < Ofx::Nokogiri::XmlMinute
      def initialize(date, location)
        @meeting_type = 'dirm'
        super
      end
    end
  end
end 