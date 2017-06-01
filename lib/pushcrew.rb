require "pushcrew/version"

module Pushcrew

  require 'rest-client'
  require 'json'

  @@end_point = "https://pushcrew.com/api/v1/"

  @@SERVICE_HEADERS = {
    :Authorization  => "key=#{ENV['PUSHCREW_TOKEN']}"
  }

  # funcao de post generica
  def postRequest(payload, url)
    begin
      response = RestClient.post("#{@@end_point}#{url}", payload, headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  # funcao patch generica
  def patchRequest(payload, url)
    begin
      response = RestClient.patch("#{@@end_point}#{url}", payload, headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  # funcao de delete generica
  def deleteRequest(url)
    begin
      response = RestClient.delete("#{@@end_point}#{url}", headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  # funcao get generica
  def getRequest(url)
    begin
      response = RestClient.get("#{@@end_point}#{url}", headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    v = JSON.load response
    return v["data"] if v["data"] != nil
    return v
  rescue JSON::ParserError => err
    response
  end

  # funcao get generica
  def putRequest(payload, url)
    begin
      response = RestClient.put("#{@@end_point}#{url}", payload, headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    v = JSON.load response
    return v["data"] if v["data"] != nil
    return v
  rescue JSON::ParserError => err
    response
  end

  def handle_error_response(err)
    # MundipaggV1Sdk::AuthenticationError.new
    err_response = JSON.load(err.response)
    puts err_response["message"]
    puts JSON.pretty_generate(err_response["errors"]) unless err_response["errors"].nil?
    raise(::Exception.new( err_response["message"] ))
  end

  # Your code goes here...
end

class Pushcrew::PushNotification

  extend Pushcrew

  # Send to All Subscribers
  #
  # == Parameters:
  # @param notification [Hash]
  # @return [JSON]
  def self.send_to_all_subscribers(notification)
    postRequest(notification, "send/all")
  end

  # Send to Subscribers of a Particular Segment
  #
  # == Parameters:
  # @param notification [Hash]
  # @param segment_id [String]
  # @return [JSON]
  def self.send_to_subscribers_a_particular_segment(notification, segment_id)
    postRequest(notification, "send/segment/#{segment_id}")
  end

  # Send to a List of Subscribers!
  #
  # == Parameters:
  # @param notification [Hash]
  # @return [JSON]
  def self.send_to_a_list_subscribers(notification)
    postRequest(notification, "send/list")
  end

  # Send to an Individual Subscriber
  #
  # == Parameters:
  # @param notification [Hash]
  # @return [JSON]
  def self.send_to_an_individual_subscribers(notification)
    postRequest(notification, "send/individual")
  end

end

class Pushcrew::CheckStatus

  extend Pushcrew

  # Check Status of Notification Request
  #
  # == Parameters:
  # @param request_id [String]
  # @return [JSON]
  def self.notification_request(request_id)
    getRequest("checkstatus/#{request_id}")
  end

end

class Pushcrew::Segment

  extend Pushcrew

  # Add A Segment
  #
  # == Parameters:
  # @param segment [Hash]
  # @return [JSON]
  def self.add_segment(segment)
    postRequest(segment, "segments")
  end

  # Get List of Segments
  #
  # @return [JSON]
  def self.get_list_segments()
    getRequest("segments")
  end

  # Add Subscribers to a Segment
  #
  # == Parameters:
  # @param subscribers_id [Hash]
  # @param segment_id [String]
  # @return [JSON]
  def self.add_subscribers_to_segment(subscribers_id, segment_id)
    postRequest(subscribers_id ,"segments/#{segment_id}/subscribers")
  end

  # Get Subscribers in a Segment
  #
  # == Parameters:
  # @param segment_id [String]
  # @param page_number [Interger]
  # @param items_per_page [Interger]
  # @return [JSON]
  def self.get_subscribers_segment(segment_id, page_number=1, items_per_page=2)
    getRequest("segments/#{segment_id}/subscribers?page=#{page_number}&per_page=#{items_per_page}")
  end

  # Get Segments for a Subscriber
  #
  # == Parameters:
  # @param segment_id [String]
  # @return [JSON]
  def self.get_segments_for_a_subscriber(segment_id)
    getRequest("subscribers/#{segment_id}/segments")
  end

  # Remove Subscribers from a Segment
  #
  # == Parameters:
  # @param subscribers_id [Hash]
  # @param segment_id [String]
  # @return [JSON]
  def self.remove_subscribers_from_a_segment(subscribers_id, segment_id)
    putRequest(subscribers_id, "segments/#{segment_id}/subscribers")
  end

  # Delete A Segment
  #
  # == Parameters:
  # @param segment_id [String]
  # @return [JSON]
  def self.delete_segment(segment_id)
    deleteRequest ("segments/#{segment_id}")
  end

end
