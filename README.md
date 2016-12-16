# Twitter-Video-Uploader
Hello guys, When i was trying to upload video to twitter with Twitter Gem, i had really bad times. It was incredibly hard. So i decided to write video upload program for twitter.

How to use this ruby file

1- Put this(twitter_video.rb) to somewhere in your project that you can reach easily.

2- Run `Bundle install`

3- In your code blocks call the file by this  
```ruby
require_relative 'your/path/to/twitter_account.rb'
```

3- Initialize the class in the file by typing this in your code file
```ruby
TwitterVideoUploader.new(video_path, account_username, account_password, consumer_key, secret_key, status_message).upload
```

3.5 Or you can do this
```ruby
twitter_video = TwitterVideoUploader.new(video_path, account_username, account_password, consumer_key, secret_key, status_message)

twitter_video.upload
```
4- Open the terminal and run your file

5- Final and the most important one is Enjoy :kissing_heart:



###### Made with :heart: in Istanbul
