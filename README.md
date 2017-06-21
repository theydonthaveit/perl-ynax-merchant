# ynap-merchant

Development Environment Used:
Language: Perl 5.24
Database: MongoDB
Framework: Mojolicious

SETUP for first time:
console: mkdir Mojo-App && cd $_

we can work from inside this directory from here on out.

To manage perl environments, versions, libs, etc. we use Perlbrew.

Install Perlbrew: https://perlbrew.pl/
    follow which ever installation is best suited for your needs

Install Perl 5.24 via Perlbrew
console: perlbrew use 5.24.0

To Install Perl Modules I suggest CPANM, to do so:
console: perlbrew install-cpanm

Setup a perl library for dependencies:
console: perlbrew lib create ynap-merchant
console: perlbrew use 5.24.0@ynap-merchant

console: mojo generate app YNAPMerchant

Install Dependencies from root directory of project:
console: cpanm --installdeps .
OR console: cpanm Module::Name ( if adding module one by one )

Test is live:
console: morbo script/ynapmerchant
to run on different websocket use:
console: morbo script/ynapmerchant -l http://\*:$PORT

Modules chosen are listed in CPANFILE:
Reason for using most of them is due to fimiliarity

I run most tests via Postman

launch API from inside the root directory via console:
morbo script/ynapmerchant

to view all possible routes with a description, please visit the below end point:
GET "/" - will display a welcome message and possible routes

modules used listed in CPANFILE

stricter api which accepts exact params and document
verification and security ( who can access and how )
more testing
elastic search could have been used
