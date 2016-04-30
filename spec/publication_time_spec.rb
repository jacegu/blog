require 'publication_time'

describe PublicationTime do
  let(:publication_time){ DateTime.parse('2011/01/01 10:00:00+00:00') }

  before do
    publication_time.extend(PublicationTime)
  end

  describe '#to_rfc822' do
    it 'returns a rfc822 compilant datetime string' do
      expect(publication_time).
        to receive(:strftime).with(PublicationTime::RFC822_FORMAT)
      publication_time.to_rfc822
    end
  end
end
