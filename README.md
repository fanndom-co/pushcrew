# Pushcrew

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/pushcrew`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Reference 
http://api.pushcrew.com/docs/introduction-to-rest-api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pushcrew'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pushcrew

## Usage

Please set a ENV['PUSHCREW_TOKEN'] in your project.

### Send to All Subscribers
    Pushcrew::PushNotification.send_to_all_subscribers({title:"Your_Title",message:"Your_Message",url:"Your_URL"})

### Send to Subscribers of a Particular Segment
    Pushcrew::PushNotification.send_to_subscribers_a_particular_segment({title:"Your_Title",message:"Your_Message",url:"Your_URL"}, "Your_SEGMENT_ID")

### Send to a List of Subscribers
    Pushcrew::PushNotification.send_to_a_list_subscribers({title:"Your_Title",message:"Your_Message",url:"Your_URL", subscriber_list: {"subscriber_list":["Your_SUBSCRIBER_ID"]}.to_json})

### Send to an Individual Subscriber
    Pushcrew::PushNotification.send_to_an_individual_subscribers(title:"Só uma",message:"Uma Mensagem",url:"Your_URL",subscriber_id:"Your_SUBSCRIBER_ID")

### Check Status of Notification Request
    Pushcrew::CheckStatus.notification_request("Your_NOTIFICATION_ID")

### Add A Segment
    Pushcrew::Segment.add_segment({name:"Your_SEGMENT_NAME"})

### Get List of Segments
    Pushcrew::Segment.get_list_segments

### Add Subscribers to a Segment
    Pushcrew::Segment.add_subscribers_to_segment({subscriber_list: {"subscriber_list":["Your_SUBSCRIBER_ID"]}.to_json},"Your_SEGMENT_ID")

### Get Subscribers in a Segment
    Pushcrew::Segment.get_subscribers_segment("Your_SEGMENT_ID")

### Get Segments for a Subscriber
    Pushcrew::Segment.get_segments_for_a_subscriber("Your_SUBSCRIBER_ID" )

### Remove Subscribers from a Segment
    Pushcrew::Segment.remove_subscribers_from_a_segment({"delete_list":["Your_SUBSCRIBER_ID"]}.to_json,"Your_SEGMENT_ID")

### Delete A Segment
    Pushcrew::Segment.delete_segment("Your_SEGMENT_ID")

### Get SubscriberID of current user(In your web console)
    console.log(pushcrew.subscriberId);

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/super-evil-unicorn/pushcrew/. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

