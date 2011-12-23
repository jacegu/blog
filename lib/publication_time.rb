require 'date'

module PublicationTime
  RFC822_FORMAT = "%a, %d %b %Y %T %z"

  def to_rfc822
    strftime(RFC822_FORMAT)
  end

  def past?
    self < DateTime.now
  end
end

class DateTime
  include PublicationTime
end
