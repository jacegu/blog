Starting with EventMachine IV
en
2013-06-15
Using EventMachine is not easy and people make well known mistakes. Let's review the most common ones and find and explain the problems behind them.

---

This blog post is an extract of an ebook about EventMachine that I started
writing some time ago. Somehow it ended up half written in some dark corner
of my hard drive. I have decided to publish the material I have as series of
posts. **Please let me know if you find the material useful.**

You can find all posts here:

- [Starting with EventMachine I](/blog/starting-with-eventmachine-i)
- [Starting with EventMachine II](/blog/starting-with-eventmachine-ii)
- [Starting with EventMachine III](/blog/starting-with-eventmachine-iii)
- [Starting with EventMachine IV](/blog/starting-with-eventmachine-iv)

## Doing it the wrong way
For a long time Ruby's threading issues have been a problem for application scalability and performance. EventMachine is a great tool to tackle that problem. But it's no silver bullet. It has its drawbacks and you need to be aware of them in order to unleash all it's potential.

*Asynchronous I/O for your Ruby programs*. The title of the book[^C1_10] already points to the kind of Ruby application that may take advantage of EventMachine's capabilities. You won't make a CPU-heavy program faster by throwing this library in (or any other reactor based library for that matter). The reactor is the heart and soul of EventMachine and its strengths and weaknesses are shared.

[^C1_10]: Remember: this is an extract of an unfinished e-book.

That's why you should know this pattern well. Learning the frequent mistakes that people make using it and how to avoid them is something any developer using EventMachine should read about.

### Blocking the reactor
Web applications are I/O heavy. Receiving requests and returning responses is reading-from and writing-into sockets. That's pure input and output operations. We may think that web applications are a good fit for reactor based libraries and frameworks, right? The answer, like in almost any software problem, is *it depends*.

It is true that asynchronous operations will make the reactor shine. The reactor thread doesn't block waiting for requests to come. The operating system will notify when there is information available. In the meantime the application can be serving other requests. The same thing will happen handling responses: the write operation will be executed asynchronously without blocking the thread. It's concurrency paradise!

While it is true that receiving requests and sending responses will greatly benefit of the use of EventMachine we also need to consider what happens in between. If the responses are generated really fast, we truly are in concurrency paradise. We are in front the kind of software that truly fits the reactor pattern. But what happens if the application needs to perform some long running task before generating the response?

In the previous section we discussed how event demultiplexing works in EventMachine's reactor. Let's apply that knowledge to the processing of an HTTP request. When a socket has received the HTTP request information and it's ready to be read, the reactor will be notified by the operating system and it will dispatch the corresponding callback to process it. The callback will be invoked immediately. And, what's more important, **synchronously**. It takes control of the reactor's thread and **the event loop will be blocked until the callback execution is over**.

You may not see the implications blocking the reactor right now. Let's put an example so you can experiment them:

<pre><code data-language="ruby">EM.run do
  EM.add_periodic_timer(1) { puts 'sec' }
  EM.add_timer(1.01) { puts '1 second passed by' }
  EM.add_timer(2.01) { puts '2 seconds passed by'; }
  EM.add_timer(5.01) do
    puts '5 seconds passed by: stopping...'
    EM.stop
  end
end</code></pre>

[^C1_08]: We are adding a 0.1 to the non-periodic timers so we make sure that *sec* is printed out prior to the other messages that run almost simultaneously. We think the output is easier to follow that way. Otherwise we cant be sure of the order in which messages would be printed out.

We are introducing `EM.add_periodic_timer`, a new timer flavour that instead of running just once runs indefinitely. Along the periodic timer we are setting up other timers[^C1_08] that should produce the following output:

    sec
    1 second passed by
    sec
    2 seconds passed by
    sec
    sec
    5 seconds passed by: stopping...

Every second we will see *sec* printed out. Along those messages, we will see the specific messages when one and two seconds pass by. Finally, after five seconds, we will see the terminating message and the process will exit.

Now let's change one of the callbacks. We are going to block the reactor thread when handling the event *one second passing by* making the process sleep for ten seconds:


<pre><code data-language="ruby">EM.run do
  EM.add_periodic_timer(1) { puts 'sec' }
  EM.add_timer(1.01) do
    puts '1 second passed by'
    sleep 10
  end
  EM.add_timer(2.01) { puts '2 seconds passed by'; }
  EM.add_timer(5.01) do
    puts '5 seconds passed by: stopping...'
    EM.stop
  end
end</code></pre>


Lets check what is printed out to standard output:


    sec
    1 second passed by
    sec
    2 seconds passed by
    5 seconds passed by: stopping...


Wait a second! What's going on? This process has been running for more than ten seconds. Where are all the missing *sec* messages? Why didn't the other output get printed when it was supposed to? EventMachine is broken!

Actually it is not. Let's review the example to understand what's going on: The first event that will be triggered will be *one second passing by* corresponding to the periodic timer. A few reactor ticks later, once ten milliseconds have passed by, the next event will be dispatched. It's handler will be run and it will execute the `sleep 10` sentence. That will block the event loop thread. EventMachine won't be able to check whether more events have been triggered. For ten seconds the reactor won't *tick* at all.

