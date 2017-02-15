# docker-wordpress-wp-cli-xdebug (with tcpdump for debugging)

This is an image based off of [Conetix's docker-wordpress-wp-cli](https://github.com/conetix/docker-wordpress-wp-cli), forked from [Johnrom's docker-wordpress-wp-cli-xdebug](https://github.com/johnrom/docker-wordpress-wp-cli-xdebug), and then simplified. Roundabout, but thanks to all along the way!

This repository adds xDebug support to the WordPress container for Docker.

Additionally, it removes an opcache configuration file that the WordPress image installs because it appeared to affect PHP Opcode Caching on my machine. You shouldn't notice a difference unless your local machine gets a lot of hits, *lol*.

**This is super untested.** Do not use in production.

To use, you'll have to pass a variable to XDebug with your IP Address. Please note, this is the IP address of your machine, not the docker VM. It is generally a 192.168.\* address. You can find it a number of ways, usually it can be found somewhere in the `ifconfig` data.

Example: `192.168.1.100`

Are you the only one developing your project? Try:

```
wp_site:
  image: eceleste/docker-wordpress-wp-cli-xdebug
  ... [ your regular configuration ]
  environment:
    XDEBUG_CONFIG: remote_host=192.168.1.100
```
