# Hash Modifier

When given a hash, the modifier can make a decision to alter that hash based on the hash contents.

## How does it work

A modifier can be used to add/update/delete settings based on other settings.
e.g. Model Plural will take any model key and ensure that there is a model_plural key pair with it.

Modifiers can be a one-off class like the previously mentioned class

Modifiers can be lambda expression for specific use cases

Modifiers can pre-configured key pairs attached to Lambda or Class to be easily called, e.g. :uppercase, :lowercase

## Where can they be used

A modify can be used on the settings hash to alter that hash.

A modifier can be used on the table/rows structure to alter any rows.

`Need better understanding off the implementation pattern`
