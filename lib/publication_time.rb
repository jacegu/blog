require 'date'

module PublicationTime
  RFC822_FORMAT = "%a, %d %b %Y %T %z"

  def to_rfc822
    strftime(RFC822_FORMAT)
  end
end

class DateTime
  include PublicationTime
end
