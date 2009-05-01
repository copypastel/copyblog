@author ecin
@title Password Generation
@verb codes
@status :published => 05.15.09

## <a name = "The_Project">The Project</a>

I solved my password management problem years ago when I stumbled upon hashapass.com Being able to easily generate a different password for every account is the way to go as far as I’m concerned. But therein lies the problem: *easy* generation.

Being dependent on an online outfit can be cumbersome, what  with the looming fear that if the site goes down, there go your passwords.  Even if the site can be downloaded onto the desktop,  there’s still that little issue of usability.

Having to use a website requires one too many steps to get a password. Even using OS X’s Dashboard and a widget is troublesome: a mouse is still needed to select the widget. These are things we can improve on with a simple terminal app. Oh, and let’s write it in Ruby to keep things fun.

### <a name = "Algorithm">Algorithm</a>

Initially, I thought about using a hashing algorithm that’s independent from hashapass.com, but the prospect of needing to change all my current passwords made me think differently. Turns out, 10 minutes of delving into their javascript was enough to figure out that HMAC-SHA1 with a Base64 encoding is used for the hashing. With an extra 20 minutes I got a Ruby equivalent for the same operation.

### <a name = "Copy_to_Clipboard">Copy to Clipboard</a>

To make this work, there must be no need for text selection plus +C. I was lucky enough to recall it is possible to copy to OS X’s clipboard via the command line. In hindsight, I shouldn’t have been so [suprised](http://xkcd.com/530/). One quick Google search later, [<span style='font-family: monospace; letter-spacing: 2px;'>pbcopy</span>](http://developer.apple.com/DOCUMENTATION/Darwin/Reference/ManPages/man1/pbcopy.1.html) came up, and all was good. Well, almost: there was a problem with a newline being tacked on to whatever text got piped into <span style='font-family: monospace; letter-spacing: 2px;'>pbcopy</span>, which turned out to be <span style='font-family: monospace; letter-spacing: 2px;'>echo</span>’s default setting. <span style='font-family: monospace; letter-spacing: 2px;'>printf</span> is a better alternative for this case.

### <a name = "Options">Options</a>


There are two scenarios where copying the password directly to the clipboard may be vexing. Some entry forms don’t make use of the system clipboard, thus making it impossible to paste in a password. All right, so just add an option to display said password. The more concerning situation occurs when generating a new password for a new account: since a master password is needed for the hashing operation, that opens up an opportunity for a typo. Were it an old account, the user would likely try to generate the password again and miss the typo this time. However, the same user will be hard-pressed when trying to access a new account and not being able to generate the correct password due to the typo. Solution: add an option that confirms the inputted master password.

### <a name = "Omnipresence">Omnipresence</a>


Up to this point, the improvements over using a Dashboard widget aren’t really outstanding. Perhaps merely cosmetic. Having to launch a terminal window, or at least keep one around in the background to change to, really ruins the workflow. In the end, what really makes it all come together happens to be [visor.app](http://code.google.com/p/blacktree-visor/), which provides an ever present, Quake-style terminal.

## <a name = "End_Result">End Result</a>

So, how does the end product look? Take a glance.

<object width="400" height="300"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=2975677&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=2975677&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="400" height="300"></embed></object>

[password hashing by copypastel](http://vimeo.com/2975677") from [Ecin Krispie](http://vimeo.com/ecin) on [Vimeo](http://vimeo.com).


The code is Mac-only due to the use of <span style='font-family: monospace; letter-spacing: 2px;'>pbcopy</span>. Linux seems to have <span style='font-family: monospace; letter-spacing: 2px;'>xsel</span> produce the same results, though this remains untested by me.

Now to send it to the hashapass.com folks to help with distribution... grabbing the code from [github](http://github.com/ecin/hashapass.rb/tree/maste) is suggested. Hope this offers a decent solution to password management, at least until [OpenID](http://openid.net/) becomes a bit more pervasive. 

