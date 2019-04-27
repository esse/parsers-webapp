
Since there are many sources, and even more to come - I've decided to build a kind-of universal parser, with steps defined using YAML (which may or may not be overengineering - I'm perfectly aware of that. However, the whole point of this tasks is to show the best side of your code).

Every source is defined in yaml in sources/ catalog. Possible steps are:
* xpath/1 - extract text using xpath provided as argument
* inner_html/0 - get inner_html of node
* constant/0 - write constant to output
* first_match_group_from_regexp/1 - get first match group from provided regexp
* attr/1 - call attr method with provided argument on Nokogiri::XML::Nodeset
* parse_as_date/0 - call Date.parse on argumet
* or/1 - accepts two (or more) pipelines as arguments. Takes first one which will be not nil and not blank.
* uniq/0 - calls uniq
* extract_href/0 - extract href from every element of an provided array
* compact/0 - remove blank results
* concat/1 - concatenate results of two (or more) pipelines provided as arguments
* prepend_string/1 - prepend string to every value in array
* prepend_single_string/1 - prepend string to single provided string
* puts/0 - prints argument on screen
* first/0 - calls first on argument

Since it's a prototype some places are left unfinished:

* validations is missing in many places
* input fields in web app are not prefilled with value from params
* there are some specs pending, some others are missing
* YAML operands should have one more attribute: `allowed_types` which would define types allowed as a arguments (kind-of static typing)
* there are some places with TODO notes, to fix after prototype phase
