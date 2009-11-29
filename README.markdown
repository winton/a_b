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

You will need to do this when your app boots:

<pre>
ABPlugin.token = 'kTJkI8e56OisQrexuChW'
ABPlugin.url = 'http://ab.mydomain.com'
</pre>

Token is the persistence token from the user you created in <code>a_b</code>'s <code>script/console</code>.

URL is the address of your <code>a_b</code> server.