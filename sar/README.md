sar
===

Description
===========

This cookbook installs sysstat, enables it and allows you to configure the frequency at which it collects statistics.

Attributes
==========

node['sar']['enabled'] - If sysstat logging is enabled (Default: true)
node['sar']['sa1_options'] - Configure sa1_options for systat config (Default: '-S DISK')
node['sar']['sa2_options'] - Configure sa2_options for systat config (Default: '')
node['sar']['cron']['run_every_minutes'] - Sets time between statistic collection cron job (Default: 2)

Usage
=====

Clone cookbook repository as sar

Somewhere in your recipe, include the sar recipe and add it as a dependency in your metadata.rb

metadata.rb
    depends 'sar'

your_recipe.rb
    include_recipe 'sar'


