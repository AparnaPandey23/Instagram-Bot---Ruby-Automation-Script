require 'watir'
require_relative './credentials' #[in same folder]

#storing the user details in variables from credentials.rb 
username = $username;
password = $password;
#-------------------------------Initial log in----------------------------------------------------------#

#Open browser , navigate to login page 
caps = Selenium::WebDriver::Remote::Capabilities.chrome
caps[:chrome_options] = {detach: true}
browser = Watir::Browser.new :chrome, desired_capabilities: caps
browser.goto "instagram.com/accounts/login/" 

# Navigate to username and password fields and inject info
puts "Logging in.."
browser.text_field(:name =>"username").set "#{username}"
browser.text_field(:name =>"password").set "#{password}"

# Click log in button
browser.button(:class => "_0mzm- sqdOP  L3NKy  ".split).click
sleep(2)

#opens my page 
puts "Logged in successfully"

# If Turn On Notifications modal is present, we close it
if browser.div(:class => ['pbNvD', 'fPMEg']).exists?
    browser.button(:class => ['aOOlW', 'HoLwm']).click
end
#-----------------------------------Scrolling through homepage and liking pics----------------------------------------------------------#

# defining defaults
unlike_counter = 0
MAX_UNLIKES = 10
 
sleep(2)
loop do
    # do the scrolling 3
    3.times do |i| browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)") #used to scroll on the homepage 
    sleep(3)
end

if browser.span(:class => ["glyphsSpriteHeart__filled__24__red_5", "u-__7"],aria_label:"Unlike").exists? #checks if unlike button exists.. if it does click it
    browser.spans(:class => ["glyphsSpriteHeart__filled__24__red_5", "u-__7"],aria_label:"Unlike").each { |val|
      val.click
      unlike_counter += 1
    }
    puts "Photos unliked: #{unlike_counter}" #used to keep track of unlikes
else
    puts "No media to unlike right now"
end
break if unlike_counter >= MAX_UNLIKES #stop unliking pictures if counter exceeds limit specified
  sleep(3) # Return to top of loop after this many seconds to check for new photos
  puts "Exit the auto-unliker loop"
end
#-----------------------------------------End--------------------------------------------------------------------------------------#






