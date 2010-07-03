a\_b\_plugin
============

Talk to <code>a\_b</code> from your Rails or Sinatra app.

[What the hell is <code>a_b</code>?](http://github.com/winton/a_b)

Install
-------

<pre>
sudo gem install a_b_plugin
</pre>

Setup
-----

### Configuration

Create <code>config/a\_b.yml</code>:

<pre>
token: your_a_b_token_goes_here
development:
  site: My Site - Development
  url: http://127.0.0.1:3000
staging:
  site: My Site - Staging
  url: http://staging.mysite.com
production:
  site: My Site - Production
  url: http://mysite.com
</pre>

### Layout

<pre>
&lt;html&gt;
  &lt;head&gt;
    &lt;script src="http://github.com/winton/a_b/raw/master/public/js/a_b.js" type="text/javascript"&gt;&lt;/script&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;%= a_b %&gt;
  &lt;/body&gt;
&lt;/html&gt;
</pre>

Usage
-----

Before using the examples below, create a test and some variants from the <code>a_b</code> admin.

### Ruby

<pre>
a_b(:my_test).visit   # :my_variant
a_b(:my_test).convert # :my_variant
</pre>

<pre>
a_b(:my_test).visit(:my_variant)        # :my_variant
a_b(:my_test).convert(:my_variant)      # :my_variant
a_b(:my_test).visit(:my_other_variant)  # nil (:my_variant already selected)
</pre>

<pre>
a_b(:my_test).visit do |variant|
end
a_b(:my_test).convert do |variant|
end
</pre>

<pre>
a_b(:my_test).visit(:my_variant) do
end
a_b(:my_test).convert(:my_variant) do
end
</pre>

You can use the <code>a\_b</code> method in the controller or the view.

### Javascript

<pre>
a_b('my_test').visit();   # 'my_variant'
a_b('my_test').convert(); # 'my_variant'
</pre>

<pre>
a_b('my_test').visit('my_variant');   # true
a_b('my_test').convert('my_variant'); # true
</pre>

<pre>
a_b('my_test').visit(function(variant) {
});
a_b('my_test').convert(function(variant) {
});
</pre>

<pre>
a_b('my_test').visit('my_variant', function(variant) {
});
a_b('my_test').convert('my_variant', function(variant) {
});
</pre>

That's it!
----------

Visits and conversions are sent directly from the end user to the <code>a\_b</code> server via JSON-P.

Because of this, your application's performance is never affected by <code>a\_b</code> transactions.