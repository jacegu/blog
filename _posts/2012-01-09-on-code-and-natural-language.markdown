On code and natural language
en
2012-01-09
I gave a talk about the importance of code readability and how it is tightly related to code quality. But what is the readability level we should achieve?

---

On October I gave a talk (actually my first one at a big conference) at [Conferencia Agile Spain 2011](http://conferencia2011.agile-spain.org).  _&ldquo;Por qué Cervantes programaba mejor que tú&rdquo;_ (why Cervantes wrote better code than you) was the talk's title. It was a reflection about how code readability relates to other code quality principles and heuristics we use on a daily basis.


You can watch the talk right here. But be aware: it's in spanish. The slides are [availiable on Slideshare](http://www.slideshare.net/agilespain/cas11talk-111027063557phpapp01)

<iframe src="http://player.vimeo.com/video/34459261" frameborder="0" class="vimeo" ></iframe>

The point I was trying to make was that *the easiest way to write better code is to focus on readability*.


But readability is subjective. This is also something I talked about. In fact in one of my last slides I put a example of the readability level I meant. It read exactly like de pseudo-code of the problem that was solved (slides [91](http://www.slideshare.net/agilespain/cas11talk-111027063557phpapp01/91) and [92](http://www.slideshare.net/agilespain/cas11talk-111027063557phpapp01/92). It was (or was intented to be) read like *natural language*.


## The importance of naming

<blockquote>One difference between a smart programmer and a professional programmer is that the professional understands that *clarity is king*. Professionals use their powers for good and write code that others can understand.  <cite>Clean Code, Robert C. Martin</cite></blockquote>

On my first college year I had a subject called something like _Computer Software Foundations_. The teacher told us that our job will be, mainly, *building levels of abstraction*. That, unlike many other things I was taught there, was true.

When we write code we are abstracting the pieces, building the abstractions, needed to solve a certain problem. Those pieces, whether they are functions, methods, classes or variables, have names. They can be nouns, adjectives, verbs or even questions or short sentences. But they are what will make our code understandable or not. That's why naming is so important.


### Ubiquitous Language

Those pices should be identifiable by anyone involved in the problem. And that doesn't mean only people who can actually read code. **Anyone**, from business to users, should be able to read a method name and tell what it is supposed to accomplish.


**We must call things what users, clients or stakeholders call them**. By listening and learning from what these people call things we should build an [Ubiquitous Language](http://domaindrivendesign.org/node/132).

### Mental mapping

One of the worst things we can do when we put names to things is _Mental Mapping_. This one is so bad it has its own section in Uncle Bob's [Clean Code](http://www.amazon.co.uk/gp/product/0132350882?ie=UTF8&amp;tag=yoyelsoft-21&amp;linkCode=as2&amp;camp=1634&amp;creative=6738&amp;creativeASIN=0132350882)

We are doing something wrong when we call something _foo_ when we talk with users or clients and this _foo_ thing has a totally different name in our code. So what we do is _mapping_ this name to the concept _foo_.

A really bad thing about mental mappings is that they have an expiration date: about two months after finishing a project nobody remembers them at all. So, when you revisit the code, you need to start asking what that thing named _blah_ was.

We must **avoid using a different name in the domain of the solution and the domain of the problem** without a good reason (and usually there is none).


## Natural language

Naming is the key factor if you want to write code that reads like natural language. It's the most important thing we should focus on. But we normaly name things _in isolation_. And, sometimes, when we put our pices together they just don't feel right.

Code that reads like prose isn't just based on naming. Even if we get the names right it might not _read right_. It might not be clear enough. It might sound weird or just plainly wrong.

### It's a design tool

**I have started to consider code that I can't make read as natural language a design smell**. If you focus on good naming and name abstractions properly and, when you put them together they are hard to understand, something is not right.

Usually that particular piece of code does too many things, or it's not at the right level of abstraction. It's code screaming at your face _refactor me, sir!_

### The benefits

You should be wondering if it's worth it to put so much effort on writing code that reads like a book. Well, the answer is yes. It totally pays off:

#### Maximizes clarity

Clarity is the most importnat quality code should exhibit. And there is no thing a human being reads and understands more easily than prose.

#### Helps building pieces at the right level of abstraction

Code that reads like natural language helps you getting the design right. It will aid writing the right pieces at the right size.

#### Anybody can understand what's going on

If your code reads like natural language even non-coders will be able to understand it.  If an end user reads it she can tell you what's wrong with it.

#### The business logic is right there

You won't have to go to other documents or places to read how a particular part of the system should behave. It's right there in plain English.
