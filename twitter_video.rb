require 'watir-webdriver'
require 'open3'
require 'json'
require 'colorize'

class TwitterVideoUploader
  def initialize(video_path, username, password, consumer_key, secret_key, status_message)
    @video_path = video_path
    @username = username
    @password = password
    @consumer_key = consumer_key
    @secret_key = secret_key
    @status_message = status_message
  end

  def upload
    stdin, stdout = Open3.popen3("twurl authorize -u #{@username} -p #{@password} --consumer-key #{@consumer_key} --consumer-secret #{@secret_key}")
    line = stdout.gets
    x = 6
    url = ' '
    while line[x] != ' '
      url += line[x]
      x += 1
    end
    puts 'Opening the browser for validation'.green
    b = Watir::Browser.new :chrome
    b.goto url
    b.text_field(id: 'username_or_email').set @username
    b.text_field(id: 'password').set @password
    b.button(id: 'allow').click
    code = b.code.text
    stdin.puts(code)
    puts 'Validation is done!'.green
    b.close
    puts 'Loading the file...'.green
    output = `twurl -H upload.twitter.com "/1.1/media/upload.json" -d "command=INIT&media_type=video/mp4&total_bytes=#{File.new(@video_path).size}"`
    media_id = JSON.parse(output)['media_id']
    `twurl -H upload.twitter.com "/1.1/media/upload.json" -d "command=APPEND&media_id=#{media_id}&segment_index=0" --file #{@video_path}  --file-field "media"`
    `twurl -H upload.twitter.com "/1.1/media/upload.json" -d "command=FINALIZE&media_id=#{media_id}"`
    `twurl -d 'status=#{@status_message}&media_ids=#{media_id}' /1.1/statuses/update.json`
    puts 'Everything is done enjoy 😘'.green
    puts 'Bye 👋'.blue
  end
end
