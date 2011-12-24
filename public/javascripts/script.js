var quotes = {
  craftsman: {
    text: 'We are tired of writting crap.',
    author: 'Robert C. Martin'
  },
  kindred: {
    text: 'Nothing is more powerful than a community of talented people working on related problems.',
    author: 'Paul Graham'
  },
  perfectionist: {
    text: 'Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.',
    author: 'Antoine de Saint-Exupery'
  },
  minimalist: {
    text: '...in all the things, the supreme excellence is simplicity.',
    author: 'Henry Wadsworth Longfellow'
  },
  fanboy: {
    text: "The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it.",
    author: 'Steve Jobs'
  },
  lover: {
    text: "Beer: The cause of, and solution to, all of life's problems",
    author: 'Homer J. Simpson'
  }
}

function quoteFor(facet, text, author) {
  var element = $('#facets ul li.' + facet);
  var quote   = $('#facets #quote blockquote.quote');
  var cite    = $('#quotation-by');

  element.bind('mouseover', function() {
    quote.html(text);
    cite.html(author);
    quote.addClass('appear');
    cite.addClass('appear');
  });

  element.bind('mouseout', function() {
    quote.removeClass('appear');
    cite.removeClass('appear');
    quote.addClass('vanish');
    cite.addClass('vanish');
  });

}

quoteFor('craftsman', quotes.craftsman.text, quotes.craftsman.author );
quoteFor('kindred', quotes.kindred.text, quotes.kindred.author );
quoteFor('perfectionist', quotes.perfectionist.text, quotes.perfectionist.author );
quoteFor('minimalist', quotes.minimalist.text, quotes.minimalist.author );
quoteFor('fanboy', quotes.fanboy.text, quotes.fanboy.author );
quoteFor('lover', quotes.lover.text, quotes.lover.author );
