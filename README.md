# NYC MOTI OPEN BID

This is a web application used to manage the bidding process for MOC's
[micro-purchase threshold
experiment]. The
platform will allow vendors to bid on open opportunities with NYC MOCs, track their
bids, and learn of the winning bidder. So long as vendors are registered on
The NYC Payment Portal (PIP) and have GitHub accounts, they will be able to
view open opportunities and bid on them.

With this application, a vendor will be able to view the full list of open
opportunities, access bid histories, and place bids on services
requested by NYC Agencies. All bids will start under $3,500 and each project will specify
the desired product and method of delivery.

This is a Ruby/Rails application using ActiveRecord and PostgreSQL. This repo
contains the front end of a web app that integrates GitHub and NYC Checkbook. For more
information on setting up the back end of the web app, see below.

## Documentation

### Methods and classes

## Local Development

See the [local development docs](docs/local_development.md) for information on
setting up the codebase and running tests locally or with Docker.

## Secret Deploy Trigger
visit /admin/update/pull (requires logged in as admin), it will make a git pull from stage branch on both app server 1 and app server 2 and restart phusion passenger so you can see any changes made to git

TODO: use environment variables so it updates from the correct branch between stage and production
