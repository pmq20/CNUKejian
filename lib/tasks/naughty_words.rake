namespace :naughty do
  task :words=>:environment do
    NaughtyWord.delete_all
    File.open(File.join(Rails.root,'db/naughty_words.txt')) do |f|
      while line=f.gets
        NaughtyWord.find_or_create_by(word:line.strip)
      end
    end
    puts "#{NaughtyWord.count} words on record."
  end
end