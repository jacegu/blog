module Mog
  module Errors
    Error        = Class.new(StandardError)
    PostNotFound = Class.new(Error)
  end
end
