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
Feature: Graql Undefine Query

  Background: Open connection and create a simple extensible schema
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write

    Given graql define
      """
      define
      person sub entity, plays employment:employee, owns name, owns email @key;
      employment sub relation, relates employee, relates employer;
      name sub attribute, value string;
      email sub attribute, value string, regex ".+@\w+\..+";
      abstract-type sub entity, abstract;
      """
    Given transaction commits

    Given session opens transaction of type: write


  ################
  # ENTITY TYPES #
  ################

  Scenario: calling 'undefine' with 'sub entity' on a subtype of 'entity' deletes it
    Given get answers of graql match
      """
      match $x sub entity;
      """
    Given uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
      | label:person        |
      | label:entity        |
    When graql undefine
      """
      undefine person sub entity;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub entity;
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
      | label:entity        |


  Scenario: when undefining 'sub' on an entity type, specifying a type that isn't really its supertype throws
    When graql undefine; throws exception
      """
      undefine person sub relation;
      """


  Scenario: a sub-entity type can be removed using 'sub' with its direct supertype, and its parent is preserved
    Given graql define
      """
      define child sub person;
      """
    Given transaction commits

    When session opens transaction of type: write
    Given get answers of graql match
      """
      match $x sub person;
      """
    Given uniquely identify answer concepts
      | x            |
      | label:person |
      | label:child  |
    When graql undefine
      """
      undefine child sub person;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub person;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: undefining a type 'sub' an indirect supertype should still remove that type
    Given graql define
      """
      define child sub person;
      """
    Given transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub person;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |
      | label:child  |
    When session opens transaction of type: write
    When graql undefine
      """
      undefine child sub entity;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub person;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: undefining a supertype throws an error if subtypes exist
    Given graql define
      """
      define child sub person;
      """
    Given transaction commits

    When session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine person sub entity;
      """


  Scenario: removing a playable role from a super entity type also removes it from its subtypes
    Given graql define
      """
      define child sub person;
      """
    Given transaction commits

    When session opens transaction of type: write
    When graql undefine
      """
      undefine person plays employment:employee;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x type child; $x plays employment:employee;
      """
    Then answer size is: 0


  Scenario: removing an attribute ownership from a super entity type also removes it from its subtypes
    Given graql define
      """
      define child sub person;
      """
    Given transaction commits

    When session opens transaction of type: write
    When graql undefine
      """
      undefine person owns name;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x type child; $x owns name;
      """
    Then answer size is: 0


  Scenario: removing a key ownership from a super entity type also removes it from its subtypes
    Given graql define
      """
      define child sub person;
      """
    Given transaction commits

    When session opens transaction of type: write
    When graql undefine
      """
      undefine person owns email;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x type child; $x owns email @key;
      """
    Then answer size is: 0

  Scenario: all existing instances of an entity type must be deleted in order to undefine it
    Given get answers of graql match
      """
      match $x sub entity;
      """
    Given uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
      | label:person        |
      | label:entity        |
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has name "Victor", has email "victor@grakn.ai";
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    When session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine person sub entity;
      """

    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person;
      delete
        $x isa person;
      """
    Then transaction commits

    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    When graql undefine
      """
      undefine person sub entity;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub entity;
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
      | label:entity        |


  ##################
  # RELATION TYPES #
  ##################

  Scenario: undefining a relation type removes it
    Given get answers of graql match
      """
      match $x sub relation;
      """
    Given uniquely identify answer concepts
      | x                |
      | label:employment |
      | label:relation   |
    When graql undefine
      """
      undefine employment sub relation;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub relation;
      """
    Then uniquely identify answer concepts
      | x              |
      | label:relation |


  Scenario: removing playable roles from a super relation type also removes them from its subtypes
    Given graql define
      """
      define
      employment-terms sub relation, relates employment;
      employment plays employment-terms:employment;
      contract-employment sub employment;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match contract-employment plays $x;
      """
    Given uniquely identify answer concepts
      | x                                 |
      | label:employment-terms:employment |
    When graql undefine
      """
      undefine employment plays employment-terms:employment;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match contract-employment plays $x;
      """
    Then answer size is: 0


  Scenario: removing attribute ownerships from a super relation type also removes them from its subtypes
    Given graql define
      """
      define
      start-date sub attribute, value datetime;
      employment owns start-date;
      contract-employment sub employment;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match $x owns start-date;
      """
    Given uniquely identify answer concepts
      | x                         |
      | label:employment          |
      | label:contract-employment |
    When graql undefine
      """
      undefine employment owns start-date;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns start-date;
      """
    Then answer size is: 0


  Scenario: removing key ownerships from a super relation type also removes them from its subtypes
    Given graql define
      """
      define
      employment-reference sub attribute, value string;
      employment owns employment-reference @key;
      contract-employment sub employment;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match $x owns employment-reference @key;
      """
    Given uniquely identify answer concepts
      | x                         |
      | label:employment          |
      | label:contract-employment |
    When graql undefine
      """
      undefine employment owns employment-reference;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns employment-reference @key;
      """
    Then answer size is: 0


  Scenario: undefining a relation type throws on commit if it has existing instances
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has name "Harald", has email "harald@grakn.ai";
      $r (employee: $p) isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine
      employment relates employee;
      employment relates employer;
      person plays employment:employee;
      employment sub relation;
      """


  Scenario: all existing instances of a relation type must be deleted in order to undefine it
    Given get answers of graql match
      """
      match $x sub relation;
      """
    Given uniquely identify answer concepts
      | x                |
      | label:employment |
      | label:relation   |
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has name "Harald", has email "harald@grakn.ai";
      $r (employee: $p) isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine employment sub relation;
      """

    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When graql delete
      """
      match
        $r isa employment;
      delete
        $r isa employment;
      """
    Then transaction commits

    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    When graql undefine
      """
      undefine employment sub relation;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub relation;
      """
    Then uniquely identify answer concepts
      | x              |
      | label:relation |


  Scenario: undefining a relation type automatically detaches any possible roleplayers
    Given get answers of graql match
      """
      match
        $x type person;
        $x plays $y;
      """
    Given uniquely identify answer concepts
      | x            | y                         |
      | label:person | label:employment:employee |
    When graql undefine
      """
      undefine employment sub relation;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x type person;
        $x plays $y;
      """
    Then answer size is: 0


  #############################
  # RELATED ROLES ('RELATES') #
  #############################

  Scenario: a role type can be removed from its relation type
    Given get answers of graql match
      """
      match employment relates $x;
      """
    Given uniquely identify answer concepts
      | x                         |
      | label:employment:employee |
      | label:employment:employer |
    When graql undefine
      """
      undefine employment relates employee;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match employment relates $x;
      """
    Then uniquely identify answer concepts
      | x                         |
      | label:employment:employer |


  Scenario: undefining all players of a role produces a valid schema
    When graql undefine
      """
      undefine person plays employment:employee;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x plays employment:employee;
      """
    Then answer size is: 0

  #TODO: test is not working
  @ignore
  Scenario: after removing a role from a relation type, relation instances can no longer be created with that role
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has email "ganesh@grakn.ai";
      $r (employee: $p) isa employment;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given graql delete
      """
      match
        $r isa employment;
      delete
        $r isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    When graql undefine
      """
      undefine
      person plays employment:employee;
      employment relates employee;
      """
    Then transaction commits

    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When get answers of graql match
      """
      match $x relates employee;
      """
    Then answer size is: 0
    Then graql insert; throws exception
      """
      match
        $p isa person, has email "ganesh@grakn.ai";
      insert
        $r (employee: $p) isa employment;
      """


  Scenario: removing all roles from a relation type without undefining the relation type throws on commit
    When graql undefine
      """
      undefine
      employment relates employee;
      employment relates employer;
      """
    Then transaction commits; throws exception


  Scenario: undefining a role type automatically detaches any possible roleplayers
    Given get answers of graql match
      """
      match
        $x type person;
        $x plays $y;
      """
    Given uniquely identify answer concepts
      | x            | y                         |
      | label:person | label:employment:employee |
    When graql undefine
      """
      undefine employment relates employee;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x type person;
        $x plays $y;
      """
    Then answer size is: 0


  Scenario: removing a role throws an error if it is played by existing roleplayers in relations
    Given graql define
      """
      define
      company sub entity, owns name, plays employment:employer;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has name "Ada", has email "ada@grakn.ai";
      $c isa company, has name "IBM";
      $r (employee: $p, employer: $c) isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine employment relates employer;
      """


  Scenario: a role that is not played in any existing instance of its relation type can be safely removed
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has name "Vijay", has email "vijay@grakn.ai";
      $r (employee: $p) isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    When graql undefine
      """
      undefine employment relates employer;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match employment relates $x;
      """
    Then uniquely identify answer concepts
      | x                         |
      | label:employment:employee |


  Scenario: removing a role from a super relation type also removes it from its subtypes
    Given graql define
      """
      define part-time sub employment;
      """
    Given transaction commits

    When session opens transaction of type: write
    When graql undefine
      """
      undefine employment relates employer;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x type part-time; $x relates $role;
      """
    Then uniquely identify answer concepts
      | x               | role                      |
      | label:part-time | label:employment:employee |

  # TODO
  Scenario: removing a role from a super relation type also removes roles that override it in its subtypes (?)

  # TODO
  Scenario: after undefining a sub-role from a relation type, it is gone and the type is left with just its parent role (?)


  ############################
  # PLAYABLE ROLES ('PLAYS') #
  ############################

  Scenario: after undefining a playable role from a type, the type can no longer play the role
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has email "ganesh@grakn.ai";
      $r (employee: $p) isa employment;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given graql delete
      """
      match
        $r isa employment;
      delete
        $r isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    When graql undefine
      """
      undefine person plays employment:employee;
      """
    Then transaction commits

    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When get answers of graql match
      """
      match $x plays employment:employee;
      """
    Then answer size is: 0
    Then graql insert; throws exception
      """
      match
        $p isa person, has email "ganesh@grakn.ai";
      insert
        $r (employee: $p) isa employment;
      """


  Scenario: undefining a playable role that was not actually playable to begin with throws
    Given get answers of graql match
      """
      match person plays $x;
      """
    Given uniquely identify answer concepts
      | x                         |
      | label:employment:employee |
    When graql undefine; throws exception
      """
      undefine person plays employment:employer;
      """


  Scenario: removing a playable role throws an error if it is played by existing instances
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $p isa person, has email "ganesh@grakn.ai";
      $r (employee: $p) isa employment;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine person plays employment:employee;
      """


  ###################
  # ATTRIBUTE TYPES #
  ###################

  Scenario Outline: undefining 'sub attribute' on an attribute type with value type '<value_type>' removes it
    Given graql define
      """
      define <attr> sub attribute, value <value_type>;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match $x type <attr>;
      """
    Given answer size is: 1
    When graql undefine
      """
      undefine <attr> sub attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    Then graql match; throws exception
      """
      match $x type <attr>;
      """

    Examples:
      | value_type | attr       |
      | string     | colour     |
      | long       | age        |
      | double     | height     |
      | boolean    | is-awake   |
      | datetime   | birth-date |


  Scenario: undefining a regex on an attribute type removes the regex constraints on the attribute
    When graql undefine
      """
      undefine email regex ".+@\w+\..+";
      """
    Then transaction commits

    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When graql insert
      """
      insert $x "not-email-regex" isa email;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa email;
      """
    Then answer size is: 1


  Scenario: removing playable roles from a super attribute type also removes them from its subtypes
    Given graql define
      """
      define
      name abstract;
      first-name sub name;
      employment relates manager-name;
      name plays employment:manager-name;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match first-name plays $x;
      """
    Given uniquely identify answer concepts
      | x                             |
      | label:employment:manager-name |
    When graql undefine
      """
      undefine name plays employment:manager-name;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match first-name plays $x;
      """
    Then answer size is: 0


  Scenario: removing attribute ownerships from a super attribute type also removes them from its subtypes
    Given graql define
      """
      define
      name abstract;
      first-name sub name;
      locale sub attribute, value string;
      name owns locale;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match $x owns locale;
      """
    Given uniquely identify answer concepts
      | x                |
      | label:name       |
      | label:first-name |
    When graql undefine
      """
      undefine name owns locale;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns locale;
      """
    Then answer size is: 0


  Scenario: removing a key ownership from a super attribute type also removes it from its subtypes
    Given graql define
      """
      define
      name abstract;
      first-name sub name;
      name-id sub attribute, value long;
      name owns name-id @key;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match $x owns name-id @key;
      """
    Given uniquely identify answer concepts
      | x                |
      | label:name       |
      | label:first-name |
    When graql undefine
      """
      undefine name owns name-id;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns name-id @key;
      """
    Then answer size is: 0


  Scenario: an attribute and its self-ownership can be removed simultaneously
    Given graql define
      """
      define
      name owns name;
      """
    Given transaction commits

    Given session opens transaction of type: write
    When graql undefine
      """
      undefine
      name owns name;
      name sub attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    Then graql match; throws exception
      """
      match $x type name;
      """


  Scenario: undefining the value type of an attribute throws an error
    When graql undefine; throws exception
      """
      undefine name value string;
      """


  Scenario: all existing instances of an attribute type must be deleted in order to undefine it
    Given get answers of graql match
      """
      match $x sub attribute;
      """
    Given uniquely identify answer concepts
      | x               |
      | label:name      |
      | label:email     |
      | label:attribute |
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x "Colette" isa name;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine name sub attribute;
      """

    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa name;
      delete
        $x isa name;
      """
    Then transaction commits

    When connection close all sessions
    When connection open schema session for database: grakn
    When session opens transaction of type: write
    When graql undefine
      """
      undefine name sub attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub attribute;
      """
    Then uniquely identify answer concepts
      | x               |
      | label:email     |
      | label:attribute |


  ########################
  # ATTRIBUTE OWNERSHIPS #
  ########################

  Scenario: undefining an attribute ownership removes it
    Given get answers of graql match
      """
      match
        $x owns name;
        $x type person;
      """
    Given uniquely identify answer concepts
      | x            |
      | label:person |
    When graql undefine
      """
      undefine person owns name;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x owns name;
        $x type person;
      """
    Then answer size is: 0


  Scenario: attempting to undefine an attribute ownership that was not actually owned to begin throws
    When graql undefine; throws exception
      """
      undefine employment owns name;
      """


  Scenario: attempting to undefine an attribute ownership inherited from a parent throws
    Given graql define
      """
      define child sub person;
      """
    Then transaction commits

    When session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine child owns name;
      """


  Scenario: undefining a key ownership removes it
    When graql undefine
      """
      undefine person owns email;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns email;
      """
    Then answer size is: 0


  Scenario: writing '@key' when undefining a key ownership is not allowed
    Then graql undefine; throws exception
      """
      undefine person owns email @key;
      """


  Scenario: writing '@key' when undefining an attribute ownership is not allowed
    Then graql undefine; throws exception
      """
      undefine person owns name @key;
      """


  Scenario: when a type can own an attribute, but none of its instances actually do, the ownership can be undefined
    Given get answers of graql match
      """
      match $x owns name;
      """
    Given uniquely identify answer concepts
      | x            |
      | label:person |
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has email "anon@grakn.ai";
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    When graql undefine
      """
      undefine person owns name;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns name;
      """
    Then answer size is: 0


  Scenario: removing an attribute ownership throws an error if it is owned by existing instances
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has name "Tomas", has email "tomas@grakn.ai";
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine person owns name;
      """


  Scenario: undefining a key ownership throws an error if it is owned by existing instances
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has name "Daniel", has email "daniel@grakn.ai";
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Then graql undefine; throws exception
      """
      undefine person owns email;
      """


  #########
  # RULES #
  #########

  Scenario: undefining a rule removes it
    Given graql define
      """
      define
      company sub entity, plays employment:employer;
      rule a-rule:
      when {
        $c isa company; $y isa person;
      } then {
        (employer: $c, employee: $y) isa employment;
      };
      """
    Given transaction commits

    When session opens transaction of type: write
    Then rules contain: a-rule
    When graql undefine
      """
      undefine rule a-rule;
      """
    Then transaction commits

    When session opens transaction of type: read
    Then rules do not contain: a-rule

  Scenario: after undefining a rule, concepts previously inferred by that rule are no longer inferred
    Given graql define
      """
      define
      rule samuel-email-rule:
      when {
        $x has email "samuel@grakn.ai";
      } then {
        $x has name "Samuel";
      };
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has email "samuel@grakn.ai";
      """
    Given transaction commits

    Given session opens transaction of type: read
    Given get answers of graql match
      """
      match
        $x has name $n;
      get $n;
      """
    Given uniquely identify answer concepts
      | n                 |
      | value:name:Samuel |
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    When graql undefine
      """
      undefine rule samuel-email-rule;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x has name $n;
      get $n;
      """
    Then answer size is: 0


  # TODO enable when we can do reasoning in a schema write transaction
  @ignore
  Scenario: when undefining a rule, concepts inferred by that rule can still be retrieved until the next commit
    Given graql define
      """
      define
      rule samuel-email-rule:
      when {
        $x has email "samuel@grakn.ai";
      } then {
        $x has name "Samuel";
      };
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has email "samuel@grakn.ai";
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given get answers of graql match
      """
      match
        $x has name $n;
      get $n;
      """
    Given uniquely identify answer concepts
      | n                 |
      | value:name:Samuel |
    When graql undefine
      """
      undefine rule samuel-email-rule;
      """

    When get answers of graql match
      """
      match
        $x has name $n;
      get $n;
      """
    Then uniquely identify answer concepts
      | n                 |
      | value:name:Samuel |


  ############
  # ABSTRACT #
  ############

  Scenario: undefining a type as abstract converts an abstract to a concrete type, allowing creation of instances
    Given get answers of graql match
      """
      match
        $x type abstract-type;
        not { $x abstract; };
      """
    Given answer size is: 0
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert; throws exception
      """
      insert $x isa abstract-type;
      """

    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql undefine
      """
      undefine abstract-type abstract;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    When get answers of graql match
      """
      match
        $x type abstract-type;
        not { $x abstract; };
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
    When graql insert
      """
      insert $x isa abstract-type;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa abstract-type;
      """
    Then answer size is: 1


  Scenario: undefining abstract on a type that is already non-abstract does nothing
    When graql undefine
      """
      undefine person abstract;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x type person;
        not { $x abstract; };
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: an abstract type can be changed into a concrete type even if has an abstract child type
    Given graql define
      """
      define sub-abstract-type sub abstract-type, abstract;
      """
    Given transaction commits

    Given session opens transaction of type: write
    When graql undefine
      """
      undefine abstract-type abstract;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x type abstract-type;
        not { $x abstract; };
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:abstract-type |


  Scenario: undefining abstract on an attribute type is allowed, even if that attribute type has an owner
    Given graql define
      """
      define
      person abstract;
      vehicle-registration sub attribute, value string, abstract;
      person owns vehicle-registration;
      """
    Given transaction commits

    Given session opens transaction of type: write
    When graql undefine
      """
      undefine
      vehicle-registration abstract;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x type vehicle-registration;
        not { $x abstract; };
      """
    Then answer size is: 1


  ###################
  # COMPLEX QUERIES #
  ###################

  Scenario: a type and an attribute type that it owns can be removed simultaneously
    Given get answers of graql match
      """
      match $x sub entity;
      """
    Given uniquely identify answer concepts
      | x                   |
      | label:person        |
      | label:abstract-type |
      | label:entity        |
    Given get answers of graql match
      """
      match $x sub attribute;
      """
    Given uniquely identify answer concepts
      | x               |
      | label:name      |
      | label:email     |
      | label:attribute |
    When graql undefine
      """
      undefine
      person sub entity, owns name;
      name sub attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub entity;
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
      | label:entity        |
    When get answers of graql match
      """
      match $x sub attribute;
      """
    Then uniquely identify answer concepts
      | x               |
      | label:email     |
      | label:attribute |

  Scenario: a type, a relation type that it plays in and an attribute type that it owns can be removed simultaneously
    Given get answers of graql match
      """
      match $x sub entity;
      """
    Given uniquely identify answer concepts
      | x                   |
      | label:person        |
      | label:abstract-type |
      | label:entity        |
    Given get answers of graql match
      """
      match $x sub relation;
      """
    Given uniquely identify answer concepts
      | x                |
      | label:employment |
      | label:relation   |
    Given get answers of graql match
      """
      match $x sub attribute;
      """
    Given uniquely identify answer concepts
      | x               |
      | label:name      |
      | label:email     |
      | label:attribute |
    Given get answers of graql match
      """
      match $x sub relation:role;
      """
    Given uniquely identify answer concepts
      | x                         |
      | label:employment:employee |
      | label:employment:employer |
      | label:relation:role       |
    When graql undefine
      """
      undefine
      person sub entity, owns name, owns email, plays employment:employee;
      employment sub relation, relates employee, relates employer;
      name sub attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub entity;
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:abstract-type |
      | label:entity        |
    When get answers of graql match
      """
      match $x sub relation;
      """
    Then uniquely identify answer concepts
      | x              |
      | label:relation |
    When get answers of graql match
      """
      match $x sub attribute;
      """
    Then uniquely identify answer concepts
      | x               |
      | label:email     |
      | label:attribute |
    When get answers of graql match
      """
      match $x sub relation:role;
      """
    Then uniquely identify answer concepts
      | x                   |
      | label:relation:role |
