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
Feature: Relation Inference Resolution

  Background: Set up databases for resolution testing
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: reasoned
    Given connection create database: materialised
    Given connection open schema sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql define
      """
      define

      person sub entity,
        owns name,
        plays friendship:friend,
        plays employment:employee;

      company sub entity,
        owns name,
        plays employment:employer;

      place sub entity,
        owns name,
        plays location-hierarchy:subordinate,
        plays location-hierarchy:superior;

      friendship sub relation,
        relates friend;

      employment sub relation,
        relates employee,
        relates employer;

      location-hierarchy sub relation,
        relates subordinate,
        relates superior;

      name sub attribute, value string;
      """
    Given for each session, transaction commits
    # each scenario specialises the schema further
    Given for each session, open transactions of type: write

  #######################
  # BASIC FUNCTIONALITY #
  #######################

  Scenario: a relation can be inferred on all concepts of a given type
    Given for each session, graql define
      """
      define
      dog sub entity;
      rule people-are-employed: when {
        $p isa person;
      } then {
        (employee: $p) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa person;
      $y isa dog;
      $z isa person;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $x isa person;
        ($x) isa employment;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then for each session, transaction closes
    Given for each session, open transactions of type: read


  Scenario: a relation can be inferred based on an attribute ownership
    Given for each session, graql define
      """
      define
      rule haikal-is-employed: when {
        $p isa person, has name "Haikal";
      } then {
        (employee: $p) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa person, has name "Haikal";
      $y isa person, has name "Michael";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $x has name "Haikal";
        ($x) isa employment;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $x has name "Michael";
        ($x) isa employment;
      """
    Then answer size in reasoned database is: 0
    Then materialised and reasoned databases are the same size


  Scenario: a rule can infer a relation with an attribute as a roleplayer
    Given for each session, graql define
      """
      define
      item sub entity, owns name, plays item-listing:item;
      price sub attribute, value double, plays item-listing:price;
      item-listing sub relation, relates item, relates price;
      rule nutella-price: when {
        $x isa item, has name "3kg jar of Nutella";
        $y 14.99 isa price;
      } then {
        (item: $x, price: $y) isa item-listing;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa item, has name "3kg jar of Nutella";
      $y 14.99 isa price;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $r (item: $i, price: $p) isa item-listing;
        $i isa item, has name $n;
        $n "3kg jar of Nutella" isa name;
        $p 14.99 isa price;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size


  Scenario: a rule can infer a relation based on ownership of any instance of a specific attribute type
    Given for each session, graql define
      """
      define
      year sub attribute, value long, plays employment:favourite-year;
      employment relates favourite-year;
      rule kronenbourg-employs-anyone-with-a-name: when {
        $x isa company, has name "Kronenbourg";
        $p isa person, has name $n;
        $y 1664 isa year;
      } then {
        (employee: $p, employer: $x, favourite-year: $y) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa company, has name "Kronenbourg";
      $p isa person, has name "Ronald";
      $p2 isa person, has name "Prasanth";
      $y 1664 isa year;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $x 1664 isa year;
        ($x, employee: $p, employer: $y) isa employment;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then materialised and reasoned databases are the same size


  ###############
  # REFLEXIVITY #
  ###############

  # nth triangle number = sum of all integers from 1 to n, inclusive
  Scenario: when inferring relations on all pairs from n concepts, the number of relations is the nth triangle number
    Given for each session, graql define
      """
      define
      rule everyone-is-my-friend-including-myself: when {
        $x isa person;
        $y isa person;
      } then {
        (friend: $x, friend: $y) isa friendship;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $a isa person, has name "Abigail";
      $b isa person, has name "Bernadette";
      $c isa person, has name "Cliff";
      $d isa person, has name "Damien";
      $e isa person, has name "Eustace";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $r isa friendship;
      """
    Then all answers are correct in reasoned database
    # When there is 1 concept we have {aa}.
    # Adding a 2nd concept gives us 2 new relations - where each relation contains b, and one other concept (a or b).
    # Adding a 3rd concept gives us 3 new relations - where each relation contains c, and one other concept (a, b or c).
    # Generally, the total number of relations is the sum of all integers from 1 to n inclusive.
    Then answer size in reasoned database is: 15
    Then materialised and reasoned databases are the same size


  Scenario: when matching all possible pairs inferred from n concepts, the answer size is the square of n
    Given for each session, graql define
      """
      define
      rule everyone-is-my-friend-including-myself: when {
        $x isa person;
        $y isa person;
      } then {
        (friend: $x, friend: $y) isa friendship;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $a isa person, has name "Abigail";
      $b isa person, has name "Bernadette";
      $c isa person, has name "Cliff";
      $d isa person, has name "Damien";
      $e isa person, has name "Eustace";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match ($x, $y) isa friendship;
      """
    Then all answers are correct in reasoned database
    # Here there are n choices for x, and n choices for y, so the total answer size is n^2
    Then answer size in reasoned database is: 25
    Then materialised and reasoned databases are the same size


  Scenario: when a relation is reflexive, matching concepts are related to themselves
    Given for each session, graql define
      """
      define
      person plays employment:employer;
      rule self-employment: when {
        $x isa person;
      } then {
        (employee: $x, employer: $x) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $f isa person, has name "Ferhat";
      $g isa person, has name "Gawain";
      $h isa person, has name "Hattie";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (employee: $x, employer: $x) isa employment;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 3
    Then materialised and reasoned databases are the same size


  Scenario: inferred reflexive relations can be retrieved using multiple variables to refer to the same concept
    Given for each session, graql define
      """
      define
      person plays employment:employer;
      rule self-employment: when {
        $x isa person;
      } then {
        (employee: $x, employer: $x) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $i isa person, has name "Irma";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (employee: $x, employer: $y) isa employment;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size


  Scenario: inferred relations between distinct concepts are not retrieved when matching concepts related to themselves
    Given for each session, graql define
      """
      define
      person plays employment:employer;
      rule robert-employs-jane: when {
        $x isa person, has name "Robert";
        $y isa person, has name "Jane";
      } then {
        (employee: $y, employer: $x) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $r isa person, has name "Robert";
      $j isa person, has name "Jane";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (employee: $x, employer: $x) isa employment;
      """
    Then answer size in reasoned database is: 0
    Then materialised and reasoned databases are the same size


  ############
  # SYMMETRY #
  ############

  # TODO: re-enable all steps when resolvable (currently takes too long)
  Scenario: when a relation is symmetric, its symmetry can be used to make additional inferences
    Given for each session, graql define
      """
      define

      person plays coworkers:coworker,
          plays employment:employer,
          plays robot-pet-ownership:owner;

      robot sub entity,
          plays robot-pet-ownership:pet,
          plays coworkers:coworker,
          plays employment:employee,
          plays employment:employer,
          owns name;

      coworkers sub relation,
          relates coworker;

      robot-pet-ownership sub relation,
          relates pet,
          relates owner;

      rule people-work-with-themselves: when {
          $x isa person;
      } then {
          (coworker: $x, coworker: $x) isa coworkers;
      };

      rule robots-work-with-their-owners-coworkers: when {
          (pet: $c, owner: $m) isa robot-pet-ownership;
          (coworker: $m, coworker: $op) isa coworkers;
      } then {
          (coworker: $c, coworker: $op) isa coworkers;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $a isa robot, has name 'r1';
      $b isa person, has name 'p';
      $c isa robot, has name 'r2';
      (pet: $a, owner: $b) isa robot-pet-ownership;
      (coworker: $b, coworker: $c) isa coworkers;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (coworker: $x, coworker: $x) isa coworkers;
      """
    Then all answers are correct in reasoned database
    # (p,p) is a coworkers since people work with themselves.
    # Applying the robot work rule we see that (r1,p) is a pet ownership, and (p,p) and (p,r2) are coworker relations,
    # so (r1,p) and (r1,r2) are both coworker relations.
    # Coworker relations are symmetric, so (r2,p), (p,r1) and (r2,r1) are all coworker relations.
    # Applying the robot work rule a 2nd time, (r1,p) is a pet ownership and (p,r1) are coworkers,
    # therefore (r1,r1) is a reflexive coworker relation. So the answers are [p] and [r1].
    Then answer size in reasoned database is: 2
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (coworker: $x, coworker: $y) isa coworkers;
      """
    Then all answers are correct in reasoned database
    # $x | $y |
    # p  | p  |
    # p  | r2 |
    # r1 | p  |
    # r1 | r2 |
    # r2 | p  |
    # p  | r1 |
    # r2 | r1 |
    # r1 | r1 |
    Then answer size in reasoned database is: 8
    Then materialised and reasoned databases are the same size


  ################
  # TRANSITIVITY #
  ################

  Scenario: a transitive rule will not infer any new relations when there are only two related entities
    Given for each session, graql define
      """
      define
      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa place, has name "Delhi";
      $y isa place, has name "India";
      (subordinate: $x, superior: $x) isa location-hierarchy;
      (subordinate: $x, superior: $y) isa location-hierarchy;
      (subordinate: $y, superior: $y) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $x isa location-hierarchy;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 3
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when 3-hop transitivity is resolvable
  Scenario: when a query using transitivity has a limit exceeding the result size, answers are consistent between runs
    Given for each session, graql define
      """
      define
      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $a isa place, has name "University of Warsaw";
      $b isa place, has name "Warsaw";
      $c isa place, has name "Poland";
      $d isa place, has name "Europe";

      (subordinate: $a, superior: $b) isa location-hierarchy;
      (subordinate: $b, superior: $c) isa location-hierarchy;
      (subordinate: $c, superior: $d) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (subordinate: $x1, superior: $x2) isa location-hierarchy;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 6
    Then answers are consistent across 5 executions in reasoned database
    Then materialised and reasoned databases are the same size


  Scenario: when a transitive rule's 'then' matches a query, but its 'when' is unmet, the material answers are returned

  This test is included because internally, Reasoner uses backward chaining to answer queries, meaning it has to
  perform resolution steps even if the conditions of a rule are never met. In this case, 'transitive-location'
  is never triggered because there are no location-hierarchy pairs that satisfy both conditions.

    Given for each session, graql define
      """
      define

      planned-trip sub relation,
        relates source,
        relates destination;

      cycle-route sub relation,
        relates start,
        relates end;

      place plays planned-trip:source,
        plays planned-trip:destination,
        plays cycle-route:start,
        plays cycle-route:end;

      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x1 isa place, has name "Waterloo";
      $x2a isa place, has name "Embankment";
      $x2b isa place, has name "Southwark";
      $x2c isa place, has name "Victoria";
      $x3 isa place, has name "Tower Hill";
      $x4 isa place, has name "London";

      (start: $x1, end: $x2a) isa cycle-route;
      (start: $x1, end: $x2b) isa cycle-route;
      (start: $x1, end: $x2c) isa cycle-route;

      (source: $x2a, destination: $x3) isa planned-trip;
      (source: $x2b, destination: $x3) isa planned-trip;
      (source: $x2c, destination: $x3) isa planned-trip;

      (subordinate: $x3, superior: $x4) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (subordinate: $x, superior: $y) isa location-hierarchy;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size


  #######################
  # ROLEPLAYER MATCHING #
  #######################

  Scenario: an inferred relation with one player in a role is not retrieved when the role appears twice in a match query
    Given for each session, graql define
      """
      define
      rule employment-rule: when {
        $c isa company;
        $p isa person;
      } then {
        (employee: $p, employer: $c) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa person;
      $c isa company;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (employee: $x, employee: $y) isa employment;
      """
    Then answer size in reasoned database is: 0
    Then materialised and reasoned databases are the same size


  Scenario: a relation with two roleplayers inferred by the same rule is retrieved when matching only one of the roles
    Given for each session, graql define
      """
      define
      rule employment-rule: when {
        $c isa company;
        $p isa person;
      } then {
        (employee: $p, employer: $c) isa employment;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa person;
      $c isa company;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (employee: $x) isa employment;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size


  Scenario: when matching an inferred relation with repeated roles, answers contain all permutations of the roleplayers
    Given for each session, graql define
      """
      define
      rule alice-bob-and-charlie-are-friends: when {
        $a isa person, has name "Alice";
        $b isa person, has name "Bob";
        $c isa person, has name "Charlie";
      } then {
        (friend: $a, friend: $b, friend: $c) isa friendship;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa person, has name "Alice";
      $y isa person, has name "Bob";
      $z isa person, has name "Charlie";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (friend: $a, friend: $b, friend: $c) isa friendship;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 6
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $r (friend: $a, friend: $b, friend: $c) isa friendship;
      get $a, $b, $c;
      """
    Then materialised and reasoned databases are the same size


  Scenario: inferred relations can be filtered by shared attribute ownership
    Given for each session, graql define
      """
      define
      selection sub relation, relates choice1, relates choice2;
      person plays selection:choice1, plays selection:choice2;
      rule symmetric-selection: when {
        (choice1: $x, choice2: $y) isa selection;
      } then {
        (choice1: $y, choice2: $x) isa selection;
      };
      rule transitive-selection: when {
        (choice1: $x, choice2: $y) isa selection;
        (choice1: $y, choice2: $z) isa selection;
      } then {
        (choice1: $x, choice2: $z) isa selection;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa person, has name "a";
      $y isa person, has name "b";
      $z isa person, has name "c";

      (choice1: $x, choice2: $y) isa selection;
      (choice1: $y, choice2: $z) isa selection;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (choice1: $x, choice2: $y) isa selection;
        $x has name $n;
        $y has name $n;
      """
    Then all answers are correct in reasoned database
    # (a,a), (b,b), (c,c)
    Then answer size in reasoned database is: 3
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (choice1: $x, choice2: $y) isa selection;
        $x has name $n;
        $y has name $n;
        $n = 'a';
      get $x, $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        (choice1: $x, choice2: $y) isa selection;
        $x has name 'a';
        $y has name 'a';
      """
    Then materialised and reasoned databases are the same size


  #######################
  # UNTYPED MATCH QUERY #
  #######################

  # TODO: re-enable all steps when fixed (#75)
  Scenario: the relation type constraint can be excluded from a reasoned match query
    Given for each session, graql define
      """
      define
      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa place, has name "Turku Airport";
      $y isa place, has name "Turku";
      $z isa place, has name "Finland";

      (subordinate: $x, superior: $y) isa location-hierarchy;
      (subordinate: $y, superior: $z) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $a isa place, has name "Turku Airport";
        ($a, $b);
        $b isa place, has name "Turku";
        ($b, $c);
      """
    Then all answers are correct in reasoned database
    # $c in {'Turku Airport', 'Finland'}
    Then answer size in reasoned database is: 2
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when fixed (#75)
  Scenario: when the relation type is excluded in a reasoned match query, all valid roleplayer combinations are matches
    Given for each session, graql define
      """
      define
      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa place, has name "Turku Airport";
      $y isa place, has name "Turku";
      $z isa place, has name "Finland";

      (subordinate: $x, superior: $y) isa location-hierarchy;
      (subordinate: $y, superior: $z) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Given for graql query
      """
      match
        $a isa place, has name "Turku Airport";
        ($a, $b);
        $b isa place, has name "Turku";
      """
    Given all answers are correct in reasoned database
    Given answer size in reasoned database is: 1
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $a isa place, has name "Turku Airport";
        ($a, $b);
        $b isa place, has name "Turku";
        ($c, $d);
      """
    Then all answers are correct in reasoned database
    # (2 db relations + 1 inferred) x 2 for variable swap
    Then answer size in reasoned database is: 6
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when fixed (#75)
  Scenario: when the relation type is excluded in a reasoned match query, all types of relations match
    Given for each session, graql define
      """
      define

      loc-hie sub relation, relates loc-sub, relates loc-sup;

      place plays loc-hie:loc-sub, plays loc-hie:loc-sup;

      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };

      rule long-role-names-suck: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
      } then {
        (loc-sub: $x, loc-sup: $y) isa loc-hie;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa place, has name "Turku Airport";
      $y isa place, has name "Turku";
      $z isa place, has name "Finland";

      (subordinate: $x, superior: $y) isa location-hierarchy;
      (subordinate: $y, superior: $z) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Given for graql query
      """
      match ($a, $b) isa relation;
      """
    Then all answers are correct in reasoned database
    # Despite there being more inferred relations, the answer size is still 6 (as in the previous scenario)
    # because the query is only interested in the related concepts, not in the relation instances themselves
    Then answer size in reasoned database is: 6
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match ($a, $b);
      """
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when fixed (#75)
  Scenario: conjunctions of untyped reasoned relations are correctly resolved
    Given for each session, graql define
      """
      define
      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa place, has name "Turku Airport";
      $y isa place, has name "Turku";
      $z isa place, has name "Finland";

      (subordinate: $x, superior: $y) isa location-hierarchy;
      (subordinate: $y, superior: $z) isa location-hierarchy;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        ($a, $b);
        ($b, $c);
      """
    Then all answers are correct in reasoned database
    # a   | b   | c   |
    # AIR | TUR | FIN |
    # AIR | FIN | TUR |
    # AIR | TUR | AIR |
    # AIR | FIN | AIR |
    # TUR | AIR | FIN |
    # TUR | FIN | AIR |
    # TUR | AIR | TUR |
    # TUR | FIN | TUR |
    # FIN | AIR | TUR |
    # FIN | TUR | AIR |
    # FIN | AIR | FIN |
    # FIN | TUR | FIN |
    Then answer size in reasoned database is: 12
    Then materialised and reasoned databases are the same size


  Scenario: a relation can be inferred based on a direct type
    Given for each session, graql define
      """
      define

      baseEntity sub entity,
          plays baseRelation:baseRole,
          plays derivedRelation:derivedRelationRole;

      baseRelation sub relation,
          relates baseRole;
      subRelation sub baseRelation;
      subSubRelation sub subRelation;

      derivedRelation sub relation,
          relates derivedRelationRole;
      directDerivedRelation sub derivedRelation;

      rule relationRule: when {
          ($x) isa subRelation;
      } then {
          (derivedRelationRole: $x) isa derivedRelation;
      };

      rule directRelationRule: when {
          ($x) isa! subRelation;
      } then {
          (derivedRelationRole: $x) isa directDerivedRelation;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
      """
      insert
      $x isa baseEntity;
      $y isa baseEntity;
      $z isa baseEntity;

      (baseRole: $x) isa baseRelation;
      (baseRole: $y) isa subRelation;
      (baseRole: $z) isa subSubRelation;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match ($x) isa derivedRelation;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match ($x) isa! derivedRelation;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match ($x) isa directDerivedRelation;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size