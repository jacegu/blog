require 'publication_time'

describe PublicationTime do
  let(:publication_time){ DateTime.parse('2011/01/01 10:00:00+00:00') }

  before do
    publication_time.extend(PublicationTime)
  end

  describe 'past?' do
    it 'is true  if publication time is past' do
      DateTime.stub(:now).and_return DateTime.parse('9999/12/31')
      publication_time.should be_past
    end

    it 'is false if publication time is future' do
      DateTime.stub(:now).and_return DateTime.parse('1900/01/01')
      publication_time.should_not be_past
    end
  end

  describe '#to_rfc822' do
    it 'returns a rfc822 compilant datetime string' do
      publication_time.
        should_receive(:strftime).with(PublicationTime::RFC822_FORMAT)
      publication_time.to_rfc822
    end
  end
end
