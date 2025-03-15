package Core::Bank;

use v5.14;
use parent 'Core::Base';

sub table { return 'banks' };

sub structure {
    return {
        bank_id => {
            type => 'key',
        },
        bank_name_base => {
            type => 'text',
        },
        bank_city => {
            type => 'text',
        },
        bic_base => {
            type => 'text',
        },
        correspondent_account_base => {
            type => 'text',
        },
    }
}

1;

