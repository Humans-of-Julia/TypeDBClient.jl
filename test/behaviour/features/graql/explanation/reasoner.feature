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
Feature: Graql Reasoning Explanation

  Only scenarios where there is only one possible resolution path can be tested in this way

  Background: Initialise a session and transaction for each scenario
    Given connection has been opened
    Given connection open schema session for database: test_explanation
    Given transaction is initialised

  @ignore-client-java
  Scenario: a rule explanation is given when a rule is applied
    Given graql define
      """
      define

      name sub attribute, value string;
      company-id sub attribute, value long;

      company sub entity,
        owns name,
        owns company-id @key;

      rule company-has-name: when {
         $c isa company;
      } then {
         $c has name "the-company";
      };
      """

    When graql insert
      """
      insert
      $x isa company, has company-id 0;
      """

    Then get answers of graql match
      """
      match $co has name $n;
      """

    Then concept identifiers are
      |     | check | value            |
      | CO  | key   | company-id:0     |
      | CON | value | name:the-company |

    Then uniquely identify answer concepts
      | co               | n                      |
      | key:company-id:0 | value:name:the-company |

    Then rules are
      |                  | when                 | then                            |
      | company-has-name | { $c isa company; }; | { $c has name "the-company"; }; |

    Then answers contain explanation tree
      |   | children | vars  | identifiers | explanation      | pattern                                                               |
      | 0 | 1        | co, n | CO, CON     | company-has-name | { $co iid <answer.co.iid>; $co has name $n; $n iid <answer.n.iid>; }; |
      | 1 | -        | c     | CO          | lookup           | { $c isa company; $c iid <answer.c.iid>; };                           |

  @ignore-client-java
  Scenario: nested rule explanations are given when multiple rules are applied
    Given graql define
      """
      define

      name sub attribute,
          value string;

      is-liable sub attribute,
          value boolean;

      company-id sub attribute,
          value long;

      company sub entity,
          owns company-id @key,
          owns name,
          owns is-liable;

      rule company-has-name: when {
          $c1 isa company;
      } then {
          $c1 has name "the-company";
      };

      rule company-is-liable: when {
          $c2 isa company, has name $name; $name "the-company";
      } then {
          $c2 has is-liable true;
      };
      """

    When graql insert
      """
      insert
      $co isa company, has company-id 0;
      """

    Then get answers of graql match
      """
      match $co has is-liable $l;
      """

    Then concept identifiers are
      |     | check | value            |
      | CO  | key   | company-id:0     |
      | CON | value | name:the-company |
      | LIA | value | is-liable:true   |

    Then uniquely identify answer concepts
      | co               | l                    |
      | key:company-id:0 | value:is-liable:true |

    Then rules are
      |                   | when                                                       | then                             |
      | company-has-name  | { $c1 isa company; };                                      | { $c1 has name "the-company"; }; |
      | company-is-liable | { $c2 isa company, has name $name; $name "the-company"; }; | { $c2 has is-liable true; };     |

    Then answers contain explanation tree
      |   | children | vars     | identifiers | explanation       | pattern                                                                                                                 |
      | 0 | 1        | co, l    | CO, LIA     | company-is-liable | { $co iid <answer.co.iid>; $co has is-liable $l; $l iid <answer.l.iid>; };                                              |
      | 1 | 2        | c2, name | CO, CON     | company-has-name  | { $c2 isa company; $c2 has name $name; $name = "the-company"; $c2 iid <answer.c2.iid>; $name iid <answer.name.iid>; }; |
      | 2 | -        | c1       | CO          | lookup            | { $c1 isa company; $c1 iid <answer.c1.iid>; };                                                                          |

  @ignore-client-java
  Scenario: a join explanation can be given directly and inside a rule explanation
    Given graql define
      """
      define
      name sub attribute,
          value string;

      location sub entity,
          abstract,
          owns name @key,
          plays location-hierarchy:superior,
          plays location-hierarchy:subordinate;

      area sub location;
      city sub location;
      country sub location;

      location-hierarchy sub relation,
          relates superior,
          relates subordinate;

      rule location-hierarchy-transitivity: when {
          (superior: $a, subordinate: $b) isa location-hierarchy;
          (superior: $b, subordinate: $c) isa location-hierarchy;
      } then {
          (superior: $a, subordinate: $c) isa location-hierarchy;
      };
      """

    When graql insert
      """
      insert
      $ar isa area, has name "King's Cross";
      $cit isa city, has name "London";
      $cntry isa country, has name "UK";
      (superior: $cntry, subordinate: $cit) isa location-hierarchy;
      (superior: $cit, subordinate: $ar) isa location-hierarchy;
      """

    Then get answers of graql match
      """
      match
      $k isa area, has name $n;
      (superior: $l, subordinate: $k) isa location-hierarchy;
      """

    Then concept identifiers are
      |     | check | value             |
      | KC  | key   | name:King's Cross |
      | UK  | key   | name:UK           |
      | LDN | key   | name:London       |
      | KCN | value | name:King's Cross |

    Then uniquely identify answer concepts
      | k                     | l               | n                       |
      | key:name:King's Cross | key:name:UK     | value:name:King's Cross |
      | key:name:King's Cross | key:name:London | value:name:King's Cross |

    Then rules are
      |                                 | when                                                                                                                 | then                                                         |
      | location-hierarchy-transitivity | { (superior: $a, subordinate: $b) isa location-hierarchy; (superior: $b, subordinate: $c) isa location-hierarchy; }; | { (superior: $a, subordinate: $c) isa location-hierarchy; }; |

    Then answers contain explanation tree
      |   | children | vars    | identifiers | explanation                     | pattern                                                                                                                                                                                                |
      | 0 | 1, 2     | k, l, n | KC, UK, KCN | join                            | { $k isa area; $k has name $n; (superior: $l, subordinate: $k) isa location-hierarchy; $k iid <answer.k.iid>; $n iid <answer.n.iid>; $l iid <answer.l.iid>; };                                         |
      | 1 | -        | k, n    | KC, KCN     | lookup                          | { $k isa area; $k has name $n; $n iid <answer.n.iid>; $k iid <answer.k.iid>; };                                                                                                                        |
      | 2 | 3        | k, l    | KC, UK      | location-hierarchy-transitivity | { (superior: $l, subordinate: $k) isa location-hierarchy; $k isa area; $k iid <answer.k.iid>; $l iid <answer.l.iid>; };                                                                                |
      | 3 | 4, 5     | a, b, c | UK, LDN, KC | join                            | { (superior: $a, subordinate: $b) isa location-hierarchy; (superior: $b, subordinate: $c) isa location-hierarchy; $c isa area; $a iid <answer.a.iid>; $b iid <answer.b.iid>; $c iid <answer.c.iid>; }; |
      | 4 | -        | b, c    | LDN, KC     | lookup                          | { (superior: $b, subordinate: $c) isa location-hierarchy; $c isa area; $b iid <answer.b.iid>; $c iid <answer.c.iid>; };                                                                                |
      | 5 | -        | a, b    | UK, LDN     | lookup                          | { (superior: $a, subordinate: $b) isa location-hierarchy; $b iid <answer.b.iid>; $a iid <answer.a.iid>; };                                                                                             |

    Then answers contain explanation tree
      |   | children | vars    | identifiers  | explanation | pattern                                                                                                                                                        |
      | 0 | 1, 2     | k, l, n | KC, LDN, KCN | join        | { $k isa area; $k has name $n; (superior: $l, subordinate: $k) isa location-hierarchy; $k iid <answer.k.iid>; $n iid <answer.n.iid>; $l iid <answer.l.iid>; }; |
      | 1 | -        | k, n    | KC, KCN      | lookup      | { $k isa area; $k has name $n; $n iid <answer.n.iid>; $k iid <answer.k.iid>; };                                                                                |
      | 2 | -        | k, l    | KC, LDN      | lookup      | { (superior: $l, subordinate: $k) isa location-hierarchy; $k isa area; $k iid <answer.k.iid>; $l iid <answer.l.iid>; };                                        |

  @ignore-client-java
  Scenario: an answer with a more specific type can be retrieved from the cache with correct explanations
    Given graql define
      """
      define

      name sub attribute, value string;

      person-id sub attribute, value long;

      person sub entity,
          owns person-id @key,
          owns name,
          plays siblingship:sibling;

      man sub person;
      woman sub person;

      family-relation sub relation,
        abstract;

      siblingship sub family-relation,
          relates sibling;

      rule a-man-is-called-bob: when {
          $man isa man;
      } then {
          $man has name "Bob";
      };

      rule bobs-sister-is-alice: when {
          $p isa man, has name $nb; $nb "Bob";
          $p1 isa woman, has name $na; $na "Alice";
      } then {
          (sibling: $p, sibling: $p1) isa siblingship;
      };
      """

    When graql insert
      """
      insert
      $a isa woman, has person-id 0, has name "Alice";
      $b isa man, has person-id 1;
      """

    Then concept identifiers are
      |      | check | value       |
      | ALI  | key   | person-id:0 |
      | ALIN | value | name:Alice  |
      | BOB  | key   | person-id:1 |
      | BOBN | value | name:Bob    |

    Then rules are
      |                      | when                                                                                | then                                              |
      | a-man-is-called-bob  | { $man isa man; };                                                                  | { $man has name "Bob"; };                         |
      | bobs-sister-is-alice | { $p isa man, has name $nb; $nb "Bob"; $p1 isa woman, has name $na; $na "Alice"; }; | { (sibling: $p, sibling: $p1) isa siblingship; }; |

    Then get answers of graql match
      """
      match ($w, $m) isa family-relation; $w isa woman;
      """

    Then uniquely identify answer concepts
      | w               | m               |
      | key:person-id:0 | key:person-id:1 |

    Then answers contain explanation tree
      |   | children | vars          | identifiers          | explanation          | pattern                                                                                                                                                                                            |
      | 0 | 1        | w, m          | ALI, BOB             | bobs-sister-is-alice | { (role: $m, role: $w) isa family-relation; $w isa woman; $w iid <answer.w.iid>; $m iid <answer.m.iid>; };                                                                                         |
      | 1 | 2, 3     | p, nb, p1, na | BOB, BOBN, ALI, ALIN | join                 | { $p isa man; $p has name $nb; $nb = "Bob"; $p iid <answer.p.iid>; $nb iid <answer.nb.iid>; $p1 isa woman; $p1 has name $na; $na = "Alice"; $p1 iid <answer.p1.iid>; $na iid <answer.na.iid>; }; |
      | 2 | 4        | p, nb         | BOB, BOBN            | a-man-is-called-bob  | { $p isa man; $p has name $nb; $nb = "Bob"; $p iid <answer.p.iid>; $nb iid <answer.nb.iid>; };                                                                                                    |
      | 3 | -        | p1, na        | ALI, ALIN            | lookup               | { $p1 isa woman; $p1 has name $na; $na = "Alice"; $p1 iid <answer.p1.iid>; $na iid <answer.na.iid>; };                                                                                            |
      | 4 | -        | man           | BOB                  | lookup               | { $man isa man; $man iid <answer.man.iid>; };                                                                                                                                                      |

    Then get answers of graql match
      """
      match (sibling: $w, sibling: $m) isa siblingship; $w isa woman;
      """

    Then uniquely identify answer concepts
      | w               | m               |
      | key:person-id:0 | key:person-id:1 |

    Then answers contain explanation tree
      |   | children | vars          | identifiers          | explanation          | pattern                                                                                                                                                                                            |
      | 0 | 1        | w, m          | ALI, BOB             | bobs-sister-is-alice | { (sibling: $m, sibling: $w) isa siblingship; $w isa woman; $w iid <answer.w.iid>; $m iid <answer.m.iid>; };                                                                                       |
      | 1 | 2, 3     | p, nb, p1, na | BOB, BOBN, ALI, ALIN | join                 | { $p isa man; $p has name $nb; $nb = "Bob"; $p iid <answer.p.iid>; $nb iid <answer.nb.iid>; $p1 isa woman; $p1 has name $na; $na = "Alice"; $p1 iid <answer.p1.iid>; $na iid <answer.na.iid>; }; |
      | 2 | 4        | p, nb         | BOB, BOBN            | a-man-is-called-bob  | { $p isa man; $p has name $nb; $nb = "Bob"; $p iid <answer.p.iid>; $nb iid <answer.nb.iid>; };                                                                                                    |
      | 3 | -        | p1, na        | ALI, ALIN            | lookup               | { $p1 isa woman; $p1 has name $na; $na = "Alice"; $p1 iid <answer.p1.iid>; $na iid <answer.na.iid>; };                                                                                            |
      | 4 | -        | man           | BOB                  | lookup               | { $man isa man; $man iid <answer.man.iid>; };                                                                                                                                                      |

  @ignore-client-java
  Scenario: a query with a disjunction and negated inference has disjunctive and negation explanation but no rule explanation

  A rule explanation is not be given since the rule was only used to infer facts that were later negated

    Given graql define
      """
      define

      name sub attribute,
          value string;

      is-liable sub attribute,
          value boolean;

      company-id sub attribute,
          value long;

      company sub entity,
          owns company-id @key,
          owns name,
          owns is-liable;

      rule company-is-liable: when {
          $c2 isa company, has name $n2; $n2 "the-company";
      } then {
          $c2 has is-liable true;
      };
      """

    When graql insert
      """
      insert
      $c1 isa company, has company-id 0;
      $c1 has name $n1; $n1 "the-company";
      $c2 isa company, has company-id 1;
      $c2 has name $n2; $n2 "another-company";
      """

    Then get answers of graql match
      """
      match $com isa company;
      {$com has name $n1; $n1 "the-company";} or {$com has name $n2; $n2 "another-company";};
      not {$com has is-liable $liability;};
      """

    Then concept identifiers are
      |     | check | value                |
      | ACO | key   | company-id:1         |
      | N2  | value | name:another-company |

    Then uniquely identify answer concepts
      | com              |
      | key:company-id:1 |

    Then rules are
      |                   | when                                                   | then                                |
      | company-is-liable | { $c2 isa company, has name $n2; $n2 "the-company"; }; | { $c2 has is-liable $l; $l true; }; |

    Then answers contain explanation tree
      |   | children | vars    | identifiers | explanation | pattern                                                                                                                                                                                                                                                        |
      | 0 | 1        | com     | ACO         | disjunction | { $com iid <answer.com.iid>; { $com isa company; $com has name $n1; $n1 = "the-company"; not { { $com has is-liable $liability; }; }; } or {$com isa company; $com has name $n2; $n2 = "another-company"; not { { $com has is-liable $liability; }; }; }; }; |
      | 1 | 2        | com, n2 | ACO, N2     | negation    | { $com isa company; $com has name $n2; $n2 = "another-company"; $com iid <answer.com.iid>; $n2 iid <answer.n2.iid>; not { { $com has is-liable $liability; }; }; };                                                                                           |
      | 2 | -        | com, n2 | ACO, N2     | lookup      | { $com isa company; $com has name $n2; $n2 = "another-company"; $com iid <answer.com.iid>; $n2 iid <answer.n2.iid>; };                                                                                                                                        |

  @ignore-client-java
  Scenario: a rule containing a negation gives a rule explanation with a negation explanation inside
    Given graql define
      """
      define

      name sub attribute,
          value string;

      is-liable sub attribute,
          value boolean;

      company-id sub attribute,
          value long;

      company sub entity,
          owns company-id @key,
          owns name,
          owns is-liable;

      rule company-is-liable: when {
          $c2 isa company;
          not {
            $c2 has name $n2; $n2 "the-company";
          };
      } then {
          $c2 has is-liable true;
      };
      """

    When graql insert
      """
      insert
      $c1 isa company, has company-id 0;
      $c1 has name $n1; $n1 "the-company";
      $c2 isa company, has company-id 1;
      $c2 has name $n2; $n2 "another-company";
      """

    Then get answers of graql match
      """
      match $com isa company, has is-liable $lia; $lia true;
      """

    Then concept identifiers are
      |     | check | value          |
      | ACO | key   | company-id:1   |
      | LIA | value | is-liable:true |

    Then uniquely identify answer concepts
      | com              | lia                  |
      | key:company-id:1 | value:is-liable:true |

    Then rules are
      |                   | when                                                                | then                                |
      | company-is-liable | { $c2 isa company; not { $c2 has name $n2; $n2 "the-company"; }; }; | { $c2 has is-liable $l; $l true; }; |

    Then answers contain explanation tree
      |   | children | vars     | identifiers | explanation       | pattern                                                                                                             |
      | 0 | 1        | com, lia | ACO, LIA    | company-is-liable | { $com isa company; $com has is-liable $lia; $lia = true; $com iid <answer.com.iid>; $lia iid <answer.lia.iid>; }; |
      | 1 | 2        | c2       | ACO         | negation          | { $c2 isa company; $c2 iid <answer.c2.iid>; not { { $c2 has name $n2; $n2 = "the-company"; }; }; };                |
      | 2 | -        | c2       | ACO         | lookup            | { $c2 isa company; $c2 iid <answer.c2.iid>; };                                                                      |

  @ignore-client-java
  Scenario: a query containing multiple negations with inferred conjunctions inside has just one negation explanation

  A rule explanation is not be given since the rule was only used to infer facts that were later negated

    Given graql define
      """
      define

      name sub attribute,
          value string;

      is-liable sub attribute,
          value boolean;

      company-id sub attribute,
          value long;

      company sub entity,
          owns company-id @key,
          owns name,
          owns is-liable;

      rule company-is-liable: when {
          $c2 isa company;
          $c2 has name $n2; $n2 "the-company";
      } then {
          $c2 has is-liable true;
      };
      """

    When graql insert
      """
      insert
      $c1 isa company, has company-id 0;
      $c1 has name $n1; $n1 "the-company";
      $c2 isa company, has company-id 1;
      $c2 has name $n2; $n2 "another-company";
      """

    Then get answers of graql match
      """
      match $com isa company; not { $com has is-liable $lia; $lia true; }; not { $com has name $n; $n "the-company"; };
      """

    Then concept identifiers are
      |     | check | value        |
      | ACO | key   | company-id:1 |

    Then uniquely identify answer concepts
      | com              |
      | key:company-id:1 |

    Then rules are
      |                   | when                                                      | then                                |
      | company-is-liable | { $c2 isa company; $c2 has name $n2; $n2 "the-company"; } | { $c2 has is-liable $l; $l true; }; |

    Then answers contain explanation tree
      |   | children | vars | identifiers | explanation | pattern                                                                                                                                                     |
      | 0 | 1        | com  | ACO         | negation    | { $com isa company; $com iid <answer.com.iid>; not { { $com has is-liable $lia; $lia = true; }; }; not { { $com has name $n; $n = "the-company"; }; }; }; |
      | 1 | -        | com  | ACO         | lookup      | { $com isa company; $com iid <answer.com.iid>; };                                                                                                           |
