# Scripted API Atom : Reset Code Maker

The **Reset Code Maker** Scripted Api Atom, generates reset codes for users and stores them into a redis instance.

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SA_REDIS_HOST`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : Redis host name.
* `SA_REDIS_PORT`
    * _Required_ : **False**
    * _Type_ : **Integer**
    * _Default_ : `6379`
    * _Description_ : Redis port.
* `SA_REDIS_PASSWORD`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : Redis password.
* `SA_REDIS_DB`
    * _Required_ : **False**
    * _Type_ : **Integer**
    * _Default_ : `0`
    * _Description_ : Redis database.
* `SA_REDIS_KEY_PREFIX`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `"atom"`
    * _Description_ : The prefix of redis keys.
* `SA_RESET_CODE_TTL`
    * _Required_ : **False**
    * _Type_ : **Integer**
    * _Default_ : `900`
    * _Description_ : Max liveliness of a reset code in seconds.
* `SA_RESET_CODE_FORMAT`
    * _Required_ : **False**
    * _Type_ : **Enumeration**
    * _Possible values_ : **Enumeration**
        * **_aplabetic_** : Only lowercase letters
        * **_alphanumeric_**  : Lowercase letters and numbers
        * **_aplabetic-cased_**  : Lowercase and Uppercase letters
        * **_alphanumeric-cased_** : Lowercase, uppercase, and numbers
        * **_numeric_** : Only numbers
    * _Default_ : `"aplpha-numeric-cased"`
    * _Description_ : The content type of the reset codes
* `SA_RESET_CODE_LENGTH`
    * _Required_ : **False**
    * _Type_ : **Integer**
    * _Default_ : `6`
    * _Description_ : The length of the reset code
* `SA_RESET_CODE_SPLIT`
    * _Required_ : **False**
    * _Type_ : **Boolean**
    * _Default_ : `true`
    * _Description_ : Whether to split the reset code into parts.
* `SA_RESET_CODE_SPLIT_EVERY`
    * _Required_ : **False**
    * _Type_ : **Integer**
    * _Default_ : `3`
    * _Description_ : Splits the reset code into parts
* `SA_RESET_CODE_SPLITTER`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `"-"`
    * _Description_ : What character to use for splitting the reset code
