# Read about factories at https://github.com/thoughtbot/factory_girl

# Factory no logo
FactoryGirl.define do
  factory :company do
    name              "Universal FX"
    url               "http://www.universalfx.com"
  end

  # User without role, unapproved
  factory :user do
    email             "joe@effects.com"
    name              "Joe Effects"
    company_or_org    "Wow VFX, inc."
    password          "password123"
   end

  # Contents, unpublished, no image or pdf
  factory :content do
    identifier          "content_key"
    title               "You Need to Know This"
    content             "<p>This is some very important content.</p>"
  end

  # Minutes is unpublished, type agm (as opposed to dirm)
  factory :minute do
    meeting             "agm"
    date                "1-Jan-2012"
    location            "Las Vegas, NV"
  end

  # News item (unpublished)
  factory :news_item do
    headline            "News about OFX"
    date                "3-Mar-2014"
    summary             "<p>This is the news we have to tell you about OFX.</p>"
  end
  
  # Version, approved (vs pending), current version
  factory :version do
    version            "1.7"
  end

  # Standard change (
  factory :standard_change do
    title             "Add widget to effectListing"
    type              "major"
    status            "proposed"
    version
    factory :standard_change_with_comments do
      ignore do
        comments_count 4
      end
      after(:create) do |sc, evaluator|
        create_list(:comment, evaluator.comments_count, standard_change: standard_change)
      end
    end
  end
end
