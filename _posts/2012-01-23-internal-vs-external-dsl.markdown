Internal vs. External DSL
en
2012-01-23
Lately I've been struggling with one of my apprentice tasks because I only knew about Internal DSLs. It turns out that there is another kind: external DSLs

---

For those of you who have never heard about it, DSL stands for _Domain Specific Language_. Basically it's *a language which is built for a specific domain* (hence the name). They are pretty common in the computer world, and you may be using a few without even knowing it.

```
Domain-specific language: a computer programming language of limited expressiveness focused on a particular domain.
```

[RSpec](http://rspec.info/) or [Rake](http://rake.rubyforge.org/) Rake are clear examples of DSLs. They use all the power of the Ruby language to make you feel like using a language that was designed with a particular problem in mind.

This kind of DSL that bends and twists a host language to make it feel like a different one is known as *Internal DSL* and is the only kind of DSL I was aware of.

My current apprentice task involves building a DSL that is 100% in Spanish. Ruby is so flexible that you can do such a thing. But I also have very strong syntax constraints. That's why I have been struggling for a long time trying to build it an _Internal DSL_ to solve this particular problem.

Today (after my mentor asked me to write this post) I have learned that *there is another type of Domain-specific Languages: the external ones*.

It turns out that Cucumber is an external DSL. But also CSS, Sass and many other technologies that I would have never considered a Domain Specific Language, are such a thing.

_External DSLs_ have their own syntax instead of being built on top of a language. All you need to make it work is a parser that interprets the language or that translates it to another one.

[This post](http://martinfowler.com/bliki/DomainSpecificLanguage.html) by Martin Fowler has been really helpful to understand the whole thing. Now I know how to complete my task.
