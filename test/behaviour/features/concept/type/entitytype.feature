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
Feature: Concept Entity Type

  Background:
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write

  Scenario: Entity types can be created
    When put entity type: person
    Then entity(person) is null: false
    Then entity(person) get supertype: entity
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) is null: false
    Then entity(person) get supertype: entity

  Scenario: Entity types can be deleted
    When put entity type: person
    Then entity(person) is null: false
    When put entity type: company
    Then entity(company) is null: false
    When delete entity type: company
    Then entity(company) is null: true
    Then entity(entity) get subtypes do not contain:
      | company |
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) is null: false
    Then entity(company) is null: true
    Then entity(entity) get subtypes do not contain:
      | company |
    When delete entity type: person
    Then entity(person) is null: true
    Then entity(entity) get subtypes do not contain:
      | person  |
      | company |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) is null: true
    Then entity(company) is null: true
    Then entity(entity) get subtypes do not contain:
      | person  |
      | company |

  Scenario: Entity types that have instances cannot be deleted
    When put entity type: person
    When transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $x = entity(person) create new instance
    When transaction commits
    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    Then delete entity type: person; throws exception

  Scenario: Entity types can change labels
    When put entity type: person
    Then entity(person) get label: person
    When entity(person) set label: horse
    Then entity(person) is null: true
    Then entity(horse) is null: false
    Then entity(horse) get label: horse
    When transaction commits
    When session opens transaction of type: write
    Then entity(horse) get label: horse
    When entity(horse) set label: animal
    Then entity(horse) is null: true
    Then entity(animal) is null: false
    Then entity(animal) get label: animal
    When transaction commits
    When session opens transaction of type: read
    Then entity(animal) is null: false
    Then entity(animal) get label: animal

  Scenario: Entity types can be set to abstract
    When put entity type: person
    When entity(person) set abstract: true
    When put entity type: company
    Then entity(person) is abstract: true
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) create new instance; throws exception
    When session opens transaction of type: write
    Then entity(company) is abstract: false
    Then entity(person) is abstract: true
    Then entity(person) create new instance; throws exception
    When session opens transaction of type: write
    Then entity(company) is abstract: false
    When entity(company) set abstract: true
    Then entity(company) is abstract: true
    When transaction commits
    When session opens transaction of type: write
    Then entity(company) create new instance; throws exception
    When session opens transaction of type: write
    Then entity(company) is abstract: true
    Then entity(company) create new instance; throws exception

  Scenario: Entity types can be subtypes of other entity types
    When put entity type: man
    When put entity type: woman
    When put entity type: person
    When put entity type: cat
    When put entity type: animal
    When entity(man) set supertype: person
    When entity(woman) set supertype: person
    When entity(person) set supertype: animal
    When entity(cat) set supertype: animal
    Then entity(man) get supertype: person
    Then entity(woman) get supertype: person
    Then entity(person) get supertype: animal
    Then entity(cat) get supertype: animal
    Then entity(man) get supertypes contain:
      | thing  |
      | entity |
      | man    |
      | person |
      | animal |
    Then entity(woman) get supertypes contain:
      | thing  |
      | entity |
      | woman  |
      | person |
      | animal |
    Then entity(person) get supertypes contain:
      | thing  |
      | entity |
      | person |
      | animal |
    Then entity(cat) get supertypes contain:
      | thing  |
      | entity |
      | cat    |
      | animal |
    Then entity(man) get subtypes contain:
      | man |
    Then entity(woman) get subtypes contain:
      | woman |
    Then entity(person) get subtypes contain:
      | person |
      | man    |
      | woman  |
    Then entity(cat) get subtypes contain:
      | cat |
    Then entity(animal) get subtypes contain:
      | animal |
      | cat    |
      | person |
      | man    |
      | woman  |
    Then entity(entity) get subtypes contain:
      | entity |
      | animal |
      | cat    |
      | person |
      | man    |
      | woman  |
    When transaction commits
    When session opens transaction of type: read
    Then entity(man) get supertype: person
    Then entity(woman) get supertype: person
    Then entity(person) get supertype: animal
    Then entity(cat) get supertype: animal
    Then entity(man) get supertypes contain:
      | thing  |
      | entity |
      | man    |
      | person |
      | animal |
    Then entity(woman) get supertypes contain:
      | thing  |
      | entity |
      | woman  |
      | person |
      | animal |
    Then entity(person) get supertypes contain:
      | thing  |
      | entity |
      | person |
      | animal |
    Then entity(cat) get supertypes contain:
      | thing  |
      | entity |
      | cat    |
      | animal |
    Then entity(man) get subtypes contain:
      | man |
    Then entity(woman) get subtypes contain:
      | woman |
    Then entity(person) get subtypes contain:
      | person |
      | man    |
      | woman  |
    Then entity(cat) get subtypes contain:
      | cat |
    Then entity(animal) get subtypes contain:
      | animal |
      | cat    |
      | person |
      | man    |
      | woman  |
    Then entity(entity) get subtypes contain:
      | entity |
      | animal |
      | cat    |
      | person |
      | man    |
      | woman  |

  Scenario: Entity types cannot subtype itself
    When put entity type: person
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set supertype: person; throws exception
    When session opens transaction of type: write
    Then entity(person) set supertype: person; throws exception

  Scenario: Entity types can have keys
    When put attribute type: email, with value type: string
    When put attribute type: username, with value type: string
    When put entity type: person
    When entity(person) set owns key type: email
    When entity(person) set owns key type: username
    Then entity(person) get owns key types contain:
      | email    |
      | username |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get owns key types contain:
      | email    |
      | username |

  Scenario: Entity types can only commit keys if every instance owns a distinct key
    When put attribute type: email, with value type: string
    When put attribute type: username, with value type: string
    When put entity type: person
    When entity(person) set owns key type: username
    Then transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $a = entity(person) create new instance with key(username): alice
    When $b = entity(person) create new instance with key(username): bob
    Then transaction commits
    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    When entity(person) set owns key type: email; throws exception
    When session opens transaction of type: write
    When entity(person) set owns attribute type: email
    Then transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $a = entity(person) get instance with key(username): alice
    When $alice = attribute(email) as(string) put: alice@grakn.ai
    When entity $a set has: $alice
    When $b = entity(person) get instance with key(username): bob
    When $bob = attribute(email) as(string) put: bob@grakn.ai
    When entity $b set has: $bob
    Then transaction commits
    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    When entity(person) set owns key type: email
    Then entity(person) get owns key types contain:
      | email    |
      | username |
    Then transaction commits
    When session opens transaction of type: read
    Then entity(person) get owns key types contain:
      | email    |
      | username |

  Scenario: Entity types can unset keys
    When put attribute type: email, with value type: string
    When put attribute type: username, with value type: string
    When put entity type: person
    When entity(person) set owns key type: email
    When entity(person) set owns key type: username
    When entity(person) unset owns key type: email
    Then entity(person) get owns key types do not contain:
      | email |
    When transaction commits
    When session opens transaction of type: write
    When entity(person) unset owns key type: username
    Then entity(person) get owns key types do not contain:
      | email    |
      | username |

  Scenario: Entity types cannot have keys of attributes that are not keyable
    When put attribute type: is-open, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: timestamp, with value type: datetime
    When put entity type: person
    When entity(person) set owns key type: age
    When entity(person) set owns key type: name
    When entity(person) set owns key type: timestamp
    When entity(person) set owns key type: timestamp
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set owns key type: is-open; throws exception
    When session opens transaction of type: write
    Then entity(person) set owns key type: rating; throws exception

  Scenario: Entity types can have attributes
    When put attribute type: name, with value type: string
    When put attribute type: age, with value type: long
    When put entity type: person
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: age
    Then entity(person) get owns attribute types contain:
      | name |
      | age  |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get owns attribute types contain:
      | name |
      | age  |

  Scenario: Entity types can unset owning attributes
    When put attribute type: name, with value type: string
    When put attribute type: age, with value type: long
    When put entity type: person
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: age
    When entity(person) unset owns attribute type: age
    Then entity(person) get owns attribute types do not contain:
      | age |
    When transaction commits
    When session opens transaction of type: write
    When entity(person) unset owns attribute type: name
    Then entity(person) get owns attribute types do not contain:
      | name |
      | age  |

  Scenario: Entity types cannot unset owning attributes that are owned by existing instances
    When put attribute type: name, with value type: string
    When put entity type: person
    When entity(person) set owns attribute type: name
    Then transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $a = entity(person) create new instance
    When $alice = attribute(name) as(string) put: alice
    When entity $a set has: $alice
    Then transaction commits
    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    Then entity(person) unset owns attribute type: name; throws exception

  Scenario: Entity types can have keys and attributes
    When put attribute type: email, with value type: string
    When put attribute type: username, with value type: string
    When put attribute type: name, with value type: string
    When put attribute type: age, with value type: long
    When put entity type: person
    When entity(person) set owns key type: email
    When entity(person) set owns key type: username
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: age
    Then entity(person) get owns key types contain:
      | email    |
      | username |
    Then entity(person) get owns attribute types contain:
      | email    |
      | username |
      | name     |
      | age      |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get owns key types contain:
      | email    |
      | username |
    Then entity(person) get owns attribute types contain:
      | email    |
      | username |
      | name     |
      | age      |

  Scenario: Entity types can inherit keys and attributes
    When put attribute type: email, with value type: string
    When put attribute type: name, with value type: string
    When put attribute type: reference, with value type: string
    When put attribute type: rating, with value type: double
    When put entity type: person
    When entity(person) set owns key type: email
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: reference
    When entity(customer) set owns attribute type: rating
    Then entity(customer) get owns key types contain:
      | email     |
      | reference |
    Then entity(customer) get owns attribute types contain:
      | email     |
      | reference |
      | name      |
      | rating    |
    When transaction commits
    When session opens transaction of type: write
    Then entity(customer) get owns key types contain:
      | email     |
      | reference |
    Then entity(customer) get owns attribute types contain:
      | email     |
      | reference |
      | name      |
      | rating    |
    When put attribute type: license, with value type: string
    When put attribute type: points, with value type: double
    When put entity type: subscriber
    When entity(subscriber) set supertype: customer
    When entity(subscriber) set owns key type: license
    When entity(subscriber) set owns attribute type: points
    When transaction commits
    When session opens transaction of type: read
    Then entity(customer) get owns key types contain:
      | email     |
      | reference |
    Then entity(customer) get owns attribute types contain:
      | email     |
      | reference |
      | name      |
      | rating    |
    Then entity(subscriber) get owns key types contain:
      | email     |
      | reference |
      | license   |
    Then entity(subscriber) get owns attribute types contain:
      | email     |
      | reference |
      | license   |
      | name      |
      | rating    |
      | points    |

  Scenario: Entity types can inherit keys and attributes that are subtypes of each other
    When put attribute type: username, with value type: string
    When attribute(username) set abstract: true
    When put attribute type: score, with value type: double
    When attribute(score) set abstract: true
    When put attribute type: reference, with value type: string
    When attribute(reference) set abstract: true
    When attribute(reference) set supertype: username
    When put attribute type: rating, with value type: double
    When attribute(rating) set abstract: true
    When attribute(rating) set supertype: score
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: username
    When entity(person) set owns attribute type: score
    When put entity type: customer
    When entity(customer) set abstract: true
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: reference
    When entity(customer) set owns attribute type: rating
    Then entity(customer) get owns key types contain:
      | username  |
      | reference |
    Then entity(customer) get owns attribute types contain:
      | username  |
      | reference |
      | score     |
      | rating    |
    When transaction commits
    When session opens transaction of type: write
    Then entity(customer) get owns key types contain:
      | username  |
      | reference |
    Then entity(customer) get owns attribute types contain:
      | username  |
      | reference |
      | score     |
      | rating    |
    When put attribute type: license, with value type: string
    When attribute(license) set supertype: reference
    When put attribute type: points, with value type: double
    When attribute(points) set supertype: rating
    When put entity type: subscriber
    When entity(subscriber) set abstract: true
    When entity(subscriber) set supertype: customer
    When entity(subscriber) set owns key type: license
    When entity(subscriber) set owns attribute type: points
    When transaction commits
    When session opens transaction of type: read
    Then entity(customer) get owns key types contain:
      | username  |
      | reference |
    Then entity(customer) get owns attribute types contain:
      | username  |
      | reference |
      | score     |
      | rating    |
    Then entity(subscriber) get owns key types contain:
      | username  |
      | reference |
      | license   |
    Then entity(subscriber) get owns attribute types contain:
      | username  |
      | reference |
      | license   |
      | score     |
      | rating    |
      | points    |

  Scenario: Entity types can override inherited keys and attributes
    When put attribute type: username, with value type: string
    When put attribute type: email, with value type: string
    When attribute(email) set abstract: true
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: age, with value type: long
    When put attribute type: reference, with value type: string
    When attribute(reference) set abstract: true
    When put attribute type: work-email, with value type: string
    When attribute(work-email) set supertype: email
    When put attribute type: nick-name, with value type: string
    When attribute(nick-name) set supertype: name
    When put attribute type: rating, with value type: double
    When attribute(rating) set abstract: true
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: username
    When entity(person) set owns key type: email
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: age
    When put entity type: customer
    When entity(customer) set abstract: true
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: reference
    When entity(customer) set owns key type: work-email as email
    When entity(customer) set owns attribute type: rating
    When entity(customer) set owns attribute type: nick-name as name
    Then entity(customer) get owns key types contain:
      | username   |
      | reference  |
      | work-email |
    Then entity(customer) get owns key types do not contain:
      | email |
    Then entity(customer) get owns attribute types contain:
      | username   |
      | reference  |
      | work-email |
      | age        |
      | rating     |
      | nick-name  |
    Then entity(customer) get owns attribute types do not contain:
      | email |
      | name  |
    When transaction commits
    When session opens transaction of type: write
    Then entity(customer) get owns key types contain:
      | username   |
      | reference  |
      | work-email |
    Then entity(customer) get owns key types do not contain:
      | email |
    Then entity(customer) get owns attribute types contain:
      | username   |
      | reference  |
      | work-email |
      | age        |
      | rating     |
      | nick-name  |
    Then entity(customer) get owns attribute types do not contain:
      | email |
      | name  |
    When put attribute type: license, with value type: string
    When attribute(license) set supertype: reference
    When put attribute type: points, with value type: double
    When attribute(points) set supertype: rating
    When put entity type: subscriber
    When entity(subscriber) set supertype: customer
    When entity(subscriber) set owns key type: license as reference
    When entity(subscriber) set owns attribute type: points as rating
    When transaction commits
    When session opens transaction of type: read
    Then entity(customer) get owns key types contain:
      | username   |
      | reference  |
      | work-email |
    Then entity(customer) get owns key types do not contain:
      | email |
    Then entity(customer) get owns attribute types contain:
      | username   |
      | reference  |
      | work-email |
      | age        |
      | rating     |
      | nick-name  |
    Then entity(customer) get owns attribute types do not contain:
      | email |
      | name  |
    Then entity(subscriber) get owns key types contain:
      | username   |
      | license    |
      | work-email |
    Then entity(subscriber) get owns key types do not contain:
      | email     |
      | reference |
    Then entity(subscriber) get owns attribute types contain:
      | username   |
      | license    |
      | work-email |
      | age        |
      | points     |
      | nick-name  |
    Then entity(subscriber) get owns attribute types do not contain:
      | email      |
      | references |
      | name       |
      | rating     |

  Scenario: Entity types can override inherited attributes as keys
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: username, with value type: string
    When attribute(username) set supertype: name
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: username as name
    Then entity(customer) get owns key types contain:
      | username |
    Then entity(customer) get owns key types do not contain:
      | name |
    Then entity(customer) get owns attribute types contain:
      | username |
    Then entity(customer) get owns attribute types do not contain:
      | name |
    When transaction commits
    When session opens transaction of type: read
    Then entity(customer) get owns key types contain:
      | username |
    Then entity(customer) get owns key types do not contain:
      | name |
    Then entity(customer) get owns attribute types contain:
      | username |
    Then entity(customer) get owns attribute types do not contain:
      | name |

  Scenario: Entity types can redeclare keys as keys
    When put attribute type: name, with value type: string
    When put attribute type: email, with value type: string
    When put entity type: person
    When entity(person) set owns key type: name
    When entity(person) set owns key type: email
    Then entity(person) set owns key type: name
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set owns key type: email

  Scenario: Entity types can redeclare attributes as attributes
    When put attribute type: name, with value type: string
    When put attribute type: email, with value type: string
    When put entity type: person
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: email
    Then entity(person) set owns attribute type: name
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set owns attribute type: email

  Scenario: Entity types can re-override keys as keys
    When put attribute type: email, with value type: string
    When attribute(email) set abstract: true
    When put attribute type: work-email, with value type: string
    When attribute(work-email) set supertype: email
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: email
    When put entity type: customer
    When entity(customer) set abstract: true
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: work-email as email
    When transaction commits
    When session opens transaction of type: write
    When entity(customer) set owns key type: work-email as email

  Scenario: Entity types can re-override attributes as attributes
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: nick-name, with value type: string
    When attribute(nick-name) set supertype: name
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set abstract: true
    When entity(customer) set supertype: person
    When entity(customer) set owns attribute type: nick-name as name
    When transaction commits
    When session opens transaction of type: write
    When entity(customer) set owns attribute type: nick-name as name

  Scenario: Entity types can redeclare keys as attributes
    When put attribute type: name, with value type: string
    When put attribute type: email, with value type: string
    When put entity type: person
    When entity(person) set owns key type: name
    When entity(person) set owns key type: email
    Then entity(person) set owns attribute type: name
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set owns attribute type: email

  Scenario: Entity types can redeclare attributes as keys
    When put attribute type: name, with value type: string
    When put attribute type: email, with value type: string
    When put entity type: person
    When entity(person) set owns attribute type: name
    When entity(person) set owns attribute type: email
    Then entity(person) set owns key type: name
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set owns key type: email

  Scenario: Entity types can redeclare inherited attributes as keys (which will override)
    When put attribute type: email, with value type: string
    When put entity type: person
    When entity(person) set owns attribute type: email
    When put entity type: customer
    When entity(customer) set supertype: person
    Then entity(customer) set owns key type: email
    Then entity(customer) get owns key types contain:
      | email |
    When transaction commits
    When session opens transaction of type: write
    Then entity(customer) get owns key types contain:
      | email |
    When put entity type: subscriber
    When entity(subscriber) set supertype: person
    Then entity(subscriber) set owns key type: email
    Then entity(subscriber) get owns key types contain:
      | email |

  Scenario: Entity types cannot redeclare inherited attributes as attributes
    When put attribute type: email, with value type: string
    When put attribute type: name, with value type: string
    When put entity type: person
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set supertype: person
    Then entity(customer) set owns attribute type: name; throws exception

  Scenario: Entity types cannot redeclare inherited keys as keys or attributes
    When put attribute type: email, with value type: string
    When put attribute type: name, with value type: string
    When put entity type: person
    When entity(person) set owns key type: email
    When put entity type: customer
    When entity(customer) set supertype: person
    When transaction commits
    When session opens transaction of type: write
    Then entity(customer) set owns key type: email; throws exception
    When session opens transaction of type: write
    Then entity(customer) set owns attribute type: email; throws exception

  Scenario: Entity types cannot redeclare inherited key attribute types
    When put attribute type: email, with value type: string
    When attribute(email) set abstract: true
    When put attribute type: customer-email, with value type: string
    When attribute(customer-email) set supertype: email
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: email
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: customer-email
    When put entity type: subscriber
    When entity(subscriber) set supertype: customer
    Then entity(subscriber) set owns key type: email; throws exception

  Scenario: Entity types cannot redeclare overridden key attribute types
    When put attribute type: email, with value type: string
    When attribute(email) set abstract: true
    When put attribute type: customer-email, with value type: string
    When attribute(customer-email) set supertype: email
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: email
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set owns key type: customer-email
    When put entity type: subscriber
    When entity(subscriber) set supertype: customer
    Then entity(subscriber) set owns key type: customer-email; throws exception

  Scenario: Entity types cannot redeclare inherited owns attribute types
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: customer-name, with value type: string
    When attribute(customer-name) set supertype: name
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set owns attribute type: customer-name
    When put entity type: subscriber
    When entity(subscriber) set supertype: customer
    Then entity(subscriber) set owns attribute type: name; throws exception

  Scenario: Entity types cannot redeclare overridden owns attribute types
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: customer-name, with value type: string
    When attribute(customer-name) set supertype: name
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set owns attribute type: customer-name
    When put entity type: subscriber
    When entity(subscriber) set supertype: customer
    Then entity(subscriber) set owns attribute type: customer-name; throws exception

  Scenario: Entity types cannot override declared keys and attributes
    When put attribute type: username, with value type: string
    When attribute(username) set abstract: true
    When put attribute type: email, with value type: string
    When attribute(email) set supertype: username
    When put attribute type: name, with value type: string
    When attribute(name) set abstract: true
    When put attribute type: first-name, with value type: string
    When attribute(first-name) set supertype: name
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: username
    When entity(person) set owns attribute type: name
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) set owns key type: email as username; throws exception
    When session opens transaction of type: write
    Then entity(person) set owns attribute type: first-name as name; throws exception

  Scenario: Entity types cannot override inherited keys as attributes
    When put attribute type: username, with value type: string
    When attribute(username) set abstract: true
    When put attribute type: email, with value type: string
    When attribute(email) set supertype: username
    When put entity type: person
    When entity(person) set abstract: true
    When entity(person) set owns key type: username
    When put entity type: customer
    When entity(customer) set supertype: person
    Then entity(customer) set owns attribute type: email as username; throws exception

  Scenario: Entity types cannot override inherited keys and attributes other than with their subtypes
    When put attribute type: username, with value type: string
    When put attribute type: name, with value type: string
    When put attribute type: reference, with value type: string
    When put attribute type: rating, with value type: double
    When put entity type: person
    When entity(person) set owns key type: username
    When entity(person) set owns attribute type: name
    When put entity type: customer
    When entity(customer) set supertype: person
    When transaction commits
    When session opens transaction of type: write
    Then entity(customer) set owns key type: reference as username; throws exception
    When session opens transaction of type: write
    Then entity(customer) set owns attribute type: rating as name; throws exception

  Scenario: Entity types can play role types
    When put relation type: marriage
    When relation(marriage) set relates role: husband
    When put entity type: person
    When entity(person) set plays role: marriage:husband
    Then entity(person) get playing roles contain:
      | marriage:husband |
    Then relation(marriage) get role(husband) get players contain:
      | person |
    When transaction commits
    When session opens transaction of type: write
    When relation(marriage) set relates role: wife
    When entity(person) set plays role: marriage:wife
    Then entity(person) get playing roles contain:
      | marriage:husband |
      | marriage:wife    |
    Then relation(marriage) get role(husband) get players contain:
      | person |
    Then relation(marriage) get role(wife) get players contain:
      | person |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get playing roles contain:
      | marriage:husband |
      | marriage:wife    |
    Then relation(marriage) get role(husband) get players contain:
      | person |
    Then relation(marriage) get role(wife) get players contain:
      | person |

  Scenario: Entity types can unset playing role types
    When put relation type: marriage
    When relation(marriage) set relates role: husband
    When relation(marriage) set relates role: wife
    When put entity type: person
    When entity(person) set plays role: marriage:husband
    When entity(person) set plays role: marriage:wife
    Then entity(person) unset plays role: marriage:husband
    Then entity(person) get playing roles do not contain:
      | marriage:husband |
    Then relation(marriage) get role(husband) get players do not contain:
      | person |
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) unset plays role: marriage:wife
    Then entity(person) get playing roles do not contain:
      | marriage:husband |
      | marriage:wife    |
    Then relation(marriage) get role(husband) get players do not contain:
      | person |
    Then relation(marriage) get role(wife) get players do not contain:
      | person |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get playing roles do not contain:
      | marriage:husband |
      | marriage:wife    |
    Then relation(marriage) get role(husband) get players do not contain:
      | person |
    Then relation(marriage) get role(wife) get players do not contain:
      | person |

  Scenario: Attempting to unset playing a role type that an entity type cannot actually play throws
    When put relation type: marriage
    When relation(marriage) set relates role: husband
    When relation(marriage) set relates role: wife
    When put entity type: person
    When entity(person) set plays role: marriage:wife
    Then entity(person) get playing roles do not contain:
      | marriage:husband |
    Then entity(person) unset plays role: marriage:husband; throws exception

  Scenario: Entity types cannot unset playing role types that are currently played by existing instances
    When put relation type: marriage
    When relation(marriage) set relates role: husband
    When relation(marriage) set relates role: wife
    When put entity type: person
    When entity(person) set plays role: marriage:wife
    Then transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $m = relation(marriage) create new instance
    When $a = entity(person) create new instance
    When relation $m add player for role(wife): $a
    Then transaction commits
    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    Then entity(person) unset plays role: marriage:wife; throws exception

  Scenario: Entity types can inherit playing role types
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When relation(parentship) set relates role: child
    When put relation type: marriage
    When relation(marriage) set relates role: husband
    When relation(marriage) set relates role: wife
    When put entity type: animal
    When entity(animal) set plays role: parentship:parent
    When entity(animal) set plays role: parentship:child
    When put entity type: person
    When entity(person) set supertype: animal
    When entity(person) set plays role: marriage:husband
    When entity(person) set plays role: marriage:wife
    Then entity(person) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
      | marriage:husband  |
      | marriage:wife     |
    When transaction commits
    When session opens transaction of type: write
    Then entity(person) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
      | marriage:husband  |
      | marriage:wife     |
    When put relation type: sales
    When relation(sales) set relates role: buyer
    When put entity type: customer
    When entity(customer) set supertype: person
    When entity(customer) set plays role: sales:buyer
    Then entity(customer) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
      | marriage:husband  |
      | marriage:wife     |
      | sales:buyer       |
    When transaction commits
    When session opens transaction of type: read
    Then entity(animal) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
    Then entity(person) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
      | marriage:husband  |
      | marriage:wife     |
    Then entity(customer) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
      | marriage:husband  |
      | marriage:wife     |
      | sales:buyer       |

  Scenario: Entity types can inherit playing role types that are subtypes of each other
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When relation(parentship) set relates role: child
    When put relation type: fathership
    When relation(fathership) set supertype: parentship
    When relation(fathership) set relates role: father as parent
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    When entity(person) set plays role: parentship:child
    When put entity type: man
    When entity(man) set supertype: person
    When entity(man) set plays role: fathership:father
    Then entity(man) get playing roles contain:
      | parentship:parent |
      | fathership:father |
      | parentship:child  |
    When transaction commits
    When session opens transaction of type: write
    Then entity(man) get playing roles contain:
      | parentship:parent |
      | fathership:father |
      | parentship:child  |
    When put relation type: mothership
    When relation(mothership) set supertype: parentship
    When relation(mothership) set relates role: mother as parent
    When put entity type: woman
    When entity(woman) set supertype: person
    When entity(woman) set plays role: mothership:mother
    Then entity(woman) get playing roles contain:
      | parentship:parent |
      | mothership:mother |
      | parentship:child  |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
    Then entity(man) get playing roles contain:
      | parentship:parent |
      | fathership:father |
      | parentship:child  |
    Then entity(woman) get playing roles contain:
      | parentship:parent |
      | mothership:mother |
      | parentship:child  |

  Scenario: Entity types can override inherited playing role types
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When relation(parentship) set relates role: child
    When put relation type: fathership
    When relation(fathership) set supertype: parentship
    When relation(fathership) set relates role: father as parent
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    When entity(person) set plays role: parentship:child
    When put entity type: man
    When entity(man) set supertype: person
    When entity(man) set plays role: fathership:father as parentship:parent
    Then entity(man) get playing roles contain:
      | fathership:father |
      | parentship:child  |
    Then entity(man) get playing roles do not contain:
      | parentship:parent |
    When transaction commits
    When session opens transaction of type: write
    Then entity(man) get playing roles contain:
      | fathership:father |
      | parentship:child  |
    Then entity(man) get playing roles do not contain:
      | parentship:parent |
    When put relation type: mothership
    When relation(mothership) set supertype: parentship
    When relation(mothership) set relates role: mother as parent
    When put entity type: woman
    When entity(woman) set supertype: person
    When entity(woman) set plays role: mothership:mother as parentship:parent
    Then entity(woman) get playing roles contain:
      | mothership:mother |
      | parentship:child  |
    Then entity(woman) get playing roles do not contain:
      | parentship:parent |
    When transaction commits
    When session opens transaction of type: read
    Then entity(person) get playing roles contain:
      | parentship:parent |
      | parentship:child  |
    Then entity(man) get playing roles contain:
      | fathership:father |
      | parentship:child  |
    Then entity(man) get playing roles do not contain:
      | parentship:parent |
    Then entity(woman) get playing roles contain:
      | mothership:mother |
      | parentship:child  |
    Then entity(woman) get playing roles do not contain:
      | parentship:parent |

  Scenario: Entity types can redeclare playing role types
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    When transaction commits
    When session opens transaction of type: write
    When entity(person) set plays role: parentship:parent

  Scenario: Entity types can re-override inherited playing role types
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When put relation type: fathership
    When relation(fathership) set supertype: parentship
    When relation(fathership) set relates role: father as parent
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    When put entity type: man
    When entity(man) set supertype: person
    When entity(man) set plays role: fathership:father as parentship:parent
    When transaction commits
    When session opens transaction of type: write
    When entity(man) set plays role: fathership:father as parentship:parent

  Scenario: Entity types cannot redeclare inherited/overridden playing role types
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When put relation type: fathership
    When relation(fathership) set supertype: parentship
    When relation(fathership) set relates role: father as parent
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    When put entity type: man
    When entity(man) set supertype: person
    When entity(man) set plays role: fathership:father as parentship:parent
    When put entity type: boy
    When entity(boy) set supertype: man
    When transaction commits
    When session opens transaction of type: write
    Then entity(boy) set plays role: parentship:parent; throws exception
    When session opens transaction of type: write
    Then entity(boy) set plays role: fathership:father; throws exception

  Scenario: Entity types cannot override declared playing role types
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When put relation type: fathership
    When relation(fathership) set supertype: parentship
    When relation(fathership) set relates role: father as parent
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    Then entity(person) set plays role: fathership:father as parentship:parent; throws exception

  Scenario: Entity types cannot override inherited playing role types other than with their subtypes
    When put relation type: parentship
    When relation(parentship) set relates role: parent
    When relation(parentship) set relates role: child
    When put relation type: fathership
    When relation(fathership) set relates role: father
    When put entity type: person
    When entity(person) set plays role: parentship:parent
    When entity(person) set plays role: parentship:child
    When put entity type: man
    When entity(man) set supertype: person
    Then entity(man) set plays role: fathership:father as parentship:parent; throws exception
