class ScrubValidator < ApplicationRecord

  LIST_OF_SOURCES = []

  def self.validate(params)
    if !source_valid?(params["source"])
      return "Source not on list of approved sources"
    elsif  !callback_valid?(params["callback"])
      return "A callback must be provided"
    elsif !uri_valid?(params["uri"])
      return "An url for the image must be provided"
    end
    return true
  end

  def self.callback_valid?(callback)
    !!callback
  end

  def self.uri_valid?(uri)
    !!uri
  end

  def self.source_valid?(source)
    return false if !source
    LIST_OF_SOURCES.any? {|element| element.downcase == source.downcase}
  end

  def self.send_to_queue
    #to be implemented
  end
end
