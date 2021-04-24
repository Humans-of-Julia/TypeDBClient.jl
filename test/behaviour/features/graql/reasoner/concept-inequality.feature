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
Feature: Concept Inequality Resolution

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
          owns name;

      ball sub entity,
          owns name,
          plays selection:ball1,
          plays selection:ball2;

      # Represents a selection of balls from a bag, with replacement after each selection
      selection sub relation,
          relates ball1,
          relates ball2;

      name sub attribute, value string;

      rule transitivity: when {
          (ball1:$x, ball2:$y) isa selection;
          (ball1:$y, ball2:$z) isa selection;
      } then {
          (ball1:$x, ball2:$z) isa selection;
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

      $a isa ball, has name 'a';
      $b isa ball, has name 'b';
      $c isa ball, has name 'c';

      # selection is effectively reflexive, symmetric and transitive
      (ball1: $a, ball2: $b) isa selection;
      (ball1: $b, ball2: $a) isa selection;
      (ball1: $b, ball2: $c) isa selection;
      (ball1: $c, ball2: $b) isa selection;
      """
    Given for each session, transaction commits


  Scenario: a rule can be applied based on concept inequality
    Given connection close all sessions
    Given connection open schema sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql define
      """
      define

      state sub entity,
          plays transition:state,
          owns name;

      transition sub relation,
        relates state;

      achieved sub transition;

      prior sub transition;

      holds sub transition;

      rule state-rule: when {
          $st isa state;
          (state: $st) isa achieved;
          (state: $st2) isa prior;
          not { $st is $st2; };
      } then {
          (state: $st) isa holds;
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

      $s1 isa state, has name 's1';
      $s2 isa state, has name 's2';

      (state: $s1) isa prior;
      (state: $s1) isa achieved;
      (state: $s2) isa achieved;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (state: $s) isa holds;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match $s isa state, has name 's2';
      """
    Then materialised and reasoned databases are the same size


  Scenario: inferred binary relations can be filtered by concept inequality of their roleplayers
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Given for graql query
      """
      match (ball1: $x, ball2: $y) isa selection;
      """
    Given all answers are correct in reasoned database
    # materialised: [ab, ba, bc, cb]
    # inferred: [aa, ac, bb, ca, cc]
    Given answer size in reasoned database is: 9
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        not { $x is $y; };
      """
    Then all answers are correct in reasoned database
    # materialised: [ab, ba, bc, cb]
    # inferred: [ac, ca]
    Then answer size in reasoned database is: 6
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    # verify that the answer pairs to the previous query have distinct names within each pair
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        not { $x is $y; };
        $x has name $nx;
        $y has name $ny;
        not { $nx is $ny; };
      get $x, $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 6
    Then materialised and reasoned databases are the same size


  Scenario: inferred binary relations can be filtered by inequality to a specific concept
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        not { $x is $y; };
        $y has name 'c';
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    # verify answers are [ac, bc]
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        not { $x is $y; };
        $y has name 'c';
        {$x has name 'a';} or {$x has name 'b';};
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then materialised and reasoned databases are the same size


  Scenario: pairs of inferred relations can be filtered by inequality of players in the same role

  Tests a scenario in which the neq predicate binds free variables of two equivalent relations.
  Corresponds to the following pattern:

  x
  / \
  /   \
  v     v
  y is not z

    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $x, ball2: $z) isa selection;
        not { $y is $z; };
      """
    Then all answers are correct in reasoned database
    # [aab, aac, aba, abc, aca, acb,
    #  bab, bac, bba, bbc, bca, bcb,
    #  cab, cac, cba, cbc, cca, ccb]
    Then answer size in reasoned database is: 18
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    # verify that $y and $z always have distinct names
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $x, ball2: $z) isa selection;
        not { $y is $z; };
        $y has name $ny;
        $z has name $nz;
        not { $ny is $nz; };
      get $x, $y, $z;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 18
    Then materialised and reasoned databases are the same size




  Scenario: pairs of inferred relations can be filtered by inequality of players in different roles

  Tests a scenario in which the neq predicate binds free variables
  of two non-equivalent relations. Corresponds to the following pattern:

  y
  ^ \
  /   \
  /     v
  x is not z

    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $y, ball2: $z) isa selection;
        not { $x is $z; };
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 18
    # verify that $y and $z always have distinct names
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $x, ball2: $z) isa selection;
        not { $x is $z; };
        $x has name $nx;
        $z has name $nz;
        not { $nx is $nz; };
      get $x, $y, $z;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 18
    Then materialised and reasoned databases are the same size


  Scenario: inequality predicates can operate independently against multiple pairs of relations in the same query

  Tests a scenario in which multiple neq predicates are present but bind at most a single var in a relation.
  Corresponds to the following pattern:

  y  is not  z1
  ^         ^
  \       /
  \     /
  x[a]
  /     \
  /       \
  v         v
  y2 is not  z2

    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Given for graql query
      """
      match
        (ball1: $x, ball2: $y1) isa selection;
        (ball1: $x, ball2: $z1) isa selection;
        (ball1: $x, ball2: $y2) isa selection;
        (ball1: $x, ball2: $z2) isa selection;
      """
    Given all answers are correct in reasoned database
    # For each of the [3] values of $x, there are 3^4 = 81 choices for {$y1, $z1, $y2, $z2}, for a total of 243
    Then answer size in reasoned database is: 243
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y1) isa selection;
        (ball1: $x, ball2: $z1) isa selection;
        (ball1: $x, ball2: $y2) isa selection;
        (ball1: $x, ball2: $z2) isa selection;

        not { $y1 is $z1; };
        not { $y2 is $z2; };
      """
    Then all answers are correct in reasoned database
    # Each neq predicate reduces the answer size by 1/3, cutting it to 162, then 108
    Then answer size in reasoned database is: 108
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    # verify that $y1 and $z1 - as well as $y2 and $z2 - always have distinct names
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y1) isa selection;
        (ball1: $x, ball2: $z1) isa selection;
        (ball1: $x, ball2: $y2) isa selection;
        (ball1: $x, ball2: $z2) isa selection;
        not { $y1 is $z1; };
        not { $y2 is $z2; };
        $y1 has name $ny1;
        $z1 has name $nz1;
        $y2 has name $ny2;
        $z2 has name $nz2;
        not { $ny1 is $nz1; };
        not { $ny2 is $nz2; };
      get $x, $y1, $z1, $y2, $z2;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 108
    Then materialised and reasoned databases are the same size


  Scenario: inequality predicates can operate independently against multiple roleplayers in the same relation

  Tests a scenario in which a single relation has both variables bound with two different neq predicates.
  Corresponds to the following pattern:

  x[a]  - is not - >  z1
  |
  |
  v
  y     - is not - >  z2

    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Given for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $x, ball2: $z1) isa selection;
        (ball1: $y, ball2: $z2) isa selection;
      """
    Given all answers are correct in reasoned database
    # There are 3^4 possible choices for the set {$x, $y, $z1, $z2}, for a total of 81
    Then answer size in reasoned database is: 81
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $x, ball2: $z1) isa selection;
        (ball1: $x, ball2: $z2) isa selection;

        not { $x is $z1; };
        not { $y is $z2; };
      """
    Then all answers are correct in reasoned database
    # Each neq predicate reduces the answer size by 1/3, cutting it to 54, then 36
    Then answer size in reasoned database is: 36
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    # verify that $y1 and $z1 - as well as $y2 and $z2 - always have distinct names
    Then for graql query
      """
      match
        (ball1: $x, ball2: $y) isa selection;
        (ball1: $x, ball2: $z1) isa selection;
        (ball1: $x, ball2: $z2) isa selection;
        not { $x is $z1; };
        not { $y is $z2; };
        $x has name $nx;
        $z1 has name $nz1;
        $y has name $ny;
        $z2 has name $nz2;
        not { $nx is $nz1; };
        not { $ny is $nz2; };
      get $x, $y, $z1, $z2;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 36
    Then materialised and reasoned databases are the same size

  # TODO enable when we can resolve repeated concludables
  @ignore
  # TODO: re-enable once grakn#5821 is fixed (in some answers, $typeof_ax is 'base-attribute' which is incorrect)
  # TODO: re-enable all steps once implicit attribute variables are resolvable
  # TODO: migrate to concept-inequality.feature
  Scenario: when restricting concept types of a pair of inferred attributes with '!=', the answers have distinct types
    Given connection close all sessions
    Given connection open schema sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql define
      """
      define
      soft-drink sub entity,
        owns name,
        owns retailer;
      base-attribute sub attribute, value string, abstract;
      string-attribute sub base-attribute;
      name sub base-attribute;
      retailer sub base-attribute;
      person owns string-attribute;

      rule tesco-sells-all-soft-drinks: when {
        $x isa soft-drink;
      } then {
        $x has retailer 'Tesco';
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
      $x isa person, has string-attribute "Tesco";
      $y isa soft-drink, has name "Tesco";
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $x has $ax;
        $y has $ay;
        $ax isa! $typeof_ax;
        $ay isa! $typeof_ay;
        not { $typeof_ax is $typeof_ay; };
      """
    Then all answers are correct in reasoned database
    # x   | ax  | y   | ay  |
    # PER | STA | SOF | NAM |
    # PER | STA | SOF | RET |
    # SOF | NAM | PER | STA |
    # SOF | RET | PER | STA |
    # SOF | NAM | SOF | STA |
    # SOF | STA | SOF | NAM |
    Then answer size in reasoned database is: 6
    Then materialised and reasoned databases are the same size

  Scenario: inferred attribute matches can be simultaneously restricted by both concept type and attribute value
    Given connection close all sessions
    Given connection open schema sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql define
      """
      define
      soft-drink sub entity,
        owns name,
        owns retailer;
      base-attribute sub attribute, value string, abstract;
      string-attribute sub base-attribute;
      retailer sub base-attribute;
      person owns string-attribute;

      rule transfer-string-attribute-to-other-people: when {
        $x isa person, has string-attribute $r1;
        $y isa person;
      } then {
        $y has $r1;
      };

      rule tesco-sells-all-soft-drinks: when {
        $x isa soft-drink;
      } then {
        $x has retailer 'Tesco';
      };

      rule if-ocado-exists-it-sells-all-soft-drinks: when {
        $x isa retailer;
        $x = 'Ocado';
        $y isa soft-drink;
      } then {
        $y has $x;
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
      $w isa person, has string-attribute "Ocado";
      $x isa person, has string-attribute "Tesco";
      $y isa soft-drink, has name "Sprite";
      $z "Ocado" isa retailer;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        $value isa! retailer;
        $unwantedValue isa! retailer;
        $x has $value;
        $y has $unwantedValue;
        $unwantedValue "Ocado";
        $value != $unwantedValue;
      get $x, $value;
      """
    Then all answers are correct in reasoned database
    # x      | value | type     |
    # Sprite | Tesco | retailer |
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size
