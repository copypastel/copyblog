@author daicoden
@title Mephisto With a Prefix Path
@verb codes

## Intro

Turns out I'm not good at blogging.  So screw it.  This is for those of you who need to:

* Setup Mephisto in a subdirectory
* Getting a sanitation error when accessing admin on a subdirectory mounted mephisto app
* Those of you who searched for setting up Mephisto with a prefix (Go Go Keyword Parsing)

It took me two hours to get mephisto running on a prefix path.  It seems there is a post lacking.  This is running with Apache 2 and [bleeding edge mephisto](http://github.com/emk/mephisto/commit/0535b5ff99d45c94e6cb5d54d8ddaf24081840bd).

## What to do

We will use `port 3456` and `prefix blog` for this example

1. Do the installation get it running.
2. Edit `app/views/layouts/application.html.erb` and change line 9 from: `<script type="text/javascript">Mephisto.root = '<%= relative_url_root %>'; <%= init_mephisto_authenticity_token %></script>` to `<script type="text/javascript">Mephisto.root = '<%= h(relative_url_root) %>'; <%= init_mephisto_authenticity_token %></script>`.  Note the h() around relative_url_root.  This would have caused problems when accessing admin once you are setup.
4. Setup apache in `/etc/httpd/conf/extra/httpd-vhosts.conf` with the following:

    <VirtualHost *:80>
        ServerAdmin webmaster@damain.com
        DocumentRoot "/var/www/domain"
        ServerName domain.com
    
        ServerAlias www.domain.com
        ErrorLog "/var/log/httpd/damain.com-error_log"
        CustomLog "/var/log/httpd/domain.com-access_log" common

        <Directory "/var/www/domain">
            Order allow,deny
            Allow from all
        </Directory>
        ProxyPass /blog http://domain.com:3456/blog
        ProxyPassReverse /blog http://domain.com:3456/blog
        ProxyPreserveHost on
        ProxyPass /blog/images !
        ProxyPass /blog/stylesheets !
        ProxyPass /blog/javascripts !

        Alias /blog/images /var/www/blog/public/images
        Alias /blog/stylesheets /var/www/blog/public/stylesheets
        Alias /blog/javascripts /var/www/blog/public/stylesheets

        <Directory /var/www/blog/>
            Order Allow,Deny
            Allow From all
        </Directory>
    </VirtualHost>
    
  For those of you who are curious as to why you point the proxy pass to domain.com:3456/blog it's because using the prefix option for mongrel mounts the whole thing on /blog.  But you need apache to catch the /blog and route it somewhere different (not the root server).  If you just routed it to :3456/ you would have to visit /blog/blog.  One for apache and one for mongrel.  You have to use the prefix option however because all of your resources need to be at /blog.
5. Enable the vhost file if you don't have it.  It's somewhere commented in your apache config file.
6. start the server with mongrel_start -e production -p 3456 -d --prefix /blog

## Conclusion

Short and Sweet.

This lets you have several applications on one domain and make them look seamless.  I prefer users not to have to change subdomains when going between my rails driven apps and the main site, especially when the rails app is just informational.