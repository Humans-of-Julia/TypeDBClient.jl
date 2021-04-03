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
Feature: Graql Delete Query

  Background: Open connection and create a simple extensible schema
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write

    Given graql define
      """
      define
      person sub entity,
        plays friendship:friend,
        owns name @key;
      friendship sub relation,
        relates friend,
        owns ref @key;
      name sub attribute, value string;
      ref sub attribute, value long;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write


  ##########
  # THINGS #
  ##########

  Scenario: when deleting multiple variables, they all get deleted
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship,
         has ref 0;
      $n "John" isa name;
      """
    Given uniquely identify answer concepts
      | x             | y            | r         | n               |
      | key:name:Alex | key:name:Bob | key:ref:0 | value:name:John |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person, has name "Alex";
        $r isa friendship, has ref 0;
        $n "John" isa name;
      delete
        $x isa thing; $r isa thing; $n isa thing;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then uniquely identify answer concepts
      | x            |
      | key:name:Bob |
    When get answers of graql match
      """
      match $x isa friendship;
      """
    Then answer size is: 0
    When get answers of graql match
      """
      match $x isa name;
      """
    Then uniquely identify answer concepts
      | x               |
      | value:name:Alex |
      | value:name:Bob  |


  Scenario: an instance can be deleted using the 'thing' meta label
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship,
         has ref 0;
      $n "John" isa name;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         | n               |
      | key:name:Alex | key:name:Bob | key:ref:0 | value:name:John |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $r isa person, has name "Alex";
      delete
        $r isa thing;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then uniquely identify answer concepts
      | x            |
      | key:name:Bob |


  Scenario: an entity can be deleted using the 'entity' meta label
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship,
         has ref 0;
      $n "John" isa name;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         | n               |
      | key:name:Alex | key:name:Bob | key:ref:0 | value:name:John |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $r isa person, has name "Alex";
      delete
        $r isa entity;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then uniquely identify answer concepts
      | x            |
      | key:name:Bob |


  Scenario: a relation can be deleted using the 'relation' meta label
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship,
         has ref 0;
      $n "John" isa name;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         | n               |
      | key:name:Alex | key:name:Bob | key:ref:0 | value:name:John |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $r isa friendship, has ref 0;
      delete
        $r isa relation;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa friendship;
      """
    Then answer size is: 0


  Scenario: an attribute can be deleted using the 'attribute' meta label
    Given get answers of graql insert
      """
      insert
      $n "John" isa name;
      """
    Then uniquely identify answer concepts
      | n               |
      | value:name:John |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $r "John" isa name;
      delete
        $r isa attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa name;
      """
    Then answer size is: 0


  Scenario: an instance can be deleted using its own type label
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship,
         has ref 0;
      $n "John" isa name;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         | n               |
      | key:name:Alex | key:name:Bob | key:ref:0 | value:name:John |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $r isa person, has name "Alex";
      delete
        $r isa person;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then uniquely identify answer concepts
      | x            |
      | key:name:Bob |


  Scenario: one delete statement can delete multiple things
    Given get answers of graql insert
      """
      insert
      $a isa person, has name "Alice";
      $b isa person, has name "Barbara";
      """
    Then uniquely identify answer concepts
      | a              | b                |
      | key:name:Alice | key:name:Barbara |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
      $p isa person;
      delete
      $p isa person;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then answer size is: 0


  Scenario: deleting an instance using an unrelated type label throws
    Given graql insert
      """
      insert
      $x isa person, has name "Alex";
      $n "John" isa name;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $x isa person;
        $r isa name; $r "John";
      delete
        $r isa person;
      """



  Scenario: deleting an instance using a non-existing type label throws
    Given graql insert
      """
      insert
      $n "John" isa name;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $r isa name; $r "John";
      delete
        $r isa heffalump;
      """



  Scenario: deleting a relation instance using a too-specific (downcasting) type throws
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      special-friendship sub friendship;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $r ($x, $y) isa friendship;
      delete
        $r isa special-friendship;
      """



  ###############
  # ROLEPLAYERS #
  ###############

  #TODO: This is flaky
  @ignore
  Scenario: deleting a role player from a relation using its role keeps the relation and removes the role player from it
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $z isa person, has name "Carrie";
      $r (friend: $x, friend: $y, friend: $z) isa friendship,
         has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | z               | r         |
      | key:name:Alex | key:name:Bob | key:name:Carrie | key:ref:0 |
    Given transaction commits
    Given session opens transaction of type: write
    When graql delete
      """
      match
        $r (friend: $x, friend: $y, friend: $z) isa friendship;
        $x isa person, has name "Alex";
        $y isa person, has name "Bob";
        $z isa person, has name "Carrie";
      delete
        $r (friend: $x);
      """
    Then transaction commits

    When session opens transaction of type: write
    When get answers of graql match
      """
      match (friend: $x, friend: $y) isa friendship;
      """
    Then uniquely identify answer concepts
      | x               | y               |
      | key:name:Bob    | key:name:Carrie |
      | key:name:Carrie | key:name:Bob    |



  Scenario: deleting an instance removes it from all relations
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $z isa person, has name "Carrie";
      $r (friend: $x, friend: $y) isa friendship, has ref 1;
      $r2 (friend: $x, friend: $z) isa friendship, has ref 2;
      """
    Then uniquely identify answer concepts
      | x             | y            | z               | r         | r2        |
      | key:name:Alex | key:name:Bob | key:name:Carrie | key:ref:1 | key:ref:2 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person, has name "Alex";
      delete
        $x isa person;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then uniquely identify answer concepts
      | x               |
      | key:name:Bob    |
      | key:name:Carrie |
    When get answers of graql match
      """
      match $r (friend: $x) isa friendship;
      """
    Then uniquely identify answer concepts
      | r         | x               |
      | key:ref:1 | key:name:Bob    |
      | key:ref:2 | key:name:Carrie |


  Scenario: repeated role players can be deleted from a relation
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         |
      | key:name:Alex | key:name:Bob | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $r (friend: $x, friend: $x) isa friendship;
      delete
        $r (friend: $x, friend: $x);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $r (friend: $x) isa friendship;
      """
    Then uniquely identify answer concepts
      | r         | x            |
      | key:ref:0 | key:name:Bob |


  Scenario: when deleting multiple repeated role players from a relation, it removes the number you asked to delete
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $x, friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         |
      | key:name:Alex | key:name:Bob | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $r (friend: $x, friend: $x, friend: $x) isa friendship;
      delete
        $r (friend: $x, friend: $x);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $r (friend: $x, friend: $y) isa friendship;
      """
    Then uniquely identify answer concepts
      | r         | x             | y             |
      | key:ref:0 | key:name:Bob  | key:name:Alex |
      | key:ref:0 | key:name:Alex | key:name:Bob  |


  Scenario: when deleting repeated role players in multiple statements, it removes the total number you asked to delete
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $x, friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         |
      | key:name:Alex | key:name:Bob | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person;
        $r (friend: $x, friend: $x, friend: $x) isa friendship;
      delete
        $r (friend: $x, friend: $x);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $r (friend: $x, friend: $y) isa friendship;
      """
    Then uniquely identify answer concepts
      | r         | x             | y             |
      | key:ref:0 | key:name:Bob  | key:name:Alex |
      | key:ref:0 | key:name:Alex | key:name:Bob  |


  Scenario: when deleting one of the repeated role players from a relation, only one duplicate is removed
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         |
      | key:name:Alex | key:name:Bob | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $r (friend: $x) isa friendship;
        $x isa person, has name "Alex";
      delete
        $r (friend: $x);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $r (friend: $x, friend: $y) isa friendship;
      """
    Then uniquely identify answer concepts
      | r         | x             | y             |
      | key:ref:0 | key:name:Bob  | key:name:Alex |
      | key:ref:0 | key:name:Alex | key:name:Bob  |

  @ignore
  Scenario: deleting role players in multiple statements throws
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $z isa person, has name "Carrie";
      $r (friend: $x, friend: $y, friend: $z) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | z               | r         |
      | key:name:Alex | key:name:Bob | key:name:Carrie | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete; throws exception
      """
      match
        $r (friend: $x, friend: $y, friend: $z) isa friendship;
        $x isa person, has name "Alex";
        $y isa person, has name "Bob";
        $z isa person, has name "Carrie";
      delete
        $r (friend: $x);
        $r (friend: $y);
      """

  Scenario: when deleting more role players than actually exist, an error is thrown
    Given graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $x isa person, has name "Alex";
        $y isa person, has name "Bob";
        $r (friend: $x, friend: $y) isa friendship;
      delete
        $r (friend: $x, friend: $x);
      """



  Scenario: when all instances that play roles in a relation are deleted, the relation instance gets cleaned up
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         |
      | key:name:Alex | key:name:Bob | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person, has name "Alex";
        $y isa person, has name "Bob";
      delete
        $x isa person;
        $y isa person;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $r isa friendship;
      """
    Then answer size is: 0


  Scenario: when the last role player is disassociated from a relation instance, the relation instance gets cleaned up
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then uniquely identify answer concepts
      | x             | y            | r         |
      | key:name:Alex | key:name:Bob | key:ref:0 |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person, has name "Alex";
        $y isa person, has name "Bob";
        $r ($x, $y) isa friendship;
      delete
        $r (friend: $x, friend: $y);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $r isa friendship;
      """
    Then answer size is: 0


  Scenario: deleting a role player with a too-specific (downcasting) role throws
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      special-friendship sub friendship,
        relates special-friend as friend;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    When graql insert
      """
      insert
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Then transaction commits

    When session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $x isa person, has name "Alex";
        $y isa person, has name "Bob";
        $r (friend: $x, friend: $y) isa friendship;
      delete
        $r (special-friend: $x);
      """



#  Even when a $role variable matches multiple roles (will always match 'role' unless constrained)
#  We only delete role player edges until the 'match' is no longer satisfied
#
#  For example
#
#  match $r ($role1: $x, director: $y) isa directed-by; // concrete instance matches: $r (production: $x, director: $y) isa directed-by;
#  delete $r ($role1: $x)
#
#  We will match '$role1' = ROLE meta type. Using this first answer we will remove $x from $r via the 'production role'.
#  This means the match clause is no longer satisfiable, and should throw the next (identical, up to role type) answer that is matched.
#
#  So, if the user does not specify a specific-enough roles, we may throw.
  Scenario: deleting a role player with a variable role throws if the role selector has multiple distinct matches
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      ship-crew sub relation, relates captain, relates navigator, relates chef;
      person plays ship-crew:captain, plays ship-crew:navigator, plays ship-crew:chef;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Cook";
      $y isa person, has name "Drake";
      $z isa person, has name "Joshua";
      $r (captain: $x, navigator: $y, chef: $z) isa ship-crew;
      """
    Then transaction commits

    When session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $r ($role1: $x, captain: $y) isa ship-crew;
      delete
        $r ($role1: $x);
      """



#  Even when a $role variable matches multiple roles (will always match 'role' unless constrained)
#  We only delete role player edges until the 'match' is no longer satisfied.
#
#  **Sometimes this means multiple repeated role players will be unassigned **
#
#  For example
#
#  // concrete instance:  $r (production: $x, production: $x, production: $x, director: $y) isa directed-by;
#  match $r ($role1: $x, director: $y) isa directed-by; $type sub work;
#  delete $r ($role1: $x);
#
#  First, we will match '$role1' = ROLE meta role. Using this answer we will remove a single $x from $r via the 'production'.
#  Next, we will match '$role1' = WORK role, and we delete another 'production' player. This repeats again for $role='production'.

# TODO: This behaviour was possible in 1.8 but is not implemented yet in 2.0, reimplement when type variables are allowed in insert and delete again
  @ignore
  Scenario: when deleting repeated role players with a single variable role, both repetitions are removed
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      ship-crew sub relation, relates captain, relates navigator, relates chef, owns ref @key;
      person plays ship-crew:captain, plays ship-crew:navigator, plays ship-crew:chef;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Cook";
      $y isa person, has name "Joshua";
      $r (captain: $x, chef: $y, chef: $y) isa ship-crew, has ref 0;
      """
    Given transaction commits

    When session opens transaction of type: write
    When get answers of graql match
      """
      match $rel (chef: $p) isa ship-crew;
      """
    Then uniquely identify answer concepts
      | rel       | p               |
      | key:ref:0 | key:name:Joshua |
    When graql delete
      """
      match
        $r ($role1: $x, captain: $y) isa ship-crew;
      delete
        $r ($role1: $x);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $rel (chef: $p) isa ship-crew;
      """
    Then answer size is: 0


  ########################
  # ATTRIBUTE OWNERSHIPS #
  ########################

  Scenario: deleting an attribute instance also deletes its ownerships
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      age sub attribute, value long;
      person owns age;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Anna", has age 18;
      """
    Given transaction commits

    When session opens transaction of type: write
    When get answers of graql match
      """
      match $x has age 18;
      """
    Then uniquely identify answer concepts
      | x             |
      | key:name:Anna |
    When graql delete
      """
      match
        $x 18 isa age;
      delete
        $x isa attribute;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x has age 18;
      """
    Then answer size is: 0


  Scenario: attempting to delete an attribute ownership with a derived isa throws
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      lastname sub attribute, value string;
      person sub entity, owns lastname;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given get answers of graql insert
      """
      insert
      $x isa person,
        has lastname "Smith",
        has name "Alex";
      $y isa person,
        has lastname "Smith",
        has name "John";
      """
    Then uniquely identify answer concepts
      | x             | y             |
      | key:name:Alex | key:name:John |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete; throws exception
      """
      match
        $x isa person, has lastname $n, has name "Alex";
        $n "Smith";
      delete
        $x has lastname $n;
      """

  Scenario: deleting an attribute ownership using 'thing' as a label throws an error
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      address sub attribute, value string, abstract;
      postcode sub address;
      person owns postcode;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Sherlock", has postcode "W1U8ED";
      """
    Given transaction commits

    When session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $x isa person, has address $a;
      delete
        $x has thing $a;
      """



  Scenario: an attribute can be specified by direct type when deleting an ownership of it
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Watson";
      """
    Then uniquely identify answer concepts
      | x               |
      | key:name:Watson |
    Given transaction commits
    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person;
      delete
        $x isa! person;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then answer size is: 0


  Scenario: deleting an attribute ownership throws an error when the incorrect direct type is specified
    Given graql insert
      """
      insert
      $x isa person, has name "Watson";
      """
    Then transaction commits

    When session opens transaction of type: write
    Then graql delete; throws exception
      """
      match
        $x isa person;
      delete
        $x isa! entity;
      """



  Scenario: deleting the owner of an attribute also deletes the attribute ownership
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      duration sub attribute, value long;
      friendship owns duration;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Tom";
      $y isa person, has name "Jerry";
      $r (friend: $x, friend: $y) isa friendship, has ref 0, has duration 1000;
      """
    Given transaction commits

    Given session opens transaction of type: write
    When get answers of graql match
      """
      match $x has duration $d;
      """
    Then uniquely identify answer concepts
      | x         | d                   |
      | key:ref:0 | value:duration:1000 |
    When graql delete
      """
      match
        $r isa friendship;
      delete
        $r isa relation;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x has duration $d;
      """
    Then answer size is: 0


  Scenario: deleting the last roleplayer in a relation deletes both the relation and its attribute ownerships
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      duration sub attribute, value long;
      friendship owns duration;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Emma";
      $r (friend: $x) isa friendship, has ref 0, has duration 1000;
      """
    Given transaction commits

    When session opens transaction of type: write
    When get answers of graql match
      """
      match $x has duration $d;
      """
    Then uniquely identify answer concepts
      | x         | d                   |
      | key:ref:0 | value:duration:1000 |
    When graql delete
      """
      match
        $r (friend: $x) isa friendship;
      delete
        $r (friend: $x);
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x has duration $d;
      """
    Then answer size is: 0
    When get answers of graql match
      """
      match $r isa friendship;
      """
    Then answer size is: 0


  Scenario: an error is thrown when deleting the ownership of a non-existent attribute
    Then graql delete; throws exception
      """
      match
        $x has diameter $val;
      delete
        $x has diameter $val;
      """


  ####################
  # COMPLEX PATTERNS #
  ####################

  Scenario: deletion of a complex pattern
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      lastname sub attribute, value string;
      person sub entity, owns lastname;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person,
        has lastname "Smith",
        has name "Alex";
      $y isa person,
        has lastname "Smith",
        has name "John";
      $r (friend: $x, friend: $y) isa friendship, has ref 1;
      $r1 (friend: $x, friend: $y) isa friendship, has ref 2;
      $reflexive (friend: $x, friend: $x) isa friendship, has ref 3;
      """
    Given transaction commits

    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person, has name "Alex", has lastname $n;
        $y isa person, has name "John", has lastname $n;
        $refl (friend: $x, friend: $x) isa friendship, has ref 3;
        $f1 (friend: $x, friend: $y) isa friendship, has ref 1;
      delete
        $x has $n;
        $refl (friend: $x);
        $f1 isa friendship;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $f (friend: $x) isa friendship;
      """
    Then uniquely identify answer concepts
      | f           | x             |
      | key:ref:2   | key:name:Alex |
      | key:ref:2   | key:name:John |
      | key:ref:3   | key:name:Alex |
    When get answers of graql match
      """
      match $n isa name;
      """
    Then uniquely identify answer concepts
      | n               |
      | value:name:John |
      | value:name:Alex |
    When get answers of graql match
      """
      match $x isa person, has lastname $n;
      """
    Then uniquely identify answer concepts
      | x             | n                    |
      | key:name:John | value:lastname:Smith |


  Scenario: deleting everything in a complex pattern
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      lastname sub attribute, value string;
      person sub entity, owns lastname;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person,
        has lastname "Smith",
        has name "Alex";
      $y isa person,
        has lastname "Smith",
        has name "John";
      $r (friend: $x, friend: $y) isa friendship, has ref 1;
      $r1 (friend: $x, friend: $y) isa friendship, has ref 2;
      $reflexive (friend: $x, friend: $x) isa friendship, has ref 3;
      """
    Given transaction commits

    When session opens transaction of type: write
    When graql delete
      """
      match
        $x isa person, has name "Alex", has lastname $n;
        $y isa person, has name "John", has lastname $n;
        $refl (friend: $x, friend: $x) isa friendship, has ref $r1; $r1 3;
        $f1 (friend: $x, friend: $y) isa friendship, has ref $r2; $r2 1;
      delete
        $x isa person, has $n;
        $y isa person, has $n;
        $refl (friend: $x, friend: $x) isa friendship, has $r1;
        $f1 (friend: $x, friend: $y) isa friendship, has $r2;
      """
    Then transaction commits

    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person, has lastname $n;
      """
    Then answer size is: 0


  ##############
  # EDGE CASES #
  ##############

  Scenario: deleting a variable not in the query throws, even if there were no matches
    Then graql delete; throws exception
      """
      match $x isa person; delete $n isa name;
      """



  Scenario: deleting a has ownership @key throws on commit
    Given graql insert
      """
      insert
      $x isa person, has name "Alex";
      """
    Given transaction commits

    When session opens transaction of type: write
    Then graql delete
      """
      match
        $x isa person, has name $n;
        $n "Alex";
      delete
        $x has $n;
      """
    Then transaction commits; throws exception

  @ignore
  Scenario: deleting an attribute instance that is owned as a has throws @key an error
    Given graql insert
      """
      insert
      $x isa person, has name "Tatyana";
      """
    Given transaction commits

    When session opens transaction of type: write
    When get answers of graql match
      """
      match $x isa name;
      """
    Then uniquely identify answer concepts
      | x                  |
      | value:name:Tatyana |
    Then graql delete; throws exception
      """
      match
        $x "Tatyana" isa name;
      delete
        $x isa attribute;
      """



  Scenario: deleting a type throws an error
    Then graql delete; throws exception
      """
      match
        $x type person;
      delete
        $x isa thing;
      """