When the process is done sleeping the event loop returns to its usual workflow finishing the previous iteration. In the next one it will start checking if `stop` has been called. Since the method hasn't been called yet it will verify if timers have expired. Given that more than ten seconds have gone by since the last check, three callbacks need to be executed: the one corresponding to the periodic timer, the one of the 2 seconds timer and, last, the one of the 5 seconds timer.

Once the timer events have been handled, the reactor will find the call `stop` and terminate.

In our case blocking the reactor has made us lost three periodic timer events plus delaying another three. There is no I/O involved in this example, but the results would be pretty much the same: no reads or writes would be performed while the event loop is blocked. Sockets ready to be read or written will queue and the throughput of the application would be very poor.

The reactor pattern excels at handling events with callbacks that are dispatched quickly. While a callback is being executed it can't deal with other events and that's bad for the performance of any EventMachine powered program.

So, keep it in mind at all times: **do NOT block the event loop**.


### Using synchronous I/O
In the previous example you can tell pretty easily what's blocking the reactor and why. There are other ways of causing the same issues that are way more subtle. One of the most common ways of doing it and not noticing is using gems that use blocking I/O.

If you use a gem that relies on libraries that are not reactor-aware the I/O operations that you perform won't be asynchronous. EventMachine won't handle those sockets or file descriptors and the read and writes from or to them will be blocking. You will be losing all the benefits the reactor pattern provides.

Lets change our previous example a little bit. We are going to remove the `sleep` and do some blocking I/O operation instead: we are going to get Twitter's landing page using Ruby standard library's HTTP capabilities (remember to require `net/http`). We will do it ten times in order to have the reactor blocked long enough so we can see the effects. We are also going to make our example last a little shorter: three seconds instead of five.

<pre><code data-language="ruby">URL = 'http://twitter.com'

EM.run do
  EM.add_periodic_timer(1) { puts 'sec' }
  EM.add_timer(1.01) do
    puts 'one second passed by'
    10.times do
      response = Net::HTTP.get_response(URI.parse(URL))
      puts response.code
    end
  end
  EM.add_timer(2.01) { puts 'two seconds passed by' }
  EM.add_timer(3.01) do
    puts 'three seconds passed by: stopping...'
    EM.stop
  end
end</code></pre>

The results will resemble to the ones we got blocking the loop with `sleep`:

    sec
    one second passed by
    200
    200
    200
    200
    200
    200
    200
    200
    200
    200
    sec
    two seconds passed by
    three seconds passed by: stopping...

While the requests are done no other event is handled by the reactor. We don't see the expected *sec* message when one second passes by, nor is EventMachine stopped after three seconds. We are losing events and making timers malfunction.

Now, let's swap our blocking HTTP library for an asynchronous one: [em-http-request](https://github.com/igrigorik/em-http-request). You will need to install the gem by running:

    gem install em-http-request

Then require it in your example code:


    require 'em-http'

Look carefully how the *one second passing by* event handler changes. We are now using non-blocking I/O and that means setting up our response status code output message inside a callback.

<pre><code data-language="ruby">EM.run do
  EM.add_periodic_timer(1) { puts 'sec' }
  EM.add_timer(1.01) do
    puts 'one second passed by'
    10.times do
      http = EM::HttpRequest.new(URL).get
      http.callback { puts http.response_header.status }
    end
  end
  EM.add_timer(2.01) { puts 'two seconds passed by' }
  EM.add_timer(3.01) do
    puts 'three seconds passed by: stopping...'
    EM.stop
  end
end</code></pre>

Let's run this code and analyse the output:

    sec
    one second passed by
    200
    200
    200
    sec
    two seconds passed by
    200
    200
    200
    200
    200
    200
    sec
    three seconds passed by: stopping...

We get the expected three *sec*s. Responses are handled without blocking the reactor and that means that *200* messages are placed among the timer-triggered ones[^C1_09]. Besides that you have experienced how fast asynchronous I/O can be.

[^C1_09]: If your network connection is slow three seconds may not be enough for the 10 requests to be responded. In that case you may not get the expected ten *200*. You can either increase the timer that will make EventMachine stop. There are better ways to ensure that you get the ten responses before stopping the reactor but we haven't seen them yet.

You may be wondering how can the performance improvement be so dramatic.

Every time we are calling a `get` on an `EM::HttpRequest` instance we are adding a socket to the resources handled by the reactor. Once done the event loop keeps ticking. Those connections will be handled within it. On every tick the reactor will poll those resources and trigger the corresponding callback if responses came back.

On the other hand, when we use `net/http`, every call to `get_response` blocks the thread waiting for the server to respond. It repeats the same process for each one of the ten requests that we are making. The reactor doesn't have a chance to go through it's usual event demultiplexing loop during that time. Hence the event loosing and timer events delaying.

That's why you always have be sure that you are using reactor aware libraries for I/O. Remember: **do NOT block the event loop**.
