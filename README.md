Stn - a Ruby client for the ServiceTitan API
======================================================

Stn helps you write apps that need to interact with ServiceTitan.

The **source code** is available on [GitHub](https://github.com/claudiob/stn) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/stn/frames).

[![Code Climate](https://codeclimate.com/github/claudiob/stn.png)](https://codeclimate.com/github/claudiob/stn)
[![Code coverage](https://img.shields.io/badge/code_coverage-100%25-44d298)](https://github.com/claudiob/bookmaker/actions)
[![Rubygems](https://img.shields.io/gem/v/stn)](https://rubygems.org/gems/stn)

After [registering your app](#configuring-your-app), you can run commands like:


```ruby
Stn::SecurityToken.create
Stn::Zip.all
```

The **full documentation** is available at [rubydoc.info](http://www.rubydoc.info/gems/stn/frames).

How to install
==============

To install on your system, run

    gem install stn

To use inside a bundled Ruby project, add this line to the Gemfile:

    gem 'stn', '~> 0.1.1'

Since the gem follows [Semantic Versioning](http://semver.org),
indicating the full version in your Gemfile (~> *major*.*minor*.*patch*)
guarantees that your project won’t occur in any error when you `bundle update`
and a new version of Stn is released.

Configuring your app
====================

In order to use Stn you must have credentials to the [ServiceTitan](https://www.servicetitan.com/) API.

Add them to your code with the following snippet of code (replacing with your own credentials):

```ruby
Stn.configure do |config|
  config.app_key = ''
  config.tenant_id = ''
  config.client_id = ''
  config.client_secret = ''
end
```

Configuring with environment variables
--------------------------------------

As an alternative to the approach above, you can configure your app with
variables. Setting the following environment variables:

```bash
export STN_APP_KEY=""
export STN_TENANT_ID=""
export STN_CLIENT_ID=""
export STN_CLIENT_SECRET=""
```

is equivalent to the previous approach so pick the one you prefer.
If a variable is set in both places, then `Stn.configure` takes precedence.

How to test
===========

To run tests:

```bash
rspec
```

By default, tests are run with real HTTP calls to ServiceTitan that must be
set with the environment variables specified above.


How to release new versions
===========================

If you are a manager of this project, remember to upgrade the [Stn gem](http://rubygems.org/gems/stn)
whenever a new feature is added or a bug gets fixed.
Make sure all the tests are passing and the code is 100% test-covered.
Document the changes in CHANGELOG.md and README.md, bump the version, then run:

    rake release

Remember that the stn gem follows [Semantic Versioning](http://semver.org).
Any new release that is fully backward-compatible should bump the *minor* version (1.x).
Any new version that breaks compatibility should bump the *major* version (x.0)

How to contribute
=================

Stn needs your support!
The goal of Stn is to provide a Ruby interface for all the methods exposed by the ServiceTitan API.

If you find that a method is missing, fork the project, add the missing code,
write the appropriate tests, then submit a pull request, and it will gladly
be merged!
