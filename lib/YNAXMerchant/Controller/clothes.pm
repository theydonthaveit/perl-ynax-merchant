package YNAXMerchant::Controller::Clothes;
use Mojo::Base 'Mojolicious::Controller';

use db::Select;
use utils::Cleanse;

sub welcome
{
  my $self = shift;

  my $welcome_msg =
    'Hi, and welcome to the YNAP Merchant API'."\n\n"
    . 'Please use the following calls:'."\n"
    . 'TO LIST ALL ITEMS: /api/V1/clothes'."\n"
    . 'TO RETRIEVE A RANGE MATCH: /api/V1/clothes/outfit_range/{range_name}'."\n"
    . 'TO RETRIEVE AN EXACT MATCH: /api/V1/clothes/match/{item_name}'."\n"
    . 'TO RETRIEVE SIMILAR ITEMS: /api/V1/clothes/similar/(*+)'."\n"
    . 'Accepts atring e.g. "iRun Black Trainers" or "Black" etc.';

  $self->render( data => $welcome_msg );
}

sub retrieve_all_items
{
    my $self = shift;

    $self->res->headers->cache_control('no-cache');
    $self->res->headers->access_control_allow_origin('*');

    my $dbh = Select->new();
    my $client = $dbh->init_client;

    my $result = $dbh->retrieve_all_items;

    my $items;
    @{$items} =
        map {
            +{
                name => $_->{name},
                category => $_->{category},
                outfit => $_->{tag}
            }
        } $result->result->all;

    $self->render(
        json => {
            clothes => $items });
}

sub range_match
{
    my $self = shift;
    my $range_name = $self->stash('range_name');

    $self->res->headers->cache_control('no-cache');
    $self->res->headers->access_control_allow_origin('*');

    my $dbh =
        Select->new(
            filter => {
                tag => qr/$range_name/i
            }
        );
    my $client = $dbh->init_client;
    my $result = $dbh->retrieve_oufit_range;

    my $items;
    @{$items} =
        map {
            +{
                name => $_->{name},
                category => $_->{category},
                outfit => $_->{tag}
            }
        } $result->result->all;

    $self->render(
        json => {
            clothes => $items });
}

sub exact_match
{
    my $self = shift;
    my $item_name = Cleanse->new( string => $self->stash('item_name'));
    my $clean_name = $item_name->understand_string;

    $self->res->headers->cache_control('no-cache');
    $self->res->headers->access_control_allow_origin('*');

    my $dbh =
    Select->new(
        filter => {
            '$or' => [
                { category => qr/$item_name/i },
                { name => qr/$clean_name/i }
            ]
        }
    );
    my $client = $dbh->init_client;
    my $result = $dbh->retrieve_item;

    my $items;
    @{$items} =
        map {
            +{
                name => $_->{name},
                category => $_->{category},
                outfit => $_->{tag}
            }
        } $result->result->all;

    $self->render(
        json => {
            clothes => $items });
}

sub similar_match
{
    my $self = shift;
    my $subject = $self->stash('\w+');

    $self->res->headers->cache_control('no-cache');
    $self->res->headers->access_control_allow_origin('*');

    my $dbh =
        Select->new( filter => $subject );
    my $client = $dbh->init_client;
    my $result = $dbh->retrieve_similar;

    my $items;
    @{$items} =
        map {
            $_
        } @{$result};

    $self->render(
        json => {
            clothes => $items });
}

1;
