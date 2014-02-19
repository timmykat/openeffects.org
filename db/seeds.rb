# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [
  {
    :name => "Gary Oberbrunner",
    :email => "garyo@genarts.com",
    :password => "password123"
    :company => "GenArts, Inc.",
    :approved => true
  },
  {
    :name => "Peter Huisma",
    :email => "peter.huisma@assimilateinc.com",
    :password => "password123"
    :company => "Assimilate, Inc.",
    :approved => true

  },
  {
    :name => "Pierre Jasmin",
    :email => "jasmin@revisionfx.com",
    :password => "password123"
    :company => "Revision FX",
    :approved => true
  },
  {
    :name => "Joe User",
    :email => "joeuser@borisfx.com",
    :password => "password123"
    :company => "Boris FX",
    :approved => true
  },
  {
    :name => "Jane User",
    :email => "janeuser@limelight.com",
    :password => "password123"
    :company => "Limelight Effects",
    :approved => true
  }  
]
companies = [
   {
    :name => 'Sony Digital Imaging',
    :description => 'We help you make.believe',
    :url => "http://www.sonydigitalimaging.com/",
    :address => "16530 Via Esprillo, San Diego, CA 92127, USA",
  },
   {
    :name => 'The Foundry Visionmongers Ltd.',
    :description => 'Nuke your footage.',
    :url => "http://www.thefoundry.co.uk",
    :address => "1 Wardour St, London W1V 6PA,England",
    :joined => "15-Apr-2009",
  },
   {
    :name => 'RE:Vision Effects',
    :description => 'Better effects through chemistry',
    :url => "http://www.revisionfx.com",
    :address => "18 Vicksburg, San Francisco, Ca, 94114, USA",
    :joined => "16-Apr-2009",
  },
   {
    :name => 'RE:Vision Effects',
    :description => 'Better effects through chemistry',
    :url => "http://www.revisionfx.com",
    :address => "18 Vicksburg, San Francisco, Ca, 94114, USA",
    :joined => "16-Apr-2009",
  },
 {
    :name => 'FilmLight Ltd.',
    :description => 'Giving films great light.',
    :url => "http://www.assimilateinc.com",
    :address => "Artists House, 14-15 Manette St, London W1D 4AP, UK",
    :joined => "15-Apr-2009",
  },
  {
    :name => 'Assimilate, Inc.',
    :description => 'A great VFX software company.',
    :url => "http://www.assimilateinc.com",
    :address => "Helperpark 282 F, 9723 ZA Groningen, The Netherlands",
    :joined => "16-Apr-2009",
    :contact => User.pluck(:id).where("company LIKE %?%", 'assimilate')
  },
  {
    :name => 'GenArts, Inc.',
    :description => 'Makers of Sapphire, the premier plugin maker in the industry.',
    :url => "http://www.assimilateinc.com",
    :address => "Helperpark 282 F, 9723 ZA Groningen, The Netherlands",
    :joined => "16-Apr-2009",
    :contact => User.pluck(:id).where("company LIKE %?%", 'genarts')
  }
]