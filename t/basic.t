use Mojo::Base -strict;

use Project::Libs lib_dirs => [qw(lib)];

use Test::More;
use Test::Mojo;
use Mojo::JSON::Pointer;
use Mojo::JSON qw(from_json);
use Data::Dumper;

my $t = Test::Mojo->new('YNAPMerchant');

my $test_clothes =
'{"clothes":[{"category":"Bikinis","name":"iSwim Summer Bikini","outfit":"iSwim"}]}';
my $json_obj = from_json($test_clothes);

$t->get_ok('/')->status_is(200)->content_like(qr/Please use the following calls/i);
$t->get_ok('/api/V1/clothes')->status_is(200)->json_message_has($json_obj);
$t->get_ok('/api/V1/clothes/outfit_range/iwalk')->status_is(200)->content_like(qr/iwalk/i);
$t->get_ok('/api/V1/clothes/match/iSwim Summer Bikini')->status_is(200)->content_like(qr/iSwim Summer Bikini/i);
$t->get_ok('/api/V1/clothes/similar/Trousers')->status_is(200)->content_like(qr/Blue Jeans/i);

done_testing();
