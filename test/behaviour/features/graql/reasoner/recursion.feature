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
Feature: Recursion Resolution

  In some cases, the inferences made by a rule are used to trigger further inferences by the same rule.
  This test feature verifies that so-called recursive inference works as intended.

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
    Given for each session, open transactions of type: write


  Scenario: the types of entities in inferred relations can be used to make further inferences
    Given for each session, graql define
      """
      define

      big-place sub place,
        plays big-location-hierarchy:big-subordinate,
        plays big-location-hierarchy:big-superior;

      big-location-hierarchy sub location-hierarchy,
        relates big-subordinate as subordinate,
        relates big-superior as superior;

      rule transitive-location: when {
        (subordinate: $x, superior: $y) isa location-hierarchy;
        (subordinate: $y, superior: $z) isa location-hierarchy;
      } then {
        (subordinate: $x, superior: $z) isa location-hierarchy;
      };

      rule if-a-big-thing-is-in-a-big-place-then-its-a-big-location: when {
        $x isa big-place;
        $y isa big-place;
        (subordinate: $x, superior: $y) isa location-hierarchy;
      } then {
        (big-subordinate: $x, big-superior: $y) isa big-location-hierarchy;
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
      $x isa big-place, has name "Mount Kilimanjaro";
      $y isa place, has name "Tanzania";
      $z isa big-place, has name "Africa";

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
      match (subordinate: $x, superior: $y) isa big-location-hierarchy;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size


  Scenario: the types of inferred relations can be used to make further inferences
    Given for each session, graql define
      """
      define

      entity1 sub entity,
          plays relation1:role11,
          plays relation1:role12,
          plays relation2:role21,
          plays relation2:role22,
          plays relation3:role31,
          plays relation3:role32;

      relation1 sub relation,
          relates role11,
          relates role12;

      relation2 sub relation,
          relates role21,
          relates role22;

      relation3 sub relation,
          relates role31,
          relates role32;

      rule relation3-inference: when {
          (role11:$x, role12:$y) isa relation1;
          (role21:$y, role22:$z) isa relation2;
          (role11:$z, role12:$u) isa relation1;
      } then {
          (role31:$x, role32:$u) isa relation3;
      };

      rule relation2-transitivity: when {
          (role21:$x, role22:$y) isa relation2;
          (role21:$y, role22:$z) isa relation2;
      } then {
          (role21:$x, role22:$z) isa relation2;
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

      $x isa entity1;
      $y isa entity1;
      $z isa entity1;
      $u isa entity1;
      $v isa entity1;
      $w isa entity1;
      $q isa entity1;

      (role11:$x, role12:$y) isa relation1;
      (role21:$y, role22:$z) isa relation2;
      (role21:$z, role22:$u) isa relation2;
      (role21:$u, role22:$v) isa relation2;
      (role21:$v, role22:$w) isa relation2;
      (role11:$w, role12:$q) isa relation1;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (role31: $x, role32: $y) isa relation3;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then materialised and reasoned databases are the same size


  Scenario: circular rule dependencies can be resolved
    Given for each session, graql define
      """
      define

      entity1 sub entity,
          plays relation1:role11,
          plays relation1:role12,
          plays relation2:role21,
          plays relation2:role22,
          plays relation3:role31,
          plays relation3:role32;

      relation1 sub relation,
          relates role11,
          relates role12;

      relation2 sub relation,
          relates role21,
          relates role22;

      relation3 sub relation,
          relates role31,
          relates role32;

      rule relation-1-to-2: when {
          (role11:$x, role12:$y) isa relation1;
      } then {
          (role21:$x, role22:$y) isa relation2;
      };

      rule relation-3-to-2: when {
          (role31:$x, role32:$y) isa relation3;
      } then {
          (role21:$x, role22:$y) isa relation2;
      };

      rule relation-2-to-3: when {
          (role21:$x, role22:$y) isa relation2;
      } then {
          (role31:$x, role32:$y) isa relation3;
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

      $x isa entity1;
      $y isa entity1;

      (role11:$x, role12:$x) isa relation1;
      (role11:$x, role12:$y) isa relation1;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (role31: $x, role32: $y) isa relation3;
      """
    Then all answers are correct in reasoned database
    # Each of the two material relation1 instances should infer a single relation3 via 1-to-2 and 2-to-3
    Then answer size in reasoned database is: 2
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (role21: $x, role22: $y) isa relation2;
      """
    Then all answers are correct in reasoned database
    # Relation-3-to-2 should not make any additional inferences - it should merely assert that the relations exist
    Then answer size in reasoned database is: 2
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when we have a solution for materialisation of infinite graphs (#75)
  Scenario: when resolution produces an infinite stream of answers, limiting the answer size allows it to terminate
    Given for each session, graql define
      """
      define

      dream sub relation,
        relates dreamer,
        relates subject,
        plays dream:subject;

      person plays dream:dreamer, plays dream:subject;

      rule inception: when {
        $x isa person;
        $z (dreamer: $x, subject: $y) isa dream;
      } then {
        (dreamer: $x, subject: $z) isa dream;
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
      $x isa person, has name "Yusuf";
      # If only Yusuf didn't dream about himself...
      (dreamer: $x, subject: $x) isa dream;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $x isa dream; limit 10;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 10
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when materialisation is possible (may be an infinite graph?) (#75)
  Scenario: when relations' and attributes' inferences are mutually recursive, the inferred concepts can be retrieved
    Given for each session, graql define
      """
      define

      word sub entity,
          plays inheritance:subtype,
          plays inheritance:supertype,
          plays pair:prep,
          plays pair:pobj,
          owns name;

      f sub word;
      o sub word;

      inheritance sub relation,
          relates supertype,
          relates subtype;

      pair sub relation,
          relates prep,
          relates pobj,
          owns typ,
          owns name;

      name sub attribute, value string;
      typ sub attribute, value string;

      rule inference-all-pairs: when {
          $x isa word;
          $y isa word;
          $x has name != 'f';
          $y has name != 'o';
      } then {
          (prep: $x, pobj: $y) isa pair;
      };

      rule inference-pairs-ff: when {
          $f isa f;
          (subtype: $prep, supertype: $f) isa inheritance;
          (subtype: $pobj, supertype: $f) isa inheritance;
          $p (prep: $prep, pobj: $pobj) isa pair;
      } then {
          $p has name 'ff';
      };

      rule inference-pairs-fo: when {
          $f isa f;
          $o isa o;
          (subtype: $prep, supertype: $f) isa inheritance;
          (subtype: $pobj, supertype: $o) isa inheritance;
          $p (prep: $prep, pobj: $pobj) isa pair;
      } then {
          $p has name 'fo';
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

      $f isa f, has name "f";
      $o isa o, has name "o";

      $aa isa word, has name "aa";
      $bb isa word, has name "bb";
      $cc isa word, has name "cc";

      (supertype: $o, subtype: $aa) isa inheritance;
      (supertype: $o, subtype: $bb) isa inheritance;
      (supertype: $o, subtype: $cc) isa inheritance;

      $pp isa word, has name "pp";
      $qq isa word, has name "qq";
      $rr isa word, has name "rr";
      $rr2 isa word, has name "rr";

      (supertype: $f, subtype: $pp) isa inheritance;
      (supertype: $f, subtype: $qq) isa inheritance;
      (supertype: $f, subtype: $rr) isa inheritance;
      (supertype: $f, subtype: $rr2) isa inheritance;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $p isa pair, has name 'ff';
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 16
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $p isa pair;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 64
    Then materialised and reasoned databases are the same size


  Scenario: non-regular transitivity requiring iterative generation of tuples

  from Vieille - Recursive Axioms in Deductive Databases p. 192

    Given for each session, graql define
      """
      define

      entity2 sub entity,
        owns index;

      R sub relation, relates role-A, relates role-B;
      entity2 plays R:role-A, plays R:role-B;

      E sub relation, relates role-A, relates role-B;
      entity2 plays E:role-A, plays E:role-B;

      F sub relation, relates role-A, relates role-B;
      entity2 plays F:role-A, plays F:role-B;

      G sub relation, relates role-A, relates role-B;
      entity2 plays G:role-A, plays G:role-B;

      H sub relation, relates role-A, relates role-B;
      entity2 plays H:role-A, plays H:role-B;

      index sub attribute, value string;

      rule rule-1: when {
        (role-A: $x, role-B: $y) isa E;
      } then {
        (role-A: $x, role-B: $y) isa R;
      };

      rule rule-2: when {
        (role-A: $x, role-B: $t) isa F;
        (role-A: $t, role-B: $u) isa R;
        (role-A: $u, role-B: $v) isa G;
        (role-A: $v, role-B: $w) isa R;
        (role-A: $w, role-B: $y) isa H;
      } then {
        (role-A: $x, role-B: $y) isa R;
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

      $i isa entity2, has index "i";
      $j isa entity2, has index "j";
      $k isa entity2, has index "k";
      $l isa entity2, has index "l";
      $m isa entity2, has index "m";
      $n isa entity2, has index "n";
      $o isa entity2, has index "o";
      $p isa entity2, has index "p";
      $q isa entity2, has index "q";
      $r isa entity2, has index "r";
      $s isa entity2, has index "s";
      $t isa entity2, has index "t";
      $u isa entity2, has index "u";
      $v isa entity2, has index "v";

      (role-A: $i, role-B: $j) isa E;
      (role-A: $l, role-B: $m) isa E;
      (role-A: $n, role-B: $o) isa E;
      (role-A: $q, role-B: $r) isa E;
      (role-A: $t, role-B: $u) isa E;

      (role-A: $i, role-B: $i) isa F;
      (role-A: $i, role-B: $k) isa F;
      (role-A: $k, role-B: $l) isa F;

      (role-A: $m, role-B: $n) isa G;
      (role-A: $p, role-B: $q) isa G;
      (role-A: $s, role-B: $t) isa G;

      (role-A: $o, role-B: $p) isa H;
      (role-A: $r, role-B: $s) isa H;
      (role-A: $u, role-B: $v) isa H;
      """
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        ($x, $y) isa R;
        $x has index 'i';
      get $y;
      """
    Then answer size in reasoned database is: 3
    Given for each session, transaction closes
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $y has index $ind;
        {$ind = 'j';} or {$ind = 's';} or {$ind = 'v';};
      get $y;
      """
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when resolvable (currently takes too long) (#75)
  # Note: some of the commented steps intermittently succeed; may be caused by inconsistent query planning
  Scenario: ancestor test

  from Bancilhon - An Amateur's Introduction to Recursive Query Processing Strategies p. 25

    Given for each session, graql define
      """
      define

      person sub entity,
        owns name;

      parentship sub relation, relates parent, relates child;
      person plays parentship:parent, plays parentship:child;

      ancestorship sub relation, relates ancestor, relates descendant;
      person plays ancestorship:ancestor, plays ancestorship:descendant;

      name sub attribute, value string;

      rule rule-1: when {
        (parent: $x, child: $z) isa parentship;
        (ancestor: $z, descendant: $y) isa ancestorship;
      } then {
        (ancestor: $x, descendant: $y) isa ancestorship;
      };

      rule rule-2: when {
        (parent: $x, child: $y) isa parentship;
      } then {
        (ancestor: $x, descendant: $y) isa ancestorship;
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

      $a isa person, has name 'a';
      $aa isa person, has name 'aa';
      $aaa isa person, has name 'aaa';
      $aab isa person, has name 'aab';
      $aaaa isa person, has name 'aaaa';
      $ab isa person, has name 'ab';
      $c isa person, has name 'c';
      $ca isa person, has name 'ca';

      (parent: $a, child: $aa) isa parentship;
      (parent: $a, child: $ab) isa parentship;
      (parent: $aa, child: $aaa) isa parentship;
      (parent: $aa, child: $aab) isa parentship;
      (parent: $aaa, child: $aaaa) isa parentship;
      (parent: $c, child: $ca) isa parentship;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ancestor: $X, descendant: $Y) isa ancestorship;
        $X has name 'aa';
        $Y has name $name;
      get $Y, $name;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 3
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $Y isa person, has name $name;
        {$name = 'aaa';} or {$name = 'aab';} or {$name = 'aaaa';};
      get $Y, $name;
      """
    Then for graql query
      """
      match
        ($X, $Y) isa ancestorship;
        $X has name 'aa';
      get $Y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 4
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $Y isa person, has name $name;
        {$name = 'a';} or {$name = 'aaa';} or {$name = 'aab';} or {$name = 'aaaa';};
      get $Y;
      """
    Then for graql query
      """
      match (ancestor: $X, descendant: $Y) isa ancestorship;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 10
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $Y isa person, has name $nameY;
        $X isa person, has name $nameX;
        {$nameX = 'a';$nameY = 'aa';} or {$nameX = 'a';$nameY = 'ab';} or
        {$nameX = 'a';$nameY = 'aaa';} or {$nameX = 'a';$nameY = 'aab';} or
        {$nameX = 'a';$nameY = 'aaaa';} or {$nameX = 'aa';$nameY = 'aaa';} or
        {$nameX = 'aa';$nameY = 'aab';} or {$nameX = 'aa';$nameY = 'aaaa';} or
        {$nameX = 'aaa';$nameY = 'aaaa';} or {$nameX = 'c';$nameY = 'ca';};
      get $X, $Y;
      """
    Then for graql query
      """
      match ($X, $Y) isa ancestorship;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 20
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $X isa person, has name $nameX;
        $Y isa person, has name $nameY;
        {$nameX = 'a';$nameY = 'aa';} or
        {$nameX = 'a';$nameY = 'ab';} or {$nameX = 'a';$nameY = 'aaa';} or
        {$nameX = 'a';$nameY = 'aab';} or {$nameX = 'a';$nameY = 'aaaa';} or
        {$nameY = 'a';$nameX = 'aa';} or
        {$nameY = 'a';$nameX = 'ab';} or {$nameY = 'a';$nameX = 'aaa';} or
        {$nameY = 'a';$nameX = 'aab';} or {$nameY = 'a';$nameX = 'aaaa';} or

        {$nameX = 'aa';$nameY = 'aaa';} or {$nameX = 'aa';$nameY = 'aab';} or
        {$nameX = 'aa';$nameY = 'aaaa';} or
        {$nameY = 'aa';$nameX = 'aaa';} or {$nameY = 'aa';$nameX = 'aab';} or
        {$nameY = 'aa';$nameX = 'aaaa';} or

        {$nameX = 'aaa';$nameY = 'aaaa';} or
        {$nameY = 'aaa';$nameX = 'aaaa';} or

        {$nameX = 'c';$nameY = 'ca';} or
        {$nameY = 'c';$nameX = 'ca';};
      get $X, $Y;
      """
    Then materialised and reasoned databases are the same size


  Scenario: ancestor-friend test

  from Vieille - Recursive Axioms in Deductive Databases (QSQ approach) p. 186

    Given for each session, graql define
      """
      define

      person sub entity,
          owns name,
          plays parentship:parent,
          plays parentship:child,
          plays friendship:friend,
          plays friendship:friend,
          plays ancestor-friendship:ancestor,
          plays ancestor-friendship:friend;

      friendship sub relation, relates friend;
      parentship sub relation, relates parent, relates child;
      ancestor-friendship sub relation, relates ancestor, relates friend;

      name sub attribute, value string;

      rule rule-1: when {
        (friend: $x, friend: $y) isa friendship;
      } then {
        (ancestor: $x, friend: $y) isa ancestor-friendship;
      };

      rule rule-2: when {
        (parent: $x, child: $z) isa parentship;
        (ancestor: $z, friend: $y) isa ancestor-friendship;
      } then {
        (ancestor: $x, friend: $y) isa ancestor-friendship;
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

      $a isa person, has name "a";
      $b isa person, has name "b";
      $c isa person, has name "c";
      $d isa person, has name "d";
      $g isa person, has name "g";

      (parent: $a, child: $b) isa parentship;
      (parent: $b, child: $c) isa parentship;
      (friend: $a, friend: $g) isa friendship;
      (friend: $c, friend: $d) isa friendship;
      """
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ancestor: $X, friend: $Y) isa ancestor-friendship;
        $X has name 'a';
        $Y has name $name;
      get $Y;
      """
    Then answer size in reasoned database is: 2
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then all answers are correct in reasoned database
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $Y has name $name;
        {$name = 'd';} or {$name = 'g';};
      get $Y;
      """
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    And answer set is equivalent for graql query
      """
      match
        ($X, $Y) isa ancestor-friendship;
        $X has name 'a';
      get $Y;
      """
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (ancestor: $X, friend: $Y) isa ancestor-friendship;
        $Y has name 'd';
      get $X;
      """
    Then answer size in reasoned database is: 3
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then all answers are correct in reasoned database
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $X has name $name;
        {$name = 'a';} or {$name = 'b';} or {$name = 'c';};
      get $X;
      """
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    And answer set is equivalent for graql query
      """
      match
        ($X, $Y) isa ancestor-friendship;
        $Y has name 'd';
      get $X;
      """
    Then materialised and reasoned databases are the same size


  Scenario: same-generation test

  from Vieille - Recursive Query Processing: The power of logic p. 25

    Given for each session, graql define
      """
      define

      entity2 sub entity,
          owns name;
      Human sub entity2;

      parentship sub relation, relates parent, relates child;
      entity2 plays parentship:parent, plays parentship:child;

      SameGen sub relation, relates SG-role;
      entity2 plays SameGen:SG-role;

      name sub attribute, value string;

      rule rule-1: when {
        $x isa Human;
      } then {
        (SG-role: $x, SG-role: $x) isa SameGen;
      };

      rule rule-2: when {
        (parent: $x, child: $u) isa parentship;
        (parent: $y, child: $v) isa parentship;
        (SG-role: $u, SG-role: $v) isa SameGen;
      } then {
        (SG-role: $x, SG-role: $y) isa SameGen;
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

      $a isa entity2, has name "a";
      $b isa entity2, has name "b";
      $c isa entity2, has name "c";
      $d isa Human, has name "d";
      $e isa entity2, has name "e";
      $f isa entity2, has name "f";
      $g isa entity2, has name "g";
      $h isa entity2, has name "h";

      (parent: $a, child: $b) isa parentship;
      (parent: $a, child: $c) isa parentship;
      (parent: $b, child: $d) isa parentship;
      (parent: $c, child: $d) isa parentship;
      (parent: $e, child: $d) isa parentship;
      (parent: $f, child: $e) isa parentship;

      #Extra data
      (parent: $g, child: $f) isa parentship;
      (parent: $h, child: $g) isa parentship;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        ($x, $y) isa SameGen;
        $x has name 'a';
      get $y;
      """
    Then answer size in reasoned database is: 2
    Then all answers are correct in reasoned database
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $y has name $name;
        {$name = 'f';} or {$name = 'a';};
      get $y;
      """
    Then materialised and reasoned databases are the same size


  Scenario: TC test

  from Vieille - Recursive Query Processing: The power of logic p. 18

    Given for each session, graql define
      """
      define

      entity2 sub entity,
          owns index,
          plays N-TC:roleB,
          plays N-TC:roleA,
          plays TC:roleA,
          plays TC:roleB,
          plays P:roleA,
          plays P:roleB;
      q sub entity2;

      N-TC sub relation, relates roleB, relates roleA;

      TC sub relation, relates roleA, relates roleB;

      P sub relation, relates roleA, relates roleB;

      index sub attribute, value string;

      rule rule-1: when {
        $x isa q;
        (roleA: $x, roleB: $y) isa TC;
      } then {
        (roleA: $x, roleB: $y) isa N-TC;
      };

      rule rule-2: when {
        (roleA: $x, roleB: $y) isa P;
      } then {
        (roleA: $x, roleB: $y) isa TC;
      };

      rule rule-3: when {
        (roleA: $x, roleB: $z) isa P;
        (roleA: $z, roleB: $y) isa TC;
      } then {
        (roleA: $x, roleB: $y) isa TC;
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

      $a isa entity2, has index "a";
      $a1 isa entity2, has index "a1";
      $a2 isa q, has index "a2";

      (roleA: $a1, roleB: $a) isa P;
      (roleA: $a2, roleB: $a1) isa P;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        ($x, $y) isa N-TC;
        $y has index 'a';
      get $x;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 1
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match $x has index 'a2';
      """
    Then materialised and reasoned databases are the same size


  Scenario: given a directed graph, all pairs of vertices (x,y) such that y is reachable from x can be found

  test 5.2 from Green - Datalog and Recursive Query Processing

  It defines a node configuration:

  /^\
  aa -> bb -> cc -> dd

  and finds all pairs (from, to) such that 'to' is reachable from 'from'.

    Given for each session, graql define
      """
      define

      indexable sub entity,
          owns index;

      traversable sub indexable,
          plays pair:from,
          plays pair:to;

      vertex sub traversable;
      node sub traversable;

      pair sub relation, relates from, relates to;
      link sub pair;
      indirect-link sub pair;
      reachable sub pair;
      unreachable sub pair;

      index sub attribute, value string;

      rule reachability-transitivityA: when {
          (from: $x, to: $y) isa link;
      } then {
          (from: $x, to: $y) isa reachable;
      };

      rule reachability-transitivityB: when {
          (from: $x, to: $z) isa link;
          (from: $z, to: $y) isa reachable;
      } then {
          (from: $x, to: $y) isa reachable;
      };

      rule indirect-link-rule: when {
          (from: $x, to: $y) isa reachable;
          not {(from: $x, to: $y) isa link;};
      } then {
          (from: $x, to: $y) isa indirect-link;
      };

      rule unreachability-rule: when {
          $x isa vertex;
          $y isa vertex;
          not {(from: $x, to: $y) isa reachable;};
      } then {
          (from: $x, to: $y) isa unreachable;
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

      $aa isa node, has index "aa";
      $bb isa node, has index "bb";
      $cc isa node, has index "cc";
      $dd isa node, has index "dd";

      (from: $aa, to: $bb) isa link;
      (from: $bb, to: $cc) isa link;
      (from: $cc, to: $cc) isa link;
      (from: $cc, to: $dd) isa link;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (from: $x, to: $y) isa reachable;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 7
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $x has index $indX;
        $y has index $indY;
        {$indX = 'aa';$indY = 'bb';} or
        {$indX = 'bb';$indY = 'cc';} or
        {$indX = 'cc';$indY = 'cc';} or
        {$indX = 'cc';$indY = 'dd';} or
        {$indX = 'aa';$indY = 'cc';} or
        {$indX = 'bb';$indY = 'dd';} or
        {$indX = 'aa';$indY = 'dd';};
      get $x, $y;
      """
    Then materialised and reasoned databases are the same size


  Scenario: given an undirected graph, all vertices connected to a given vertex can be found

  For this test, the graph looks like the following:

  /^\
  a -- b -- c -- d

  We find the set of vertices connected to 'a', which is in fact all of the vertices, including 'a' itself.

    Given for each session, graql define
      """
      define

      vertex sub entity,
        owns index @key,
        plays reachable:coordinate;

      link sub relation, relates coordinate;
      reachable sub link;

      index sub attribute, value string;

      rule a-linked-point-is-reachable: when {
        ($x, $y) isa link;
      } then {
        (coordinate: $x, coordinate: $y) isa reachable;
      };

      rule a-point-reachable-from-a-linked-point-is-reachable: when {
        ($x, $z) isa link;
        ($z, $y) isa reachable;
      } then {
        (coordinate: $x, coordinate: $y) isa reachable;
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

      $a isa vertex, has index "a";
      $b isa vertex, has index "b";
      $c isa vertex, has index "c";
      $d isa vertex, has index "d";

      (coordinate: $a, coordinate: $b) isa link;
      (coordinate: $b, coordinate: $c) isa link;
      (coordinate: $c, coordinate: $c) isa link;
      (coordinate: $c, coordinate: $d) isa link;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        ($x, $y) isa reachable;
        $x has index 'a';
      get $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 4
    Then for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $y has index $indY;
        {$indY = 'a';} or {$indY = 'b';} or {$indY = 'c';} or {$indY = 'd';};
      get $y;
      """
    Then materialised and reasoned databases are the same size


  # TODO: re-enable all steps when resolvable (currently takes too long) (#75)
  Scenario: same-generation - Cao test

  test 6.6 from Cao p.76

    Given for each session, graql define
      """
      define

      person sub entity,
        owns name;

      parentship sub relation, relates parent, relates child;
      person plays parentship:parent, plays parentship:child;

      Sibling sub relation, relates A, relates B;
      person plays Sibling:A, plays Sibling:B;

      SameGen sub relation, relates A, relates B;
      person plays SameGen:A, plays SameGen:B;

      name sub attribute, value string;

      rule rule-1: when {
        (A: $x, B: $y) isa Sibling;
      } then {
        (A: $x, B: $y) isa SameGen;
      };

      rule rule-2: when {
        (parent: $x, child: $u) isa parentship;
        ($u, $v) isa SameGen;
        (parent: $y, child: $v) isa parentship;
      } then {
        (A: $x, B: $y) isa SameGen;
      };

      rule rule-3: when {
        (parent: $z, child: $x) isa parentship;
        (parent: $z, child: $y) isa parentship;
      } then {
        (A: $x, B: $y) isa Sibling;
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

      $ann isa person, has name "ann";
      $bill isa person, has name "bill";
      $john isa person, has name "john";
      $peter isa person, has name "peter";

      (parent: $john, child: $ann) isa parentship;
      (parent: $john, child: $peter) isa parentship;
      (parent: $john, child: $bill) isa parentship;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        ($x, $y) isa SameGen;
        $x has name 'ann';
      get $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 3
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $y has name $name;
        {$name = 'ann';} or {$name = 'bill';} or {$name = 'peter';};
      get $y;
      """
    Then materialised and reasoned databases are the same size


  Scenario: reverse same-generation test

  from Abiteboul - Foundations of databases p. 312/Cao test 6.14 p. 89

    Given for each session, graql define
      """
      define

      person sub entity,
        owns name,
        plays parentship:parent,
        plays parentship:child,
        plays RevSG:from,
        plays RevSG:to,
        plays up:from,
        plays up:to,
        plays down:from,
        plays down:to,
        plays flat:from,
        plays flat:to;

      parentship sub relation, relates parent, relates child;

      RevSG sub relation, relates from, relates to;

      up sub relation, relates from, relates to;

      down sub relation, relates from, relates to;

      flat sub relation, relates to, relates from;

      name sub attribute, value string;

      rule rule-1: when {
        (from: $x, to: $y) isa flat;
      } then {
        (from: $x, to: $y) isa RevSG;
      };

      rule rule-2: when {
        (from: $x, to: $x1) isa up;
        (from: $y1, to: $x1) isa RevSG;
        (from: $y1, to: $y) isa down;
      } then {
        (from: $x, to: $y) isa RevSG;
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

      $a isa person, has name "a";
      $b isa person, has name "b";
      $c isa person, has name "c";
      $d isa person, has name "d";
      $e isa person, has name "e";
      $f isa person, has name "f";
      $g isa person, has name "g";
      $h isa person, has name "h";
      $i isa person, has name "i";
      $j isa person, has name "j";
      $k isa person, has name "k";
      $l isa person, has name "l";
      $m isa person, has name "m";
      $n isa person, has name "n";
      $o isa person, has name "o";
      $p isa person, has name "p";

      (from: $a, to: $e) isa up;
      (from: $a, to: $f) isa up;
      (from: $f, to: $m) isa up;
      (from: $g, to: $n) isa up;
      (from: $h, to: $n) isa up;
      (from: $i, to: $o) isa up;
      (from: $j, to: $o) isa up;

      (from: $g, to: $f) isa flat;
      (from: $m, to: $n) isa flat;
      (from: $m, to: $o) isa flat;
      (from: $p, to: $m) isa flat;

      (from: $l, to: $f) isa down;
      (from: $m, to: $f) isa down;
      (from: $g, to: $b) isa down;
      (from: $h, to: $c) isa down;
      (from: $i, to: $d) isa down;
      (from: $p, to: $k) isa down;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (from: $x, to: $y) isa RevSG;
        $x has name 'a';
      get $y;
      """
    Then answer size in reasoned database is: 3
    Then all answers are correct in reasoned database
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $y isa person, has name $name;
        {$name = 'b';} or {$name = 'c';} or {$name = 'd';};
      get $y;
      """
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match (from: $x, to: $y) isa RevSG;
      """
    Then answer size in reasoned database is: 11
    Then all answers are correct in reasoned database
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match
        $x has name $nameX;
        $y has name $nameY;
        {$nameX = 'a';$nameY = 'b';} or {$nameX = 'a';$nameY = 'c';} or
        {$nameX = 'a';$nameY = 'd';} or {$nameX = 'm';$nameY = 'n';} or
        {$nameX = 'm';$nameY = 'o';} or {$nameX = 'p';$nameY = 'm';} or
        {$nameX = 'g';$nameY = 'f';} or {$nameX = 'h';$nameY = 'f';} or
        {$nameX = 'i';$nameY = 'f';} or {$nameX = 'j';$nameY = 'f';} or
        {$nameX = 'f';$nameY = 'k';};
      get $x, $y;
      """
    Then materialised and reasoned databases are the same size


  Scenario: dual linear transitivity matrix test

  test 6.1 from Cao - Methods for evaluating queries to Horn knowledge bases in first-order logic, p. 71

  Tests an 'n' x 'm' linear transitivity matrix (in this scenario, n = m = 5)

    Given for each session, graql define
      """
      define

      entity2 sub entity,
        owns index @key,
        plays P:from, plays P:to,
        plays Q1:from, plays Q1:to,
        plays Q2:from, plays Q2:to,
        plays R1:from, plays R1:to,
        plays R2:from, plays R2:to;

      start sub entity2;
      end sub entity2;
      a-entity sub entity2;
      b-entity sub entity2;

      R1 sub relation, relates from, relates to;
      R2 sub relation, relates from, relates to;
      Q1 sub relation, relates from, relates to;
      Q2 sub relation, relates from, relates to;
      P sub relation, relates from, relates to;

      index sub attribute, value string;

      rule rule-1: when {
        (from: $x, to: $y) isa R1;
      } then {
        (from: $x, to: $y) isa Q1;
      };

      rule rule-2: when {
        (from: $x, to: $z) isa R1;
        (from: $z, to: $y) isa Q1;
      } then {
        (from: $x, to: $y) isa Q1;
      };

      rule rule-3: when {
        (from: $x, to: $y) isa R2;
      } then {
        (from: $x, to: $y) isa Q2;
      };

      rule rule-4: when {
        (from: $x, to: $z) isa R2;
        (from: $z, to: $y) isa Q2;
      } then {
        (from: $x, to: $y) isa Q2;
      };

      rule rule-5: when {
        (from: $x, to: $y) isa Q1;
      } then {
        (from: $x, to: $y) isa P;
      };
      """
    Given for each session, transaction commits
    Given connection close all sessions
    Given connection open data sessions for databases:
      | reasoned     |
      | materialised |
    Given for each session, open transactions of type: write
    Given for each session, graql insert
    # These insert statements can be procedurally generated based on 'm' and 'n', the width and height of the matrix
    """
      insert


      $c isa entity2, has index "c";
      $d isa entity2, has index "d";
      $e isa entity2, has index "e";


      $a0 isa start, has index "a0"; # a{0}
      $a5 isa end, has index "a5"; # a{m}


      # $a{i} isa a-entity, has index "a{i}"; for 1 <= i < m
      $a1 isa a-entity, has index "a1";
      $a2 isa a-entity, has index "a2";
      $a3 isa a-entity, has index "a3";
      $a4 isa a-entity, has index "a4";


      # b{ij} isa b-entity, has index "b{ij}"; for 1 <= i < m; for 1 <= j <= n
      $b11 isa b-entity, has index "b11";
      $b12 isa b-entity, has index "b12";
      $b13 isa b-entity, has index "b13";
      $b14 isa b-entity, has index "b14";
      $b15 isa b-entity, has index "b15";

      $b21 isa b-entity, has index "b21";
      $b22 isa b-entity, has index "b22";
      $b23 isa b-entity, has index "b23";
      $b24 isa b-entity, has index "b24";
      $b25 isa b-entity, has index "b25";

      $b31 isa b-entity, has index "b31";
      $b32 isa b-entity, has index "b32";
      $b33 isa b-entity, has index "b33";
      $b34 isa b-entity, has index "b34";
      $b35 isa b-entity, has index "b35";

      $b41 isa b-entity, has index "b41";
      $b42 isa b-entity, has index "b42";
      $b43 isa b-entity, has index "b43";
      $b44 isa b-entity, has index "b44";
      $b45 isa b-entity, has index "b45";


      # (from: $a{i}, to: $a{i+1} isa R1; for 0 <= i < m
      (from: $a0, to: $a1) isa R1;
      (from: $a1, to: $a2) isa R1;
      (from: $a2, to: $a3) isa R1;
      (from: $a3, to: $a4) isa R1;
      (from: $a4, to: $a5) isa R1;


      # (from: $a0, to: $b1{j}) isa R2; for 1 <= j <= n
      # (from: $b{m-1}{j}, to: $a{m}) isa R2; for 1 <= j <= n
      # (from: $b{i}{j}, to: $b{i+1}{j}) isa R2; for 1 <= j <= n; for 1 <= i < m - 1
      (from: $a0, to: $b11) isa R2;
      (from: $b41, to: $a5) isa R2;
      (from: $b11, to: $b21) isa R2;
      (from: $b21, to: $b31) isa R2;
      (from: $b31, to: $b41) isa R2;

      (from: $a0, to: $b12) isa R2;
      (from: $b42, to: $a5) isa R2;
      (from: $b12, to: $b22) isa R2;
      (from: $b22, to: $b32) isa R2;
      (from: $b32, to: $b42) isa R2;

      (from: $a0, to: $b13) isa R2;
      (from: $b43, to: $a5) isa R2;
      (from: $b13, to: $b23) isa R2;
      (from: $b23, to: $b33) isa R2;
      (from: $b33, to: $b43) isa R2;

      (from: $a0, to: $b14) isa R2;
      (from: $b44, to: $a5) isa R2;
      (from: $b14, to: $b24) isa R2;
      (from: $b24, to: $b34) isa R2;
      (from: $b34, to: $b44) isa R2;

      (from: $a0, to: $b15) isa R2;
      (from: $b45, to: $a5) isa R2;
      (from: $b15, to: $b25) isa R2;
      (from: $b25, to: $b35) isa R2;
      (from: $b35, to: $b45) isa R2;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (from: $x, to: $y) isa Q1;
        $x has index 'a0';
      get $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 5
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match $y isa $t; { $t type a-entity; } or { $t type end; }; get $y;
      """
    Then materialised and reasoned databases are the same size


  Scenario: tail recursion test

  test 6.3 from Cao - Methods for evaluating queries to Horn knowledge bases in first-order logic, p 75

    Given for each session, graql define
      """
      define

      entity2 sub entity,
        owns index @key,
        plays P:from,
        plays P:to,
        plays Q:from,
        plays Q:to;

      a-entity sub entity2;
      b-entity sub entity2;

      P sub relation, relates from, relates to;

      Q sub relation, relates from, relates to;

      index sub attribute, value string;

      rule rule-1: when {
        (from: $x, to: $y) isa Q;
      } then {
        (from: $x, to: $y) isa P;
      };

      rule rule-2: when {
        (from: $x, to: $z) isa Q;
        (from: $z, to: $y) isa P;
      } then {
        (from: $x, to: $y) isa P;
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


      $a0 isa a-entity, has index "a0";


      # $b{i}_{j} isa b-entity, has index "b{i}_{j}"; for 1 <= i <= m + 1; for 1 <= j <= n
      $b1_1 isa b-entity, has index "b1_1";
      $b1_2 isa b-entity, has index "b1_2";
      $b1_3 isa b-entity, has index "b1_3";
      $b1_4 isa b-entity, has index "b1_4";
      $b1_5 isa b-entity, has index "b1_5";
      $b1_6 isa b-entity, has index "b1_6";
      $b1_7 isa b-entity, has index "b1_7";
      $b1_8 isa b-entity, has index "b1_8";
      $b1_9 isa b-entity, has index "b1_9";
      $b1_10 isa b-entity, has index "b1_10";

      $b2_1 isa b-entity, has index "b2_1";
      $b2_2 isa b-entity, has index "b2_2";
      $b2_3 isa b-entity, has index "b2_3";
      $b2_4 isa b-entity, has index "b2_4";
      $b2_5 isa b-entity, has index "b2_5";
      $b2_6 isa b-entity, has index "b2_6";
      $b2_7 isa b-entity, has index "b2_7";
      $b2_8 isa b-entity, has index "b2_8";
      $b2_9 isa b-entity, has index "b2_9";
      $b2_10 isa b-entity, has index "b2_10";

      $b3_1 isa b-entity, has index "b3_1";
      $b3_2 isa b-entity, has index "b3_2";
      $b3_3 isa b-entity, has index "b3_3";
      $b3_4 isa b-entity, has index "b3_4";
      $b3_5 isa b-entity, has index "b3_5";
      $b3_6 isa b-entity, has index "b3_6";
      $b3_7 isa b-entity, has index "b3_7";
      $b3_8 isa b-entity, has index "b3_8";
      $b3_9 isa b-entity, has index "b3_9";
      $b3_10 isa b-entity, has index "b3_10";

      $b4_1 isa b-entity, has index "b4_1";
      $b4_2 isa b-entity, has index "b4_2";
      $b4_3 isa b-entity, has index "b4_3";
      $b4_4 isa b-entity, has index "b4_4";
      $b4_5 isa b-entity, has index "b4_5";
      $b4_6 isa b-entity, has index "b4_6";
      $b4_7 isa b-entity, has index "b4_7";
      $b4_8 isa b-entity, has index "b4_8";
      $b4_9 isa b-entity, has index "b4_9";
      $b4_10 isa b-entity, has index "b4_10";

      $b5_1 isa b-entity, has index "b5_1";
      $b5_2 isa b-entity, has index "b5_2";
      $b5_3 isa b-entity, has index "b5_3";
      $b5_4 isa b-entity, has index "b5_4";
      $b5_5 isa b-entity, has index "b5_5";
      $b5_6 isa b-entity, has index "b5_6";
      $b5_7 isa b-entity, has index "b5_7";
      $b5_8 isa b-entity, has index "b5_8";
      $b5_9 isa b-entity, has index "b5_9";
      $b5_10 isa b-entity, has index "b5_10";

      $b6_1 isa b-entity, has index "b6_1";
      $b6_2 isa b-entity, has index "b6_2";
      $b6_3 isa b-entity, has index "b6_3";
      $b6_4 isa b-entity, has index "b6_4";
      $b6_5 isa b-entity, has index "b6_5";
      $b6_6 isa b-entity, has index "b6_6";
      $b6_7 isa b-entity, has index "b6_7";
      $b6_8 isa b-entity, has index "b6_8";
      $b6_9 isa b-entity, has index "b6_9";
      $b6_10 isa b-entity, has index "b6_10";


      # (from: $a0, to: $b1_{j}) isa Q; for 1 <= j <= n
      (from: $a0, to: $b1_1) isa Q;
      (from: $a0, to: $b1_2) isa Q;
      (from: $a0, to: $b1_3) isa Q;
      (from: $a0, to: $b1_4) isa Q;
      (from: $a0, to: $b1_5) isa Q;
      (from: $a0, to: $b1_6) isa Q;
      (from: $a0, to: $b1_7) isa Q;
      (from: $a0, to: $b1_8) isa Q;
      (from: $a0, to: $b1_9) isa Q;
      (from: $a0, to: $b1_10) isa Q;


      # (from: $b{i}_{j}, to: $b{i+1}_{j}) isa Q; for 1 <= j <= n; for 1 <= i <= m
      (from: $b1_1, to: $b2_1) isa Q;
      (from: $b2_1, to: $b3_1) isa Q;
      (from: $b3_1, to: $b4_1) isa Q;
      (from: $b4_1, to: $b5_1) isa Q;
      (from: $b5_1, to: $b6_1) isa Q;

      (from: $b1_2, to: $b2_2) isa Q;
      (from: $b2_2, to: $b3_2) isa Q;
      (from: $b3_2, to: $b4_2) isa Q;
      (from: $b4_2, to: $b5_2) isa Q;
      (from: $b5_2, to: $b6_2) isa Q;

      (from: $b1_3, to: $b2_3) isa Q;
      (from: $b2_3, to: $b3_3) isa Q;
      (from: $b3_3, to: $b4_3) isa Q;
      (from: $b4_3, to: $b5_3) isa Q;
      (from: $b5_3, to: $b6_3) isa Q;

      (from: $b1_4, to: $b2_4) isa Q;
      (from: $b2_4, to: $b3_4) isa Q;
      (from: $b3_4, to: $b4_4) isa Q;
      (from: $b4_4, to: $b5_4) isa Q;
      (from: $b5_4, to: $b6_4) isa Q;

      (from: $b1_5, to: $b2_5) isa Q;
      (from: $b2_5, to: $b3_5) isa Q;
      (from: $b3_5, to: $b4_5) isa Q;
      (from: $b4_5, to: $b5_5) isa Q;
      (from: $b5_5, to: $b6_5) isa Q;

      (from: $b1_6, to: $b2_6) isa Q;
      (from: $b2_6, to: $b3_6) isa Q;
      (from: $b3_6, to: $b4_6) isa Q;
      (from: $b4_6, to: $b5_6) isa Q;
      (from: $b5_6, to: $b6_6) isa Q;

      (from: $b1_7, to: $b2_7) isa Q;
      (from: $b2_7, to: $b3_7) isa Q;
      (from: $b3_7, to: $b4_7) isa Q;
      (from: $b4_7, to: $b5_7) isa Q;
      (from: $b5_7, to: $b6_7) isa Q;

      (from: $b1_8, to: $b2_8) isa Q;
      (from: $b2_8, to: $b3_8) isa Q;
      (from: $b3_8, to: $b4_8) isa Q;
      (from: $b4_8, to: $b5_8) isa Q;
      (from: $b5_8, to: $b6_8) isa Q;

      (from: $b1_9, to: $b2_9) isa Q;
      (from: $b2_9, to: $b3_9) isa Q;
      (from: $b3_9, to: $b4_9) isa Q;
      (from: $b4_9, to: $b5_9) isa Q;
      (from: $b5_9, to: $b6_9) isa Q;

      (from: $b1_10, to: $b2_10) isa Q;
      (from: $b2_10, to: $b3_10) isa Q;
      (from: $b3_10, to: $b4_10) isa Q;
      (from: $b4_10, to: $b5_10) isa Q;
      (from: $b5_10, to: $b6_10) isa Q;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (from: $x, to: $y) isa P;
        $x has index 'a0';
      get $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 60
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match $y isa b-entity;
      """
    Then materialised and reasoned databases are the same size


  Scenario: linear transitivity matrix test

  test 6.9 from Cao - Methods for evaluating queries to Horn knowledge bases in first-order logic p.82

    Given for each session, graql define
      """
      define

      entity2 sub entity,
        owns index @key,
        plays S:from,
        plays S:to;
      a-entity sub entity2;

      P sub relation, relates from, relates to;
      entity2 plays P:from, plays P:to;

      Q sub relation, relates from, relates to;
      entity2 plays Q:from, plays Q:to;

      S sub relation, relates from, relates to;

      index sub attribute, value string;

      rule rule-1: when {
        (from: $x, to: $y) isa Q;
      } then {
        (from: $x, to: $y) isa P;
      };

      rule rule-2: when {
        (from: $x, to: $z) isa Q;
        (from: $z, to: $y) isa P;
      } then {
        (from: $x, to: $y) isa P;
      };

      rule rule-3: when {
        (from: $x, to: $y) isa P;
      } then {
        (from: $x, to: $y) isa S;
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

      $a isa entity2, has index "a";

      # $a{i}_{j} isa a-entity, has index "a{i}_{j}"; for 1 <= i <= n; for 1 <= j <= m
      $a1_1 isa a-entity, has index "a1_1";
      $a1_2 isa a-entity, has index "a1_2";
      $a1_3 isa a-entity, has index "a1_3";
      $a1_4 isa a-entity, has index "a1_4";
      $a1_5 isa a-entity, has index "a1_5";

      $a2_1 isa a-entity, has index "a2_1";
      $a2_2 isa a-entity, has index "a2_2";
      $a2_3 isa a-entity, has index "a2_3";
      $a2_4 isa a-entity, has index "a2_4";
      $a2_5 isa a-entity, has index "a2_5";

      $a3_1 isa a-entity, has index "a3_1";
      $a3_2 isa a-entity, has index "a3_2";
      $a3_3 isa a-entity, has index "a3_3";
      $a3_4 isa a-entity, has index "a3_4";
      $a3_5 isa a-entity, has index "a3_5";

      $a4_1 isa a-entity, has index "a4_1";
      $a4_2 isa a-entity, has index "a4_2";
      $a4_3 isa a-entity, has index "a4_3";
      $a4_4 isa a-entity, has index "a4_4";
      $a4_5 isa a-entity, has index "a4_5";

      $a5_1 isa a-entity, has index "a5_1";
      $a5_2 isa a-entity, has index "a5_2";
      $a5_3 isa a-entity, has index "a5_3";
      $a5_4 isa a-entity, has index "a5_4";
      $a5_5 isa a-entity, has index "a5_5";

      (from: $a, to: $a1_1) isa Q;

      # (from: $a{i}_{j}, to: $a{i+1}_{j}) isa Q; for 1 <= i < n; for 1 <= j <= m
      (from: $a1_1, to: $a2_1) isa Q;
      (from: $a1_2, to: $a2_2) isa Q;
      (from: $a1_3, to: $a2_3) isa Q;
      (from: $a1_4, to: $a2_4) isa Q;
      (from: $a1_5, to: $a2_5) isa Q;

      (from: $a2_1, to: $a3_1) isa Q;
      (from: $a2_2, to: $a3_2) isa Q;
      (from: $a2_3, to: $a3_3) isa Q;
      (from: $a2_4, to: $a3_4) isa Q;
      (from: $a2_5, to: $a3_5) isa Q;

      (from: $a3_1, to: $a4_1) isa Q;
      (from: $a3_2, to: $a4_2) isa Q;
      (from: $a3_3, to: $a4_3) isa Q;
      (from: $a3_4, to: $a4_4) isa Q;
      (from: $a3_5, to: $a4_5) isa Q;

      (from: $a4_1, to: $a5_1) isa Q;
      (from: $a4_2, to: $a5_2) isa Q;
      (from: $a4_3, to: $a5_3) isa Q;
      (from: $a4_4, to: $a5_4) isa Q;
      (from: $a4_5, to: $a5_5) isa Q;

      # (from: $a{i}_{j}, to: $a{i}_{j+1}) isa Q; for 1 <= i <= n; for 1 <= j < m
      (from: $a1_1, to: $a1_2) isa Q;
      (from: $a1_2, to: $a1_3) isa Q;
      (from: $a1_3, to: $a1_4) isa Q;
      (from: $a1_4, to: $a1_5) isa Q;

      (from: $a2_1, to: $a2_2) isa Q;
      (from: $a2_2, to: $a2_3) isa Q;
      (from: $a2_3, to: $a2_4) isa Q;
      (from: $a2_4, to: $a2_5) isa Q;

      (from: $a3_1, to: $a3_2) isa Q;
      (from: $a3_2, to: $a3_3) isa Q;
      (from: $a3_3, to: $a3_4) isa Q;
      (from: $a3_4, to: $a3_5) isa Q;

      (from: $a4_1, to: $a4_2) isa Q;
      (from: $a4_2, to: $a4_3) isa Q;
      (from: $a4_3, to: $a4_4) isa Q;
      (from: $a4_4, to: $a4_5) isa Q;

      (from: $a5_1, to: $a5_2) isa Q;
      (from: $a5_2, to: $a5_3) isa Q;
      (from: $a5_3, to: $a5_4) isa Q;
      (from: $a5_4, to: $a5_5) isa Q;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match
        (from: $x, to: $y) isa P;
        $x has index 'a';
      get $y;
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 25
    Given for each session, transaction closes
    Given for each session, open transactions of type: read
    Then answer set is equivalent for graql query
      """
      match $y isa a-entity;
      """
    Then materialised and reasoned databases are the same size
