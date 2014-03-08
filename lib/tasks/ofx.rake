require 'ofx/migration'
require 'pry'
require 'pry-debugger'

namespace :ofx do
  desc "migrates all the data from openeffects.org to the database for the environment"
  task :migrate => ["ofx:pull[all]", "ofx:push[all]"]

  desc "pull data into an XML document(s) for pushing into the new database"
  task :pull, [:type] => :environment do |task, args|  
    unless %w(minutes standards all).include?(args.type)
      puts "You must supply a parameter of 'minutes', 'standards', or 'all'"
    end
    migration_type = args.type == 'all' ? %w(minutes standards) : [args.type]
    migration_type.each do |t|
      m = Ofx::Migration.new(t)
      m.pull
      puts "\n-- XML document for the #{t} migration complete --\n\n"
    end   
    puts "\n-- Retrieval of data complete --\n"    
  end

  desc "pushes migrated XML data into the #{Rails.env} database (params: minutes, standards, or all | nuke or anything els)"
  task :push, [:type] => :environment do |task, args|
    unless %w(minutes standards all).include?(args.type)
      puts "You must supply a parameter of 'minutes', 'standards', or 'all'"
    end
    
    loaded = []
    
    puts "WARNING: the table(s) in the <#{Rails.env.upcase}> database will be EMPTIED."
    puts "Proceed? (Y to continue)"
    answer = STDIN.gets.chomp
    exit unless answer == 'Y'
    
    # Check the migration files
    migration_type = args.type == 'all' ? %w(minutes standards) : [args.type]
    migration_type.each do |t|
      file_name = "migration_#{t}.xml"
      file_path = "#{Rails.root}/tmp/#{file_name}"
      case 
        when (!File.exists?(file_path))
          puts "ERROR: The #{t} file does not exist"
          exit
        when (!(File.size(file_path) > 0))
          puts "ERROR: There is nothing in the #{t} file"
          exit
        when (!Nokogiri::XML(file_path).is_a?(Nokogiri::XML::Document))
          puts "ERROR: The #{t} file is not an XML document"
          exit
      end
      puts "The #{t} XML file was last updated at #{File.ctime(file_path).strftime('%l:%M%P on %a %b%e')}"
      puts "Is this the correct file? (Y to continue)"
      puts "Proceed? (Y to continue)"
      answer = STDIN.gets.chomp

      if answer == 'Y'
        m = Ofx::Migration.new(t)
        m.push
        loaded << t
        puts "\n-- Table loaded for the #{t} migration --\n"
      else
        puts 'Skipping this data'
      end
    end
    puts "\n-- Tables loaded: #{loaded.join(', ')} --\n\n"
  end
end