package Core::Profile;

use v5.14;
use parent 'Core::Base';

sub table { return 'profiles' };

sub structure {
    return {
        id => {
            type => 'key',
        },
        user_id => {
            type => 'number',
            auto_fill => 1,
        },
        passport => {
            type => 'text',
        },
        address_actual => {
            type => 'text',
        },
        phone => {
            type => 'text',
        },
        email => {
            type => 'text',
        },
        contract_number => {
            type => 'text',
        },
        address_registration => {
            type => 'text',
        },
        inn => {
            type => 'text',
        },
        kpp => {
            type => 'text',
        },
        ogrn => {
            type => 'text',
        },
        actual_address => {
            type => 'text',
        },
        legal_address => {
            type => 'text',
        },
        mail_address => {
            type => 'text',
        },
        contact_phone => {
            type => 'text',
        },
        email_invoice => {
            type => 'text',
        },
        director_name => {
            type => 'text',
        },
        chief_accountant => {
            type => 'text',
        },
        bank_account => {
            type => 'text',
        },
        bank_id => {
            type => 'text',
        },
        data => {
            type => 'json',
            value => {},
        },
        created => {
            type => 'now',
        },
    }
}

1;

