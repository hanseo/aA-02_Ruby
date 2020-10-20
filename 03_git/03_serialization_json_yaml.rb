=begin
-----SERIALIZATION & PERSISTENCE----
Serialization: process of converting a ruby onject into a representation
that can be saved to disk or sent over a network.
There are many ways of representing data, but the most important one is JSON.

Data supported by JSON: numbers, strings, arrays and hashes.
It's a descendant of JavaScript, and is commony used as the message format
for web APIs.

HOW TO

> require 'json'
> { "a" => "always",
    "b" => "be",
    "c" => "closing" }.to_json
=> '{"a":"always","b":"be","c":"closing"}'   <- string
> JSON.parse('{"a":"always","b":"be","c":"closing"}')
=> {"a"=>"always", "b"=>"be", "c"=>"closing"}  <- hash


HOWEVER
JSON doesn't know how to serialize more complicated classes

> Cat.new("Breakfast", 8, "San Francisco").to_json
=> '"#<Cat:0x007fb87c81b398>"'
=end

=begin
------YAML------
YAML solves the problem of saving custom classes

> require 'yaml'
> c = Cat.new("Breakfast", 8, "San Francisco")
=> #<Cat:0x007ff434926690 @age=8, @city="San Francisco", @name="Breakfast">
> puts c.to_yaml
--- !ruby/object:Cat
name: Breakfast
age: 8
city: San Francisco
=> nil
> serialized_cat = c.to_yaml
=> "--- !ruby/object:Cat\nname: Breakfast\nage: 8\ncity: San Francisco\n"
> puts serialized_cat
--- !ruby/object:Cat
name: Breakfast
age: 8
city: San Francisco
=> nil
> c2 = YAML::load(serialized_cat)
=> #<Cat:0x007ff4348098e8 @age=8, @city="San Francisco", @name="Breakfast">

=end