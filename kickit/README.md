kickit
======

Configures the kickit ruby script that runs as a daemon and listens for an http connection on port 5425 (KICK).

To kickit, visit `http://your.host.name:5425/` in a browser

WARNING
------

Do not use this in a production or on an internet facing host. It has not been tested and is not secured.

Requirements
-----------

* Currently chef-client needs to be run as a daemon for this to work but this will change in the future

Files
-----

- kickit.rb - Tiny http server script that runs as a daemon
- kickit.conf.upstart - Ubuntu upstart script
- kickit.plist - OSX Launchd config file

Usage
----

Add a depends for the kickit cookbook in your metadata.rb
``` ruby
depends 'kickit'
```

Include the kickit cookbook somewhere that makes sense
``` ruby
include_recipe 'kickit'
```

Platform Support
----------------

Current tested on...
- Ubuntu - 12.04, 13.04
- OSX - Mavericks

ToDo List
----------------

* Migrate away from requring chef to run as a daemon and manage the entire life cycle of chef-client
* Watch the lockfile to ensure completion possibly with a timeout (thanks to tips from coderanger)

