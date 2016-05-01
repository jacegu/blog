Starting with EventMachine II
en
2013-03-25
Writing evented code has implications that may not be explicit at first look. There are 3 aspects that will be affected: flow, program structure and testing.

This blog post is an extract of an ebook about EventMachine that I started
writing some time ago. Somehow it ended up half written in some dark corner
of my hard drive. I have decided to publish the material I have as series of
posts. **Please let me know if you find the material useful.**

You can find all posts here:

- [Starting with EventMachine I](/blog/starting-with-eventmachine-i)
- [Starting with EventMachine II](/blog/starting-with-eventmachine-ii)
- [Starting with EventMachine III](/blog/starting-with-eventmachine-iii)
- [Starting with EventMachine IV](/blog/starting-with-eventmachine-iv)

Despite being a pretty simple six line example, in
[the last post](/blog/starting-with-eventmachine-i) you could get the
feeling of how building an EventMachine application will be. Evented code
has certain characteristics that make it different from the plain old
sequential code that we are used to write.

## Getting the feeling of evented code
### The mind shift
In the procedural world all code is executed in the order it appears in our files.

<pre><code data-language="ruby">response1 = Net::HTTP.get_response(uri1)
puts response1.code
puts response1.body

response2 = Net::HTTP.get_response(uri2)
puts response2.code
puts response2.body

response3 = Net::HTTP.get_response(uri3)
puts response3.code
puts response3.body</code></pre>

This code will first perform the first HTTP request. Once the response comes back it will print out the status code and, once that has been printed, it will output the response body. It will repeat this for requests 2 and 3. When this code is run it will follow the exact order the code does.

However, in the land of events that no longer applies. Our code runs in response to things happening.

<pre><code data-language="ruby">request1 = EM::MadeUpHTTP.get(uri1)
request1.callback do |response1|
  puts response1.code
  puts response1.body
end

request2 = EM::MadeUpHTTP.get(uri2)
request2.callback do |response2|
  puts response2.code
  puts response2.body
end

request3 = EM::MadeUpHTTP.get(uri3)
request3.callback do |response|
  puts response3.code
  puts response3.body
end</code></pre>

The output of this code can't be predicted. You won't know which response will arrive first so you can't know the order in which callbacks will be run either. The responses can arrive in any order. It can be `response1` the one that comes first but it could also be `response2` or `response3`. It does nothing to do whit the flow of the code nor the order in which the requests were made. The callbacks will be executed asynchronously. **The only thing that remains synchronous is the execution of the code inside the callbacks**. That's the only place where the rules of the procedural world still apply.

It will require a mind shift but you will need to start structuring your code around responding to events instead of around performing a sequence of actions. **The flow of the program depends on the flow of events not on the flow of the code**.

You will also need to understand the ecosystem where your code is running: check out this alternate version of the hello world example. It uses the same constructs as the previous one with minor changes: the `EM.stop` call has been taken out of the timer callback and we are now handing the event *zero seconds passing by*.

<pre><code data-language="ruby">EM.run do
  puts "starting EventMachine at \#{format_as_hhmmss(Time.now)}"
  EM.add_timer(0) { puts "Hello world" }
  EM.stop
  puts "stopping EventMachine at \#{format_as_hhmmss(Time.now)}"
end</code></pre>


Even if the call to the `EM.add_timer` method appears before the one to `EM.stop`, and even if we are waiting for 0 seconds to pass by, the code in the callback will never be executed. You will also see the second message even if we are stopping EventMachine in the previous line:

    starting EventMachine at 17:17:37
    stopping EventMachine at 17:17:37

In this case we are not letting the event loop start handling events: we are stopping it right in the setup phase. This is the reason why we were calling  `EM.stop ` inside the callback in the first example: to make sure that EventMachine waits for the event to be triggered and handled.


### Block nightmare
EventMachine relies heavily on Ruby blocks for callback setting. Most of the times callbacks trigger new events that will also need to be handled.  That means that we can end up with a lot of block nesting and that can make the code really hard to understand.

Let's take what a web application usually does as an example: it will receive a request through a certain route, get some information out of the database and render some HTML that will be returned in the response.

Let's shape that into a made-up EventMachine-based web framework:

<pre><code data-language="ruby">EM.run do
  # other routes...
  on_request('/user/:id') do |params|
    query = prepare_query(params)
    query_db(query) do |query_results|
      user = process(query_results)
      render('profile.haml', locals: { user: user }) do |html|
        respond_with status: 200, body: html
      end
    end
  end
  # even more routes...
end</code></pre>

I know what you are thinking: that code smells pretty badly!

If you have read Robert C. Martin's Clean Code[^C1_1] you already know that having more than one indentation level should be avoided. We have four indentation levels in nine lines of code, shaping our program into that horrible pyramid.

[^C1_1]: Clean Code: A Handbook of Agile Software Craftsmanship (Robert C. Martin)

Besides that you can easily tell that this code breaks several
OO principles. And, to tell you the truth, I don't think it is object oriented at all.

Of course, evented code does not have to be like this. There are several patterns you can apply to design object oriented EventMachine applications. You can also take advantage of the Proc building capabilities Ruby has to make it look even more like so. And the Ruby fibers that were introduced in 1.9 can also be helpful getting your program's API to look more synchronous.


### Testing
We should test all the code we write. In fact we shouldn't write any production code without a having failing test[^C1_02] first. If this statement is true in the procedural world it is even more important in the land of events. However, testing event oriented code can be really hard. Could you imagine the test setup that would be required to test our web application example? The amount of stubbing it would require to be run?

[^C1_02]: One of the three laws of Test-Driven Development

But you will find other problems testing EventMachine applications even with code as simple as our *hello world* example. Let's give it a try (removing the noise of the start and stop messages):

<pre><code data-language="ruby">def evented_hello_world
  EM.run do
    EM.add_timer(2) do
      puts "Hello world"
      EM.stop
    end
  end
end

describe 'evented hello world' do
  it 'prints out hello world after two seconds' do
    start_time = Time.now
    STDOUT.should_receive(:puts).with('Hello world')
    evented_hello_world
    finish_time = Time.now
    (finish_time - start_time).should be_between(1.95, 2.15)
  end
end</code></pre>

Lets run the test:

    evented hello world
      prints out hello world after two seconds

    Finished in 2.1 seconds
      1 example, 0 failures

This single spec takes more than two seconds to pass. Can you imagine how long it would take to run the test suite of a whole app?[^C1_03] Imagine an application with a few `EM.add_timer(60)` and everyone will agree that this kind of testing is a no go… We can do better.

[^C1_03]: Yes, more or less the same it takes a Rails test suite to run.

You may be wondering if there are specific tools to test evented applications. There are several gems designed to test EventMachine applications specifically. The thing is that they are not needed. At the end of the day you are writing Ruby code so you should be able to test evented code with the tools you are already familiar with.
