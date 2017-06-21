package YNAPMerchant;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('clothes#welcome');
  $r->get('/api/V1/clothes')->to('clothes#retrieve_all_items');
  $r->get('/api/V1/clothes/outfit_range/:range_name')->to('clothes#range_match');
  $r->get('/api/V1/clothes/match/:item_name')->to('clothes#exact_match');
  $r->get('/api/V1/clothes/similar/(\w+)')->to('clothes#similar_match');
}

1;
