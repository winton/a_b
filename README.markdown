a\_b\_plugin
============

Talk to <code>a\_b</code> from your Rails or Sinatra app.

[What the hell is <code>a_b</code>?](http://github.com/winton/a_b)

Install
-------

<pre>
sudo gem install a_b_plugin --source http://gemcutter.org
</pre>

Setup
-----

### Configuration

Create <code>config/a_b.yml</code>:

<pre>
development: &base
  site: My Site - Development
  token: token_goes_here
  url: http://ab.mydomain.com
production:
  site: My Site - Production
  <<: *base
staging:
  site: My Site - Staging
  <<: *base
</pre>

### Layout

<pre>
&lt;html&gt;
  &lt;body&gt;
    &lt;script src="http://github.com/winton/a_b/raw/master/public/js/a_b.js" type="text/javascript"&gt;&lt;/script&gt;
    &lt;%= a_b %&gt;
  &lt;/body&gt;
&lt;/html&gt;
</pre>

Usage
-----

Before using the examples below, create a test and some variants from the <code>a_b</code> admin.

### Ruby

<pre>
a_b(:my_category, :my_test) do |test|
  test.visit    # returns :my_variant
  test.convert  # returns :my_variant
end
</pre>

<pre>
a_b(:my_category, :my_test).visit   # returns :my_variant
a_b(:my_category, :my_test).convert # returns :my_variant
</pre>

<pre>
a_b(:my_category, :my_test).visit(:my_variant)        # returns :my_variant
a_b(:my_category, :my_test).convert(:my_variant)      # returns :my_variant
a_b(:my_category, :my_test).visit(:my_other_variant)  # returns nil (:my_variant already selected)
</pre>

<pre>
a_b(:my_category, :my_test).visit do |variant|
  # variant equals :my_variant
end
a_b(:my_category, :my_test).convert do |variant|
  # variant equals :my_variant
end
</pre>

<pre>
a_b(:my_category, :my_test).visit(:my_variant) do
  # executes if :my_variant selected
end
a_b(:my_category, :my_test).convert(:my_variant) do
  # executes if :my_variant selected
end
</pre>

You can use the <code>a\_b</code> method in the controller or the view.

### Javascript

<pre>
a_b('my_category', 'my_test', function(test) {
  test.visit();    # returns 'my_variant'
  test.convert();  # returns 'my_variant'
});
</pre>

<pre>
a_b('my_category', 'my_test').visit();   # returns 'my_variant'
a_b('my_category', 'my_test').convert(); # returns 'my_variant'
</pre>

<pre>
a_b('my_category', 'my_test').visit('my_variant');   # returns 'my_variant'
a_b('my_category', 'my_test').convert('my_variant'); # returns 'my_variant'
</pre>

<pre>
a_b('my_category', 'my_test').visit(function(variant) {
  // variant equals 'my_variant'
});
a_b('my_category', 'my_test').convert(function(variant) {
  // variant equals 'my_variant'
});
</pre>

<pre>
a_b('my_category', 'my_test').visit('my_variant', function() {
  // executes if 'my_variant' selected
});
a_b('my_category', 'my_test').convert('my_variant', function() {
  // executes if 'my_variant' selected
});
</pre>

Environment
-----------

With <code>a_b</code>, you have the ability to track the percentage of visits or conversions that fit a certain profile, such as logged in users, or users that came from Google:

### Ruby

<pre>
a_b.env = { :logged_in => true }
a_b.env[:from_google] = false
</pre>

### Javascript

<pre>
a_b.env = { logged_in: true };
a_b.env['from_google'] = false;
</pre>

The environment must be a hash with boolean values.

The environment maintains state for the entire session.

You may also set the environment on a temporary basis:

### Ruby

<pre>
a_b(:my_category, :my_test, :logged_in => true).visit
</pre>

### Javascript

<pre>
a_b('my_category', 'my_test', { logged_in: true }).visit();
</pre>

That's it!
----------

Visits and conversions are sent directly from the end user to the <code>a\_b</code> server via JSON-P.

Because of this, your application's performance is never affected by <code>a\_b</code> transactions.