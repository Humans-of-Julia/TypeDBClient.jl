#
# Copyright (C) 2021 Grakn Labs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

#noinspection CucumberUndefinedStep
Feature: Concept Attribute Type

  Background:
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write

  Scenario: Attribute types can be created
    When put attribute type: name, with value type: string
    Then attribute(name) is null: false
    Then attribute(name) get supertype: attribute
    When transaction commits
    When session opens transaction of type: read
    Then attribute(name) is null: false
    Then attribute(name) get supertype: attribute

  Scenario: Attribute types can be created with value class boolean
    When put attribute type: is-open, with value type: boolean
    Then attribute(is-open) get value type: boolean
    When transaction commits
    When session opens transaction of type: read
    Then attribute(is-open) get value type: boolean

  Scenario: Attribute types can be created with value class long
    When put attribute type: age, with value type: long
    Then attribute(age) get value type: long
    When transaction commits
    When session opens transaction of type: read
    Then attribute(age) get value type: long

  Scenario: Attribute types can be created with value class double
    When put attribute type: rating, with value type: double
    Then attribute(rating) get value type: double
    When transaction commits
    When session opens transaction of type: read
    Then attribute(rating) get value type: double

  Scenario: Attribute types can be created with value class string
    When put attribute type: name, with value type: string
    Then attribute(name) get value type: string
    When transaction commits
    When session opens transaction of type: read
    Then attribute(name) get value type: string

  Scenario: Attribute types with value type string and regular expression can be created
    When put attribute type: email, with value type: string
    When attribute(email) as(string) set regex: \S+@\S+\.\S+
    Then attribute(email) as(string) get regex: \S+@\S+\.\S+
    When transaction commits
    When session opens transaction of type: read
    Then attribute(email) as(string) get regex: \S+@\S+\.\S+

  Scenario: Attribute types can be created with value class datetime
    When put attribute type: timestamp, with value type: datetime
    Then attribute(timestamp) get value type: datetime
    When transaction commits
    When session opens transaction of type: read
    Then attribute(timestamp) get value type: datetime

  Scenario: Attribute types can be deleted
    When put attribute type: name, with value type: string
    Then attribute(name) is null: false
    When put attribute type: age, with value type: long
    Then attribute(age) is null: false
    When delete attribute type: age
    Then attribute(age) is null: true
    Then attribute(attribute) get subtypes do not contain:
      | age |
    When transaction commits
    When session opens transaction of type: write
    Then attribute(name) is null: false
    Then attribute(age) is null: true
    Then attribute(attribute) get subtypes do not contain:
      | age |
    When delete attribute type: name
    Then attribute(name) is null: true
    Then attribute(attribute) get subtypes do not contain:
      | name |
      | age  |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(name) is null: true
    Then attribute(age) is null: true
    Then attribute(attribute) get subtypes do not contain:
      | name |
      | age  |

  Scenario: Attribute types that have instances cannot be deleted
    When put attribute type: name, with value type: string
    When transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $x = attribute(name) as(string) put: alice
    When transaction commits
    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    Then delete attribute type: name; throws exception

  Scenario: Attribute types can change labels
    When put attribute type: name, with value type: string
    Then attribute(name) get label: name
    When attribute(name) set label: username
    Then attribute(name) is null: true
    Then attribute(username) is null: false
    Then attribute(username) get label: username
    When transaction commits
    When session opens transaction of type: write
    Then attribute(username) get label: username
    When attribute(username) set label: email
    Then attribute(username) is null: true
    Then attribute(email) is null: false
    Then attribute(email) get label: email
    When transaction commits
    When session opens transaction of type: read
    Then attribute(email) is null: false
    Then attribute(email) get label: email

  Scenario: Attribute types can be set to abstract
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    Then attribute(name) is abstract: true
    When transaction commits
    When session opens transaction of type: write
    Then attribute(name) as(string) put: alice; throws exception
    When session opens transaction of type: write
    When put attribute type: email, with value type: string
    Then attribute(email) is abstract: false
    When transaction commits
    When session opens transaction of type: write
    Then attribute(name) is abstract: true
    Then attribute(name) as(string) put: alice; throws exception
    When session opens transaction of type: write
    Then attribute(email) is abstract: false
    When attribute(email) set abstract: true
    Then attribute(email) is abstract: true
    When transaction commits
    When session opens transaction of type: write
    Then attribute(email) as(string) put: alice@email.com; throws exception
    When session opens transaction of type: write
    Then attribute(email) is abstract: true
    Then attribute(email) as(string) put: alice@email.com; throws exception

  Scenario: Attribute types can be subtypes of other attribute types
    When put attribute type: first-name, with value type: string
    When put attribute type: last-name, with value type: string
    When put attribute type: real-name, with value type: string
    When put attribute type: username, with value type: string
    When put attribute type: name, with value type: string
    When attribute(real-name) set abstract: true
    When attribute(name) set abstract: true
    When attribute(first-name) set supertype: real-name
    When attribute(last-name) set supertype: real-name
    When attribute(real-name) set supertype: name
    When attribute(username) set supertype: name
    Then attribute(first-name) get supertype: real-name
    Then attribute(last-name) get supertype: real-name
    Then attribute(real-name) get supertype: name
    Then attribute(username) get supertype: name
    Then attribute(first-name) get supertypes contain:
      | thing      |
      | attribute  |
      | first-name |
      | real-name  |
      | name       |
    Then attribute(last-name) get supertypes contain:
      | thing     |
      | attribute |
      | last-name |
      | real-name |
      | name      |
    Then attribute(real-name) get supertypes contain:
      | thing     |
      | attribute |
      | real-name |
      | name      |
    Then attribute(username) get supertypes contain:
      | thing     |
      | attribute |
      | username  |
      | name      |
    Then attribute(first-name) get subtypes contain:
      | first-name |
    Then attribute(last-name) get subtypes contain:
      | last-name |
    Then attribute(real-name) get subtypes contain:
      | real-name  |
      | first-name |
      | last-name  |
    Then attribute(username) get subtypes contain:
      | username |
    Then attribute(name) get subtypes contain:
      | name       |
      | username   |
      | real-name  |
      | first-name |
      | last-name  |
    Then attribute(attribute) get subtypes contain:
      | attribute  |
      | name       |
      | username   |
      | real-name  |
      | first-name |
      | last-name  |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(first-name) get supertype: real-name
    Then attribute(last-name) get supertype: real-name
    Then attribute(real-name) get supertype: name
    Then attribute(username) get supertype: name
    Then attribute(first-name) get supertypes contain:
      | thing      |
      | attribute  |
      | first-name |
      | real-name  |
      | name       |
    Then attribute(last-name) get supertypes contain:
      | thing     |
      | attribute |
      | last-name |
      | real-name |
      | name      |
    Then attribute(real-name) get supertypes contain:
      | thing     |
      | attribute |
      | real-name |
      | name      |
    Then attribute(username) get supertypes contain:
      | thing     |
      | attribute |
      | username  |
      | name      |
    Then attribute(first-name) get subtypes contain:
      | first-name |
    Then attribute(last-name) get subtypes contain:
      | last-name |
    Then attribute(real-name) get subtypes contain:
      | real-name  |
      | first-name |
      | last-name  |
    Then attribute(username) get subtypes contain:
      | username |
    Then attribute(name) get subtypes contain:
      | name       |
      | username   |
      | real-name  |
      | first-name |
      | last-name  |
    Then attribute(attribute) get subtypes contain:
      | attribute  |
      | name       |
      | username   |
      | real-name  |
      | first-name |
      | last-name  |

  Scenario: Attribute types cannot subtype itself
    When put attribute type: is-open, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: timestamp, with value type: datetime
    When transaction commits
    When session opens transaction of type: write
    Then attribute(is-open) set supertype: is-open; throws exception
    When session opens transaction of type: write
    Then attribute(age) set supertype: age; throws exception
    When session opens transaction of type: write
    Then attribute(rating) set supertype: rating; throws exception
    When session opens transaction of type: write
    Then attribute(name) set supertype: name; throws exception
    When session opens transaction of type: write
    Then attribute(timestamp) set supertype: timestamp; throws exception

  Scenario: Attribute types cannot subtype non abstract attribute types
    When put attribute type: name, with value type: string
    When put attribute type: first-name, with value type: string
    When put attribute type: last-name, with value type: string
    When transaction commits
    When session opens transaction of type: write
    Then attribute(first-name) set supertype: name; throws exception
    When session opens transaction of type: write
    Then attribute(last-name) set supertype: name; throws exception

  Scenario: Attribute types cannot subtype another attribute type of different value class
    When put attribute type: is-open, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: timestamp, with value type: datetime
    When transaction commits
    When session opens transaction of type: write
    Then attribute(is-open) set supertype: age; throws exception
    When session opens transaction of type: write
    Then attribute(is-open) set supertype: rating; throws exception
    When session opens transaction of type: write
    Then attribute(is-open) set supertype: name; throws exception
    When session opens transaction of type: write
    Then attribute(is-open) set supertype: timestamp; throws exception
    When session opens transaction of type: write
    Then attribute(age) set supertype: is-open; throws exception
    When session opens transaction of type: write
    Then attribute(age) set supertype: rating; throws exception
    When session opens transaction of type: write
    Then attribute(age) set supertype: name; throws exception
    When session opens transaction of type: write
    Then attribute(age) set supertype: timestamp; throws exception
    When session opens transaction of type: write
    Then attribute(rating) set supertype: is-open; throws exception
    When session opens transaction of type: write
    Then attribute(rating) set supertype: age; throws exception
    When session opens transaction of type: write
    Then attribute(rating) set supertype: name; throws exception
    When session opens transaction of type: write
    Then attribute(rating) set supertype: timestamp; throws exception
    When session opens transaction of type: write
    Then attribute(name) set supertype: is-open; throws exception
    When session opens transaction of type: write
    Then attribute(name) set supertype: age; throws exception
    When session opens transaction of type: write
    Then attribute(name) set supertype: rating; throws exception
    When session opens transaction of type: write
    Then attribute(name) set supertype: timestamp; throws exception
    When session opens transaction of type: write
    Then attribute(timestamp) set supertype: is-open; throws exception
    When session opens transaction of type: write
    Then attribute(timestamp) set supertype: age; throws exception
    When session opens transaction of type: write
    Then attribute(timestamp) set supertype: rating; throws exception
    When session opens transaction of type: write
    Then attribute(timestamp) set supertype: name; throws exception

  Scenario: Attribute types can get the root type
    When put attribute type: is-open, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: timestamp, with value type: datetime
    Then attribute(is-open) get supertype: attribute
    Then attribute(age) get supertype: attribute
    Then attribute(rating) get supertype: attribute
    Then attribute(name) get supertype: attribute
    Then attribute(timestamp) get supertype: attribute
    When transaction commits
    When session opens transaction of type: read
    Then attribute(is-open) get supertype: attribute
    Then attribute(age) get supertype: attribute
    Then attribute(rating) get supertype: attribute
    Then attribute(name) get supertype: attribute
    Then attribute(timestamp) get supertype: attribute

  Scenario: Attribute type root can get attribute types of a specific value class
    When put attribute type: is-open, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: timestamp, with value type: datetime
    Then attribute(attribute) as(boolean) get subtypes contain:
      | attribute |
      | is-open   |
    Then attribute(attribute) as(boolean) get subtypes do not contain:
      | age       |
      | rating    |
      | name      |
      | timestamp |
    Then attribute(attribute) as(long) get subtypes contain:
      | attribute |
      | age       |
    Then attribute(attribute) as(long) get subtypes do not contain:
      | is-open   |
      | rating    |
      | name      |
      | timestamp |
    Then attribute(attribute) as(double) get subtypes contain:
      | attribute |
      | rating    |
    Then attribute(attribute) as(double) get subtypes do not contain:
      | is-open   |
      | age       |
      | name      |
      | timestamp |
    Then attribute(attribute) as(string) get subtypes contain:
      | attribute |
      | name      |
    Then attribute(attribute) as(string) get subtypes do not contain:
      | is-open   |
      | age       |
      | rating    |
      | timestamp |
    Then attribute(attribute) as(datetime) get subtypes contain:
      | attribute |
      | timestamp |
    Then attribute(attribute) as(datetime) get subtypes do not contain:
      | is-open |
      | age     |
      | rating  |
      | name    |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(attribute) as(boolean) get subtypes contain:
      | attribute |
      | is-open   |
    Then attribute(attribute) as(boolean) get subtypes do not contain:
      | age       |
      | rating    |
      | name      |
      | timestamp |
    Then attribute(attribute) as(long) get subtypes contain:
      | attribute |
      | age       |
    Then attribute(attribute) as(long) get subtypes do not contain:
      | is-open   |
      | rating    |
      | name      |
      | timestamp |
    Then attribute(attribute) as(double) get subtypes contain:
      | attribute |
      | rating    |
    Then attribute(attribute) as(double) get subtypes do not contain:
      | is-open   |
      | age       |
      | name      |
      | timestamp |
    Then attribute(attribute) as(string) get subtypes contain:
      | attribute |
      | name      |
    Then attribute(attribute) as(string) get subtypes do not contain:
      | is-open   |
      | age       |
      | rating    |
      | timestamp |
    Then attribute(attribute) as(datetime) get subtypes contain:
      | attribute |
      | timestamp |
    Then attribute(attribute) as(datetime) get subtypes do not contain:
      | is-open |
      | age     |
      | rating  |
      | name    |

  Scenario: Attribute type root can get attribute types of any value class
    When put attribute type: is-open, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: timestamp, with value type: datetime
    Then attribute(attribute) get subtypes contain:
      | attribute |
      | is-open   |
      | age       |
      | rating    |
      | name      |
      | timestamp |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(attribute) get subtypes contain:
      | attribute |
      | is-open   |
      | age       |
      | rating    |
      | name      |
      | timestamp |

  Scenario: Attribute types can have keys
    When put attribute type: country-code, with value type: string
    When put attribute type: country-name, with value type: string
    When attribute(country-name) set owns key type: country-code
    Then attribute(country-name) get owns key types contain:
      | country-code |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(country-name) get owns key types contain:
      | country-code |

  Scenario: Attribute types can unset keys
    When put attribute type: country-code-1, with value type: string
    When put attribute type: country-code-2, with value type: string
    When put attribute type: country-name, with value type: string
    When attribute(country-name) set owns key type: country-code-1
    When attribute(country-name) set owns key type: country-code-2
    When attribute(country-name) unset owns key type: country-code-1
    Then attribute(country-name) get owns key types do not contain:
      | country-code-1 |
    When transaction commits
    When session opens transaction of type: write
    When attribute(country-name) unset owns key type: country-code-2
    Then attribute(country-name) get owns key types do not contain:
      | country-code-1 |
      | country-code-2 |

  Scenario: Attribute types can have attributes
    When put attribute type: utc-zone-code, with value type: string
    When put attribute type: utc-zone-hour, with value type: double
    When put attribute type: timestamp, with value type: datetime
    When attribute(timestamp) set owns attribute type: utc-zone-code
    When attribute(timestamp) set owns attribute type: utc-zone-hour
    Then attribute(timestamp) get owns attribute types contain:
      | utc-zone-code |
      | utc-zone-hour |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(timestamp) get owns attribute types contain:
      | utc-zone-code |
      | utc-zone-hour |

  Scenario: Attribute types can unset attributes
    When put attribute type: utc-zone-code, with value type: string
    When put attribute type: utc-zone-hour, with value type: double
    When put attribute type: timestamp, with value type: datetime
    When attribute(timestamp) set owns attribute type: utc-zone-code
    When attribute(timestamp) set owns attribute type: utc-zone-hour
    When attribute(timestamp) unset owns attribute type: utc-zone-hour
    Then attribute(timestamp) get owns attribute types do not contain:
      | utc-zone-hour |
    When transaction commits
    When session opens transaction of type: write
    When attribute(timestamp) unset owns attribute type: utc-zone-code
    Then attribute(timestamp) get owns attribute types do not contain:
      | utc-zone-code |
      | utc-zone-hour |

  Scenario: Attribute types can have keys and attributes
    When put attribute type: country-code, with value type: string
    When put attribute type: country-abbreviation, with value type: string
    When put attribute type: country-name, with value type: string
    When attribute(country-name) set owns key type: country-code
    When attribute(country-name) set owns attribute type: country-abbreviation
    Then attribute(country-name) get owns key types contain:
      | country-code |
    Then attribute(country-name) get owns attribute types contain:
      | country-code         |
      | country-abbreviation |
    When transaction commits
    When session opens transaction of type: read
    Then attribute(country-name) get owns key types contain:
      | country-code |
    Then attribute(country-name) get owns attribute types contain:
      | country-code         |
      | country-abbreviation |

  Scenario: Attribute types can inherit keys and attributes
    When put attribute type: hash, with value type: string
    When put attribute type: abbreviation, with value type: string
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When attribute(name) set owns key type: hash
    When attribute(name) set owns attribute type: abbreviation
    When put attribute type: real-name, with value type: string
    When attribute(real-name) set abstract: true
    When attribute(real-name) set supertype: name
    Then attribute(real-name) get owns key types contain:
      | hash |
    Then attribute(real-name) get owns attribute types contain:
      | hash         |
      | abbreviation |
    When transaction commits
    When session opens transaction of type: write
    Then attribute(real-name) get owns key types contain:
      | hash |
    Then attribute(real-name) get owns attribute types contain:
      | hash         |
      | abbreviation |
    When put attribute type: last-name, with value type: string
    When attribute(last-name) set supertype: real-name
    When transaction commits
    When session opens transaction of type: read
    Then attribute(real-name) get owns key types contain:
      | hash |
    Then attribute(real-name) get owns attribute types contain:
      | hash         |
      | abbreviation |
    Then attribute(last-name) get owns key types contain:
      | hash |
    Then attribute(last-name) get owns attribute types contain:
      | hash         |
      | abbreviation |

  Scenario: Attribute types can be owned as attributes
    When put attribute type: age, with value type: long
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: boy-name, with value type: string
    When attribute(boy-name) set supertype: name
    When put attribute type: girl-name, with value type: string
    When attribute(girl-name) set supertype: name
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: age
    When put entity type: boy
    When entity(boy) set supertype: person
    When entity(boy) set owns attribute type: boy-name as name
    When put entity type: girl
    When entity(girl) set supertype: person
    When entity(girl) set owns attribute type: girl-name as name
    Then attribute(age) get attribute owners contain:
      | person |
      | boy    |
      | girl   |
    Then attribute(name) get attribute owners contain:
      | person |
    Then attribute(name) get attribute owners do not contain:
      | boy    |
      | girl   |
    Then transaction commits
    When session opens transaction of type: write
    Then attribute(age) get attribute owners contain:
      | person |
      | boy    |
      | girl   |
    Then attribute(name) get attribute owners contain:
      | person |
    Then attribute(name) get attribute owners do not contain:
      | boy    |
      | girl   |

  Scenario: Attribute types can be owned as keys
    When put attribute type: email, with value type: string
    When put entity type: company
    When entity(company) set owns attribute type: email
    When put entity type: person
    When entity(person) set owns key type: email
    Then attribute(email) get attribute owners contain:
      | company |
      | person  |
    Then attribute(email) get key owners contain:
      | person |
    Then attribute(email) get key owners do not contain:
      | company |
    Then transaction commits
    When session opens transaction of type: write
    Then attribute(email) get attribute owners contain:
      | company |
      | person  |
    Then attribute(email) get key owners contain:
      | person |
    Then attribute(email) get key owners do not contain:
      | company |

  Scenario: Attribute types with value type string can unset their regular expression
    When put attribute type: email, with value type: string
    When attribute(email) as(string) set regex: \S+@\S+\.\S+
    Then attribute(email) as(string) get regex: \S+@\S+\.\S+
    When transaction commits
    When session opens transaction of type: write
    Then attribute(email) as(string) unset regex
    Then attribute(email) as(string) does not have any regex
    Then transaction commits
    When session opens transaction of type: read
    Then attribute(email) as(string) does not have any regex
