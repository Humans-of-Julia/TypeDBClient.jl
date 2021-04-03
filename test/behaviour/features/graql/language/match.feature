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
Feature: Graql Match Query

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
        plays employment:employee,
        owns name,
        owns age,
        owns ref @key;
      company sub entity,
        plays employment:employer,
        owns name,
        owns ref @key;
      friendship sub relation,
        relates friend,
        owns ref @key;
      employment sub relation,
        relates employee,
        relates employer,
        owns ref @key;
      name sub attribute, value string;
      age sub attribute, value long;
      ref sub attribute, value long;
      """
    Given transaction commits

    Given session opens transaction of type: write


  ##################
  # SCHEMA QUERIES #
  ##################

  Scenario: 'type' matches only the specified type, and does not match subtypes
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x type person;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: 'sub' can be used to match the specified type and all its subtypes, including indirect subtypes
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub person;
      """
    Then uniquely identify answer concepts
      | x                  |
      | label:person       |
      | label:writer       |
      | label:scifi-writer |


  Scenario: 'sub' can be used to match the specified type and all its supertypes, including indirect supertypes
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match writer sub $x;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:writer |
      | label:person |
      | label:entity |
      | label:thing  |


  Scenario: 'sub' can be used to retrieve all instances of types that are subtypes of a given type
    Given graql define
      """
      define

      child sub person;
      worker sub person;
      retired-person sub person;
      construction-worker sub worker;
      bricklayer sub construction-worker;
      crane-driver sub construction-worker;
      telecoms-worker sub worker;
      mobile-network-researcher sub telecoms-worker;
      smartphone-designer sub telecoms-worker;
      telecoms-business-strategist sub telecoms-worker;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $a isa child, has name "Alfred", has ref 0;
      $b isa retired-person, has name "Barbara", has ref 1;
      $c isa bricklayer, has name "Charles", has ref 2;
      $d isa crane-driver, has name "Debbie", has ref 3;
      $e isa mobile-network-researcher, has name "Edmund", has ref 4;
      $f isa telecoms-business-strategist, has name "Felicia", has ref 5;
      $g isa worker, has name "Gary", has ref 6;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa $type;
        $type sub worker;
      """
    # Alfred and Barbara are not retrieved, as they aren't subtypes of worker
    Then uniquely identify answer concepts
      | x         | type                               |
      | key:ref:2 | label:bricklayer                   |
      | key:ref:2 | label:construction-worker          |
      | key:ref:2 | label:worker                       |
      | key:ref:3 | label:crane-driver                 |
      | key:ref:3 | label:construction-worker          |
      | key:ref:3 | label:worker                       |
      | key:ref:4 | label:mobile-network-researcher    |
      | key:ref:4 | label:telecoms-worker              |
      | key:ref:4 | label:worker                       |
      | key:ref:5 | label:telecoms-business-strategist |
      | key:ref:5 | label:telecoms-worker              |
      | key:ref:5 | label:worker                       |
      | key:ref:6 | label:worker                       |


  Scenario: 'sub!' matches the type's direct subtypes
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      musician sub person;
      flutist sub musician;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x sub! person;
      """
    Then uniquely identify answer concepts
      | x              |
      | label:writer   |
      | label:musician |


  Scenario: 'sub!' can be used to match a type's direct supertype
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match writer sub! $x;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  @ignore
  # TODO this does not work on types anymore - types cannot be specified by IID
  Scenario: subtype hierarchy satisfies transitive sub assertions
    Given graql define
      """
      define
      sub1 sub entity;
      sub2 sub sub1;
      sub3 sub sub1;
      sub4 sub sub2;
      sub5 sub sub4;
      sub6 sub sub5;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x sub $y;
        $y sub $z;
        $z sub sub1;
      """
    Then each answer satisfies
      """
      match $x sub $z; $x iid <answer.x.iid>; $z iid <answer.z.iid>;
      """


  Scenario: 'owns' matches types that own the specified attribute type
    When get answers of graql match
      """
      match $x owns age;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: 'owns' can match types that can own themselves
    Given graql define
      """
      define
      unit sub attribute, value string, owns unit;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns $x;
      """
    Then uniquely identify answer concepts
      | x          |
      | label:unit |


  Scenario: 'owns' does not match types that own only a subtype of the specified attribute type
    Given graql define
      """
      define
      name abstract;
      club-name sub name;
      club sub entity, owns club-name;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns name;
      """
    Then uniquely identify answer concepts
      | x             |
      | label:person  |
      | label:company |


  Scenario: 'owns' does not match types that own only a supertype of the specified attribute type
    Given graql define
      """
      define
      name abstract;
      club-name sub name;
      club sub entity, owns club-name;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns club-name;
      """
    Then uniquely identify answer concepts
      | x          |
      | label:club |


  Scenario: 'owns' can be used to match attribute types that a given type owns
    When get answers of graql match
      """
      match person owns $x;
      """
    Then uniquely identify answer concepts
      | x          |
      | label:name |
      | label:age  |
      | label:ref  |


  Scenario: 'owns' can be used to retrieve all instances of types that can own a given attribute type
    Given graql define
      """
      define
      employment owns name;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $y isa company, has ref 1;
      $z (friend: $x) isa friendship, has ref 2;
      $w (employee: $x, employer: $y) isa employment, has ref 3;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa $type;
        $type owns name;
      """
    # friendship and ref should not be retrieved, as they can't have a name
    Then uniquely identify answer concepts
      | x         | type             |
      | key:ref:0 | label:person     |
      | key:ref:1 | label:company    |
      | key:ref:3 | label:employment |


  Scenario: 'plays' matches types that can play the specified role
    When get answers of graql match
      """
      match $x plays friendship:friend;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: 'plays' does not match types that only play a subrole of the specified role
    Given graql define
      """
      define
      close-friendship sub friendship, relates close-friend as friend;
      friendly-person sub entity, plays close-friendship:close-friend;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x plays friendship:friend;
      """
    Then uniquely identify answer concepts
      | x            |
      | label:person |


  Scenario: 'plays' does not match types that only play a super-role of the specified role
    Given graql define
      """
      define
      close-friendship sub friendship, relates close-friend as friend;
      friendly-person sub entity, plays close-friendship:close-friend;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x plays close-friendship:close-friend;
      """
    Then uniquely identify answer concepts
      | x                     |
      | label:friendly-person |


  Scenario: 'plays' can be used to match roles that a particular type can play
    When get answers of graql match
      """
      match person plays $x;
      """
    Then uniquely identify answer concepts
      | x                         |
      | label:friendship:friend   |
      | label:employment:employee |


  Scenario: 'plays' can be used to retrieve all instances of types that can play a specific role
    Given graql define
      """
      define
      dog sub entity,
        plays friendship:friend,
        owns ref @key;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $y isa company, has ref 1;
      $z isa dog, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa $type;
        $type plays friendship:friend;
      """
    Then uniquely identify answer concepts
      | x         | type         |
      | key:ref:0 | label:person |
      | key:ref:2 | label:dog    |


  Scenario: 'owns @key' matches types that own the specified attribute type as a key
    Given graql define
      """
      define
      breed sub attribute, value string;
      dog sub entity, owns breed @key;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns breed @key;
      """
    Then uniquely identify answer concepts
      | x         |
      | label:dog |


  Scenario: 'key' can be used to find all attribute types that a given type owns as a key
    When get answers of graql match
      """
      match person owns $x @key;
      """
    Then uniquely identify answer concepts
      | x         |
      | label:ref |


  Scenario: 'owns' without '@key' matches all types that own the specified attribute type, even if they use it as a key
    Given graql define
      """
      define
      breed sub attribute, value string;
      dog sub entity, owns breed @key;
      cat sub entity, owns breed;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x owns breed;
      """
    Then uniquely identify answer concepts
      | x         |
      | label:dog |
      | label:cat |


  Scenario: 'relates' matches relation types where the specified role can be played
    When get answers of graql match
      """
      match $x relates employee;
      """
    Then uniquely identify answer concepts
      | x                |
      | label:employment |

  # TODO cannot currently query for schema with 'as'
  @ignore
  Scenario: 'relates' with 'as' matches relation types that override the specified roleplayer
    Given graql define
      """
      define
      close-friendship sub friendship, relates close-friend as friend;
      friendly-person sub entity, plays close-friendship:close-friend;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x relates close-friend as friend;
      """
    Then uniquely identify answer concepts
      | x                      |
      | label:close-friendship |


  Scenario: 'relates' without 'as' does not match relation types that override the specified roleplayer
    Given graql define
      """
      define
      close-friendship sub friendship, relates close-friend as friend;
      friendly-person sub entity, plays close-friendship:close-friend;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x relates friend;
      """
    Then uniquely identify answer concepts
      | x                |
      | label:friendship |


  Scenario: 'relates' can be used to retrieve all the roles of a relation type
    When get answers of graql match
      """
      match employment relates $x;
      """
    Then uniquely identify answer concepts
      | x                         |
      | label:employment:employee |
      | label:employment:employer |


  # TODO we can't test like this because the IID is not a valid encoded IID -- need to rethink this test
  @ignore
  Scenario: when matching by a concept iid that doesn't exist, an empty result is returned
    When get answers of graql match
      """
      match
        $x iid 0x83cb2;
        $y iid 0x4ba92;
      """
    Then answer size is: 0


  ##########
  # THINGS #
  ##########

  Scenario: 'isa' gets any thing for any type
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $_ isa person, has ref 0;
      $_ isa person, has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa $y;
      """
    Then uniquely identify answer concepts
      | x           | y               |
      | key:ref:0   | label:person    |
      | key:ref:0   | label:entity    |
      | key:ref:0   | label:thing     |
      | key:ref:1   | label:person    |
      | key:ref:1   | label:entity    |
      | key:ref:1   | label:thing     |
      | value:ref:0 | label:ref       |
      | value:ref:0 | label:attribute |
      | value:ref:0 | label:thing     |
      | value:ref:1 | label:ref       |
      | value:ref:1 | label:attribute |
      | value:ref:1 | label:thing     |

  Scenario: 'isa' matches things of the specified type and all its subtypes
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      good-scifi-writer sub scifi-writer;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $y isa writer, has ref 1;
      $z isa scifi-writer, has ref 2;
      $w isa good-scifi-writer, has ref 3;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa writer;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:1 |
      | key:ref:2 |
      | key:ref:3 |


  Scenario: 'isa!' only matches things of the specified type, and does not match subtypes
    Given graql define
      """
      define
      writer sub person;
      scifi-writer sub writer;
      good-scifi-writer sub scifi-writer;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $y isa writer, has ref 1;
      $z isa scifi-writer, has ref 2;
      $w isa good-scifi-writer, has ref 3;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa! writer;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:1 |


  Scenario: 'iid' matches the instance with the specified internal iid
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person;
      """
    Then each answer satisfies
      """
      match $x iid <answer.x.iid>;
      """


  Scenario: match returns an empty answer if there are no matches
    When get answers of graql match
      """
      match $x isa person, has name "Anonymous Coward";
      """
    Then answer size is: 0


  Scenario: when matching by a type whose label doesn't exist, an error is thrown
    Then graql match; throws exception
      """
      match $x isa ganesh;
      """
    Then session transaction is open: false



  Scenario: when matching by a relation type whose label doesn't exist, an error is thrown
    Then graql match; throws exception
      """
      match ($x, $y) isa $type; $type type jakas-relacja;
      """
    Then session transaction is open: false



  Scenario: when matching a non-existent type label to a variable from a generic 'isa' query, an error is thrown
    Then graql match; throws exception
      """
      match $x isa $type; $type type polok;
      """
    Then session transaction is open: false



  Scenario: when one entity exists, and we match two variables both of that entity type, the entity is returned
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa person;
        $y isa person;
      """
    Then uniquely identify answer concepts
      | x         | y         |
      | key:ref:0 | key:ref:0 |


  Scenario: an error is thrown when matching that a variable has a specific type, when that type is in fact a role type
    Then graql match; throws exception
      """
      match $x isa friendship:friend;
      """


  # TODO we can't query for rule anymore
  @ignore
  Scenario: an error is thrown when matching that a variable has a specific type, when that type is in fact a rule
    Given graql define
      """
      define
      rule metre-rule:
      when {
        $x isa person;
      } then {
        $x has name "metre";
      };
      """
    Given transaction commits

    Given session opens transaction of type: read
    Then graql match; throws exception
      """
      match $x isa metre-rule;
      """
    Then session transaction is open: false



  #############
  # RELATIONS #
  #############

  Scenario: a relation is matchable from role players without specifying relation type
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $y isa company, has ref 1;
      $r (employee: $x, employer: $y) isa employment,
         has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    Then get answers of graql match
      """
      match $x isa person; $r (employee: $x) isa relation;
      """
    Then uniquely identify answer concepts
      | x         | r         |
      | key:ref:0 | key:ref:2 |
    When get answers of graql match
      """
      match $y isa company; $r (employer: $y) isa relation;
      """
    Then uniquely identify answer concepts
      | y         | r         |
      | key:ref:1 | key:ref:2 |


  Scenario: relations are matchable from roleplayers without specifying any roles
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $y isa company, has ref 1;
      $r (employee: $x, employer: $y) isa employment,
         has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person; $r ($x) isa relation;
      """
    Then uniquely identify answer concepts
      | x         | r         |
      | key:ref:0 | key:ref:2 |


  Scenario: all combinations of players in a relation can be retrieved
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    When graql insert
      """
      insert $p isa person, has ref 0;
      $c isa company, has ref 1;
      $c2 isa company, has ref 2;
      $r (employee: $p, employer: $c, employer: $c2) isa employment, has ref 3;
      """
    Given transaction commits

    Given session opens transaction of type: read
    Then get answers of graql match
      """
      match $r ($x, $y) isa employment;
      """
    Then uniquely identify answer concepts
      | x         | y         | r         |
      | key:ref:0 | key:ref:1 | key:ref:3 |
      | key:ref:1 | key:ref:0 | key:ref:3 |
      | key:ref:0 | key:ref:2 | key:ref:3 |
      | key:ref:2 | key:ref:0 | key:ref:3 |
      | key:ref:1 | key:ref:2 | key:ref:3 |
      | key:ref:2 | key:ref:1 | key:ref:3 |


  Scenario: repeated role players are retrieved singly when queried doubly
    Given graql define
      """
      define
      some-entity sub entity, plays symmetric:player, owns ref @key;
      symmetric sub relation, relates player, owns ref @key;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa some-entity, has ref 0; (player: $x, player: $x) isa symmetric, has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $r (player: $x, player: $x) isa relation;
      """
    Then uniquely identify answer concepts
      | x         | r         |
      | key:ref:0 | key:ref:1 |


  Scenario: repeated role players are retrieved singly when queried singly
    Given graql define
      """
      define
      some-entity sub entity, plays symmetric:player, owns ref @key;
      symmetric sub relation, relates player, owns ref @key;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa some-entity, has ref 0; (player: $x, player: $x) isa symmetric, has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $r (player: $x) isa relation;
      """
    Then uniquely identify answer concepts
      | x         | r         |
      | key:ref:0 | key:ref:1 |


  Scenario: a mixture of variable and explicit roles can retrieve relations
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa company, has ref 0;
      $y isa person, has ref 1;
      (employer: $x, employee: $y) isa employment, has ref 2;
      """
    Given transaction commits
    Given session opens transaction of type: read
    When get answers of graql match
      """
      match (employer: $e, $role: $x) isa employment;
      """
    Then uniquely identify answer concepts
      | e         | x         | role                      |
      | key:ref:0 | key:ref:1 | label:employment:employee |
      | key:ref:0 | key:ref:1 | label:relation:role       |


  Scenario: relations between distinct concepts are not retrieved when matching concepts that relate to themselves
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 1;
      $y isa person, has ref 2;
      (friend: $x, friend: $y) isa friendship, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match (friend: $x, friend: $x) isa friendship;
      """
    Then answer size is: 0


  Scenario: matching a chain of relations only returns answers if there is a chain of the required length
    Given graql define
      """
      define

      gift-delivery sub relation,
        relates sender,
        relates recipient;

      person plays gift-delivery:sender,
        plays gift-delivery:recipient;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x1 isa person, has name "Soroush", has ref 0;
      $x2a isa person, has name "Martha", has ref 1;
      $x2b isa person, has name "Patricia", has ref 2;
      $x2c isa person, has name "Lily", has ref 3;

      (sender: $x1, recipient: $x2a) isa gift-delivery;
      (sender: $x1, recipient: $x2b) isa gift-delivery;
      (sender: $x1, recipient: $x2c) isa gift-delivery;
      (sender: $x2a, recipient: $x2b) isa gift-delivery;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        (sender: $a, recipient: $b) isa gift-delivery;
        (sender: $b, recipient: $c) isa gift-delivery;
      """
    Then uniquely identify answer concepts
      | a         | b         | c         |
      | key:ref:0 | key:ref:1 | key:ref:2 |
    When get answers of graql match
      """
      match
        (sender: $a, recipient: $b) isa gift-delivery;
        (sender: $b, recipient: $c) isa gift-delivery;
        (sender: $c, recipient: $d) isa gift-delivery;
      """
    Then answer size is: 0


  Scenario: when multiple relation instances exist with the same roleplayer, matching that player returns just 1 answer
    Given graql define
      """
      define
      residency sub relation,
        relates resident,
        owns ref @key;
      person plays residency:resident;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has ref 0;
      $e (employee: $x) isa employment, has ref 1;
      $f (friend: $x) isa friendship, has ref 2;
      $r (resident: $x) isa residency, has ref 3;
      """
    Given transaction commits

    Given session opens transaction of type: read
    Given get answers of graql match
      """
      match $r isa relation;
      """
    Given uniquely identify answer concepts
      | r         |
      | key:ref:1 |
      | key:ref:2 |
      | key:ref:3 |
    When get answers of graql match
      """
      match ($x) isa relation;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
    When get answers of graql match
      """
      match ($x);
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |

  Scenario: an error is thrown when matching an entity type as if it were a role type
    Then graql match; throws exception
      """
      match (person: $x) isa relation;
      """
    Then session transaction is open: false


  Scenario: an error is thrown when matching an entity type as if it were a relation type
    Then graql match; throws exception
      """
      match ($x) isa person;
      """
    Then session transaction is open: false


  Scenario: an error is thrown when matching a non-existent type label as if it were a relation type
    Then graql match; throws exception
      """
      match ($x) isa bottle-of-rum;
      """
    Then session transaction is open: false


  Scenario: when matching a role type that doesn't exist, an error is thrown
    Then graql match; throws exception
      """
      match (rolein-rolein-rolein: $rolein) isa relation;
      """
    Then session transaction is open: false


  Scenario: when matching a role in a relation type that doesn't have that role, an error is thrown
    Then graql match; throws exception
      """
      match (friend: $x) isa employment;
      """
    Then session transaction is open: false


  Scenario: when matching a roleplayer in a relation that can't actually play that role, an error is thrown
    When graql match; throws exception
      """
      match
      $x isa company;
      ($x) isa friendship;
      """
    Then session transaction is open: false


  Scenario: Relations can be queried with pairings of relation and role types that are not directly related to each other
    Given graql define
      """
      define
      person plays marriage:spouse, plays hetero-marriage:husband, plays hetero-marriage:wife;
      marriage sub relation, relates spouse;
      hetero-marriage sub marriage, relates husband as spouse, relates wife as spouse;
      civil-marriage sub marriage;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $a isa person, has ref 1;
      $b isa person, has ref 2;
      (wife: $a, husband: $b) isa hetero-marriage;
      (spouse: $a, spouse: $b) isa civil-marriage;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $m (wife: $x, husband: $y) isa hetero-marriage;
      """
    Then answer size is: 1
    Then graql match; throws exception
      """
      match $m (wife: $x, husband: $y) isa civil-marriage;
      """
    Then session transaction is open: false
    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $m (wife: $x, husband: $y) isa marriage;
      """
    Then answer size is: 1
    When get answers of graql match
      """
      match $m (wife: $x, husband: $y) isa relation;
      """
    Then answer size is: 1
    When get answers of graql match
      """
      match $m (spouse: $x, spouse: $y) isa hetero-marriage;
      """
    Then answer size is: 2
    When get answers of graql match
      """
      match $m (spouse: $x, spouse: $y) isa civil-marriage;
      """
    Then answer size is: 2
    When get answers of graql match
      """
      match $m (spouse: $x, spouse: $y) isa marriage;
      """
    Then answer size is: 4
    When get answers of graql match
      """
      match $m (spouse: $x, spouse: $y) isa relation;
      """
    Then answer size is: 4
    When get answers of graql match
      """
      match $m (role: $x, role: $y) isa hetero-marriage;
      """
    Then answer size is: 2
    When get answers of graql match
      """
      match $m (role: $x, role: $y) isa civil-marriage;
      """
    Then answer size is: 2
    When get answers of graql match
      """
      match $m (role: $x, role: $y) isa marriage;
      """
    Then answer size is: 4
    When get answers of graql match
      """
      match $m (role: $x, role: $y) isa relation;
      """
    Then answer size is: 4


  ##############
  # ATTRIBUTES #
  ##############

  Scenario Outline: '<type>' attributes can be matched by value
    Given graql define
      """
      define <attr> sub attribute, value <type>, owns ref @key;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $n <value> isa <attr>, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $a <value>;
      """
    Then uniquely identify answer concepts
      | a         |
      | key:ref:0 |

    Examples:
      | attr        | type     | value      |
      | colour      | string   | "Green"    |
      | calories    | long     | 1761       |
      | grams       | double   | 9.6        |
      | gluten-free | boolean  | false      |
      | use-by-date | datetime | 2020-06-16 |


  Scenario Outline: when matching a '<type>' attribute by a value that doesn't exist, an empty answer is returned
    Given graql define
      """
      define <attr> sub attribute, value <type>, owns ref @key;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $a <value>;
      """
    Then answer size is: 0

    Examples:
      | attr        | type     | value      |
      | colour      | string   | "Green"    |
      | calories    | long     | 1761       |
      | grams       | double   | 9.6        |
      | gluten-free | boolean  | false      |
      | use-by-date | datetime | 2020-06-16 |


  Scenario: 'contains' matches strings that contain the specified substring
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x "Seven Databases in Seven Weeks" isa name;
      $y "Four Weddings and a Funeral" isa name;
      $z "Fun Facts about Space" isa name;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x contains "Fun";
      """
    Then uniquely identify answer concepts
      | x                                      |
      | value:name:Four Weddings and a Funeral |
      | value:name:Fun Facts about Space       |


  Scenario: 'contains' performs a case-insensitive match
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x "The Phantom of the Opera" isa name;
      $y "Pirates of the Caribbean" isa name;
      $z "Mr. Bean" isa name;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x contains "Bean";
      """
    Then uniquely identify answer concepts
      | x                                   |
      | value:name:Pirates of the Caribbean |
      | value:name:Mr. Bean                 |


  Scenario: 'like' matches strings that match the specified regex
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x "ABC123" isa name;
      $y "123456" isa name;
      $z "9" isa name;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x like "^[0-9]+$";
      """
    Then uniquely identify answer concepts
      | x                 |
      | value:name:123456 |
      | value:name:9      |


  # TODO we can't test like this because the IID is not a valid encoded IID -- need to rethink this test
  @ignore
  Scenario: when querying for a non-existent attribute type iid, an empty result is returned
    When get answers of graql match
      """
      match $x has name $y; $x iid 0x83cb2;
      """
    Then answer size is: 0
    When get answers of graql match
      """
      match $x has name $y; $y iid 0x83cb2;
      """
    Then answer size is: 0

  # TODO: this test uses attributes, but is ultimately testing the traversal structure,
  #       such that match query does not throw. Perhaps we should introduce a new feature file
  #       containing a new set of scenarios that test: traversal structure, plan and procedure
  Scenario: Traversal planner can handle "loops" in the traversal structure
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name 'alice', has ref 0;
      $y isa person, has name 'alice', has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
      $x isa person, has $n;
      $y isa person, has $n;
      """

  #######################
  # ATTRIBUTE OWNERSHIP #
  #######################

  Scenario: 'has' can be used to match things that own any instance of the specified attribute
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Leila", has ref 0;
      $y isa person, has ref 1;
      $c isa company, has name "Grakn", has ref 2;
      $d isa company, has ref 3;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has name $y; get $x;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
      | key:ref:2 |


  Scenario: using the 'attribute' meta label, 'has' can match things that own any attribute with a specified value
    Given graql define
      """
      define
      shoe-size sub attribute, value long;
      person owns shoe-size;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has age 9, has ref 0;
      $y isa person, has shoe-size 9, has ref 1;
      $z isa person, has age 12, has shoe-size 12, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has attribute 9;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
      | key:ref:1 |


  Scenario: when an attribute instance is fully specified, 'has' matches its owners
    Given graql define
      """
      define
      friendship owns age;
      graduation-date sub attribute, value datetime, owns age, owns ref @key;
      person owns graduation-date;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Zoe", has age 21, has graduation-date 2020-06-01, has ref 0;
      $y (friend: $x) isa friendship, has age 21, has ref 1;
      $z 2020-06-01 isa graduation-date, has age 21, has ref 2;
      $w isa person, has ref 3;
      $v (friend: $x, friend: $w) isa friendship, has age 7, has ref 4;
      $u 2019-06-03 isa graduation-date, has age 22, has ref 5;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has age 21;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
      | key:ref:1 |
      | key:ref:2 |


  Scenario: 'has' matches an attribute's owner even if it owns more attributes of the same type
    Given graql define
      """
      define
      lucky-number sub attribute, value long;
      person owns lucky-number;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has lucky-number 10, has lucky-number 20, has lucky-number 30, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has lucky-number 20;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |


  Scenario: 'has' can match instances that have themselves
    Given graql define
      """
      define
      unit sub attribute, value string, owns unit, owns ref;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x "meter" isa unit, has $x, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has $x;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |


  Scenario: an error is thrown when matching by attribute ownership, when the owned thing is actually an entity
    Then graql match; throws exception
      """
      match $x has person "Luke";
      """
    Then session transaction is open: false


  Scenario: exception is thrown when matching by an attribute ownership, if the owner can't actually own it
    Then graql match; throws exception
      """
      match $x isa company, has age $n;
      """
    Then session transaction is open: false


  Scenario: an error is thrown when matching by attribute ownership, when the owned type label doesn't exist
    Then graql match; throws exception
      """
      match $x has bananananananana "rama";
      """
    Then session transaction is open: false



  ##############################
  # ATTRIBUTE VALUE COMPARISON #
  ##############################

  Scenario: when things own attributes of different types but the same value, they match by equality
    Given graql define
      """
      define
      start-date sub attribute, value datetime;
      graduation-date sub attribute, value datetime;
      person owns graduation-date;
      employment owns start-date;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "James", has ref 0, has graduation-date 2009-07-16;
      $r (employee: $x) isa employment, has start-date 2009-07-16, has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    Then get answers of graql match
      """
      match
        $x isa person, has graduation-date $date;
        $r (employee: $x) isa employment, has start-date = $date;
      """
    Then answer size is: 1
    Then uniquely identify answer concepts
      | x         | r         | date                             |
      | key:ref:0 | key:ref:1 | value:graduation-date:2009-07-16 |


  Scenario: 'has $attr = $x' matches owners of any instance '$y' of '$attr' where '$y' and '$x' are equal by value
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Susie", has age 16, has ref 0;
      $y isa person, has name "Donald", has age 25, has ref 1;
      $z isa person, has name "Ralph", has age 18, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has age = 16;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |


  Scenario: 'has $attr > $x' matches owners of any instance '$y' of '$attr' where '$y > $x'
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Susie", has age 16, has ref 0;
      $y isa person, has name "Donald", has age 25, has ref 1;
      $z isa person, has name "Ralph", has age 18, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has age > 18;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:1 |


  Scenario: 'has $attr < $x' matches owners of any instance '$y' of '$attr' where '$y < $x'
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Susie", has age 16, has ref 0;
      $y isa person, has name "Donald", has age 25, has ref 1;
      $z isa person, has name "Ralph", has age 18, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has age < 18;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |


  Scenario: 'has $attr != $x' matches owners of any instance '$y' of '$attr' where '$y != $x'
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Susie", has age 16, has ref 0;
      $y isa person, has name "Donald", has age 25, has ref 1;
      $z isa person, has name "Ralph", has age 18, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has age != 18;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
      | key:ref:1 |


  Scenario: value comparisons can be performed between a 'double' and a 'long'
    Given graql define
      """
      define
      house-number sub attribute, value long;
      length sub attribute, value double;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x 1 isa house-number;
      $y 2.0 isa length;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa house-number;
        $x = 1.0;
      """
    Then answer size is: 1
    When get answers of graql match
      """
      match
        $x isa length;
        $x = 2;
      """
    Then answer size is: 1
    When get answers of graql match
      """
      match
        $x isa house-number;
        $x 1.0;
      """
    Then answer size is: 1
    When get answers of graql match
      """
      match
        $x isa length;
        $x 2;
      """
    Then answer size is: 1
    When get answers of graql match
      """
      match
        $x isa attribute;
        $x >= 1;
      """
    Then answer size is: 2
    When get answers of graql match
      """
      match
        $x isa attribute;
        $x < 2.0;
      """
    Then answer size is: 1


  Scenario: when a thing owns multiple attributes of the same type, a value comparison matches if any value matches
    Given graql define
      """
      define
      lucky-number sub attribute, value long;
      person owns lucky-number;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has lucky-number 10, has lucky-number 20, has lucky-number 30, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x has lucky-number > 25;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |


  Scenario: an attribute variable used in both '=' and '>=' predicates is correctly resolved
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Susie", has age 16, has ref 0;
      $y isa person, has name "Donald", has age 25, has ref 1;
      $z isa person, has name "Ralph", has age 18, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x has age = $z;
        $z >= 17;
        $z isa age;
      get $x;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:1 |
      | key:ref:2 |


  Scenario: when the answers of a value comparison include both a 'double' and a 'long', both answers are returned
    Given graql define
      """
      define
      length sub attribute, value double;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $a 24 isa age;
      $b 19 isa age;
      $c 20.9 isa length;
      $d 19.9 isa length;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa attribute;
        $x > 20;
      """
    Then uniquely identify answer concepts
      | x                 |
      | value:age:24      |
      | value:length:20.9 |


  Scenario: when one entity exists, and we match two variables with concept inequality, an empty answer is returned
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert $x isa person, has ref 0;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match
        $x isa person;
        $y isa person;
        not { $x is $y; };
      """
    Then answer size is: 0

  Scenario: concept comparison of unbound variables throws an error
    Then graql match; throws exception
      """
      match not { $x is $y; };
      """
    Then session transaction is open: false

  ############
  # PATTERNS #
  ############

  Scenario: disjunctions return the union of composing query statements
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Jeff", has ref 0;
      $y isa company, has name "Amazon", has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa $t; { $t type person; } or {$t type company;}; get $x;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
      | key:ref:1 |
    When get answers of graql match
      """
      match $x isa entity; {$x has name "Jeff";} or {$x has name "Amazon";};
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:0 |
      | key:ref:1 |


  Scenario: negations can be applied to filtered variables
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Jeff", has ref 0;
      $y isa person, has name "Jenny", has ref 1;
      """
    Given transaction commits

    Given session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person, has name $a; not { $a = "Jeff"; }; get $x;
      """
    Then uniquely identify answer concepts
      | x         |
      | key:ref:1 |

  ##################
  # VARIABLE TYPES #
  ##################

  Scenario: all instances and their types can be retrieved
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Bertie", has ref 0;
      $y isa person, has name "Angelina", has ref 1;
      $r (friend: $x, friend: $y) isa friendship, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    Given get answers of graql match
      """
      match $x isa entity;
      """
    Given answer size is: 2
    Given get answers of graql match
      """
      match $r isa relation;
      """
    Given answer size is: 1
    Given get answers of graql match
      """
      match $x isa attribute;
      """
    Given answer size is: 5
    When get answers of graql match
      """
      match $x isa $type;
      """
    # 2 entities x 3 types {person,entity,thing}
    # 1 relation x 3 types {friendship,relation,thing}
    # 5 attributes x 3 types {ref/name,attribute,thing}
    Then answer size is: 24


  Scenario: all relations and their types can be retrieved
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    Given graql insert
      """
      insert
      $x isa person, has name "Bertie", has ref 0;
      $y isa person, has name "Angelina", has ref 1;
      $r (friend: $x, friend: $y) isa friendship, has ref 2;
      """
    Given transaction commits

    Given session opens transaction of type: read
    Given get answers of graql match
      """
      match $r isa relation;
      """
    Given answer size is: 1
    Given get answers of graql match
      """
      match ($x, $y) isa relation;
      """
    # 2 permutations of the roleplayers
    Given answer size is: 2
    When get answers of graql match
      """
      match ($x, $y) isa $type;
      """
    # 2 permutations x 3 types {friendship,relation,thing}
    Then answer size is: 6


  #######################
  # NEGATION VALIDATION #
  #######################

  # Negation resolution is handled by Reasoner, but query validation is handled by the language.
  Scenario: when the entire match clause is a negation, an error is thrown
  At least one negated pattern variable must be bound outside the negation block, so this query is invalid.
    Then graql match; throws exception
      """
      match not { $x has attribute "value"; };
      """
    Then session transaction is open: false

  Scenario: when matching a negation whose pattern variables are all unbound outside it, an error is thrown
    Then graql match; throws exception
      """
      match
        $r isa entity;
        not {
          ($r2, $i);
          $i isa entity;
        };
      """
    Then session transaction is open: false

  Scenario: the first variable in a negation can be unbound, as long as it is connected to a bound variable
    Then get answers of graql match
      """
      match
        $r isa attribute;
        not {
          $x isa entity, has attribute $r;
        };
      """

  # TODO: We should verify the answers
  Scenario: negations can contain disjunctions
    Then get answers of graql match
      """
      match
        $x isa entity;
        not {
          { $x has attribute 1; } or { $x has attribute 2; };
        };
      """

  Scenario: when negating a negation redundantly, an error is thrown
    Then graql match; throws exception
      """
      match
        $x isa person, has name "Tim";
        not {
          not {
            $x has age 55;
          };
        };
      """
