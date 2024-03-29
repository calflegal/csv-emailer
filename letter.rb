require 'Pony'
htmlsource = IO.readlines("html.txt")
contactlist = IO.readlines("finallist.csv")
contactlist.map! do |item|
  #seperate the csv
  item.chomp.split(',')
end

subjectstring = %Q{Subjectline}

for i in 0..contactlist.length-1
  Pony.mail({
    :to => "#{contactlist[i][1]}",
    :from => 'from_email_address',
    :subject => subjectstring,
    :html_body => "Hi #{contactlist[i][0]}," + htmlsource.join,
    :content_type => 'text/plain',
    :body => %Q{Plain text here!},
    :via => :smtp,
    :via_options => {
      :address              => 'smtp_address',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => 'user_name',
      :password             => 'password',
      :authentication       => :login, # :plain, :login, :cram_md5, no auth by default
      :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
    }
  })
  puts "Sent #{i+1}"
  sleep(10)
end




