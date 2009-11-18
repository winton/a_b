a\_b\_plugin
============

Talk to <code>a_b</code> from your Rails or Sinatra app.

Install
-------

<pre>
sudo gem install a_b_plugin --source http://gemcutter.org
</pre>

Setup
-----

You will need to make a call to <code>ABPlugin.config</code> when your app boots:

<pre>
ABPlugin.config 'kTJkI8e56OisQrexuChW', 'http://ab.mydomain.com'
</pre>

The first parameter is the persistence token from the user you created in <code>a_b</code>.

The second parameter is the URL to your <code>a_b</code> server.