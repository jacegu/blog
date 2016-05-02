February Kata: Roman Numerals
en
2011-03-08
Katacast showing the implementation of the Roman Numerals kata in Ruby with RSpec and Autotest. My February katacast for the 12 months 12 katas initiative.

---

Well, although a little bit late (it's been a hell of a month), here we go again with another katacast.

The [February kata](https://github.com/12meses12katas/Febrero-Roman-Numerals) was Roman Numerals. It had two parts but I've only recorded the first one: transforming arabic to roman numerals.

<iframe src="http://player.vimeo.com/video/20765638" frameborder="0" class="vimeo"></iframe>

I have to tell that I'm not as happy with the result as I was with the String Calculator one. Maybe I should have practice it more. Maybe not. Anyway there are a few times during the Kata that I feel that I'm taking too long steps:

- **When I refactor to the recursive solution after passing the `III` spec**:

    After doing the kata quite a few times I find this step the best to take the recursive approach. With only 3 numbers it's easier to understand and quite simple. I don't feel comfortable with the fact that I could have refactored to a much simpler code like `'I' * self`. But after trying different approaches I find the recursive one the most understandable and readable.

- **When extracting known roman equivalences and obtaining the closest one**:

    This is the key step of my solution. I know the `select` chunk of code is quite complex the first time you see it. But I find it simpler than iterating over the equivalences or other approaches I tried. You find the equivalence that suits and apply it. Just that. It's exactly how you'd do it by hand:

        1978 = 1000 + 900 + 50 + 10 + 10 + 5 + 1 + 1 + 1
        1978 =    M +  CM +  L +  X +  X + V + I + I + I

    At this point, with 5 lines of code and the equivalence hash, the solution works.

- **When extracting the `RomanEquivalence` class**:

    During the [Coding Dojo in Valencia](http://blog.dev.openfinance.es/2011/03/ii-coding-dojo/) I showed this approach to [@borillo](http://twitter.com/borillo). He pointed out that the `select` chunk of code wasn't very understandable. It is not indeed.

    That's why I have pushed the implementation forward until extracting this complexity out of the `to_roman` method. That keeps the method to a higher level of abstraction that makes it much more clear.

    Although I'm increasing complexity by adding more elements (a second class) to the solution I think that the better understanding pays off (Laws of simple design: <i>maximize clarity</i> over <i>has fewer elements</i> ). What do you think?

    What I'm not so happy about is the refactoring process. I've tried to take small steps, but when I switch the implementation of `RomanEquivalence.closestTo(number)` to a factory method I feel I'm taking a huge leap forward. Maybe writing a separate spec for `RomanEquivalence` would have made me feel more comfortable.

Anyway, that's my solution. Now it's time to criticize it :-P. I have push it up to [a GitHub repository](https://github.com/jacegu/Febrero-Roman-Numerals/tree/master/jacegu).

I followed the suggestion made by [Pablo Alonso](http://alonsogarciapablo.com/) on the [String Calculator Katacast](http://jacegu.eu/aprendizaje/january-kata-string-calculator/) and used [KeyCastr](http://stephendeken.net/software/keycastr/) to display the keys I'm pressing. (Thanks to [@ecomba](http://twitter.com/ecomba) for pointing me to it).
