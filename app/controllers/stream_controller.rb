class StreamController < ApplicationController
  def index
    @stream = Stream.new.body
  end
end
