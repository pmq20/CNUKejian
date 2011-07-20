# CNUKejian

CNUKejian is a courseware sharing system designed for Capital Normal University.
If you are inside Capital Normal University Intranet, this system can be reached at [192.168.145.253](http://192.168.145.253).

## Adjust Some Constants

Some constants are recorded inside `config/initializers/constants.rb`.

	* DATA_DIR is where user uploaded files are stored
	* LOGINPATH is a valid user that can be used to initially log in for intial info importing, see the next section
``` ruby
DATA_DIR = '/data_remote'
LOGINPATH = 'http://202.204.208.75/loginAction.do?zjh=student_number&mm=password_md5_hash'
```

## Initial Information Importing

It automatically imports courses information automatically from the pre-existing [URP综合教务系统](http://202.204.208.75) system of the school.

This is done by utilizing [mechanize](https://rubygems.org/gems/mechanize) gem

Initial importing scripts lives under config/makecnu, please execute them in order

	001_touch_institutes.rb
	002_touch_courses.rb
	003_fix.rb
	004_deduplicate.rb
	005_dedup_more.rb
	006_update_cache.rb
	007_check_file_existance.rb

`xe` and `ex` are some examples of the information read, exported by `export.rb`.

## Course Information Maintainace

After the initial importing phase, when the user registers, the system tries to login to the pre-mentioned system with the password of the user.

If succeeded, it will again try to read some information out of that system.

For more info, please inspect the User.import_info method:

``` ruby
def import_info(deep=false)
	begin
		agent = Mechanize.new
		agent.get("http://202.204.208.75/loginAction.do?zjh=#{self.number}&mm=#{self.md5pass}")
    self.memo = '' if !self.memo
		if nil==agent.page.forms[0]
			self.memo += "Logged in.\n"
			if 0==self.identified
			  self.credit += 8
				...
				...
```

## Other Features

	* User avatar selection
	* Various user statistics information
	* Comment to a certain courseware
	* Courseware rank list
	* Admin features(set user.is_admin to true to add admins)
	* Et cetera

## The Movie

Have you seen the movie [CNUKejian](http://www.tudou.com/programs/view/cs_3XbMm4Vg/)?

## Other issues

	* If your school also has a [URP综合教务系统](http://202.204.208.75) up and running, the code could apply to you directly.
	* Otherwise, you have to tune the code in order to make it work for your school.
	* Under GNU GENERAL PUBLIC LICENSE is this code available.
