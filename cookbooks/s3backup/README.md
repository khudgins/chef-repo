= DESCRIPTION:

This cookbook will set up some crontab entries to back up your selected
resources to Amazon S3.

AWS Credentials
===============

Note: I'm cribbing this bit entirely from Opscode's AWS cookbook. It works, and will allow you to more easily reuse your credentials if you need to!

In order to manage AWS components, authentication credentials need to be available to the node. There are a number of ways to handle this, such as node attributes or roles. We recommend storing these in a databag (Chef 0.8+), and loading them in the recipe where the resources are needed.

DataBag recommendation:

    % knife data bag show aws main
    {
      "id": "main",
      "aws_access_key_id": "YOUR_ACCESS_KEY",
      "aws_secret_access_key": "YOUR_SECRET_ACCESS_KEY"
      "s3_backup_bucket": "YOUR_BACKUP_S3_BUCKET"
    }

This can be loaded in a recipe with:

    aws = data_bag_item("aws", "main")

And to access the values:

    aws['aws_access_key_id']
    aws['aws_secret_access_key']

We'll look at specific usage below.

---

Backup List
===========

Backups are performed via crontab entries in /etc/cron.frequency.
These are configured via another databag, the format is below:

    % knife data bag show backup list
    {
	    "type": "file"
	    "list": "/path/to/file /path/to/dir"
	    "frequency": "weekly"
	  }
}

Recipes
=======

default.rb
----------

The default recipe installs the `right_aws` RubyGem, which this cookbook requires in order to work with the EC2 API. Make sure that the aws recipe is in the node or role `run_list` before any resources from this cookbook are used.

    "run_list": [
      "recipe[aws]"
    ]

The `gem_package` is created as a Ruby Object and thus installed during the Compile Phase of the Chef run.


= REQUIREMENTS:

= ATTRIBUTES:

= USAGE:

