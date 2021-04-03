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

Feature: Graql Rule Validation

  Background: Initialise a session and transaction for each scenario
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      person sub entity,
        plays employment:employee, plays scholarship:scholar,
        plays apprenticeship:apprentice,
        owns name, owns nickname, owns email @key;
      employment sub relation, relates employee, owns start-date;
      self-employment sub employment;
      scholarship sub relation, relates scholar;
      apprenticeship sub relation, relates apprentice;
      name sub attribute, value string;
      nickname sub attribute, value string;
      email sub attribute, value string;
      start-date sub attribute, value datetime;
      """


  # Note: These tests verify only the ability to create rules, and are not concerned with their application.

  Scenario: a rule can infer both an attribute and its ownership
    Given graql define
      """
      define
      
      rule robert-has-nickname-bob: when {
        $p isa person, has name "Robert";
      } then {
        $p has nickname "Bob";
      };
      """
    Then transaction commits


  # Keys are validated at commit time, so integrity will not be harmed by writing one in a rule.
  Scenario: a rule can infer a 'key'
    Given graql define
      """
      define
      rule john-smiths-email: when {
        $p has name "John Smith";
      } then {
        $p has email "john.smith@gmail.com";
      };
      """
    Then transaction commits


  Scenario: when a rule has no 'when' clause, an error is thrown
    Then graql define; throws exception
      """
      define

      has-nickname-bob sub rule,
      then {
        $p has nickname "Bob";
      };
      """


  Scenario: when a rule has no 'then' clause, an error is thrown
    Then graql define; throws exception
      """
      define

      rule robert: when {
        $p has name "Robert";
      };
      """


  Scenario: when a rule's 'when' clause is empty, an error is thrown
    Then graql define; throws exception
      """
      define

      rule has-nickname-bob:
      when {
      } then {
        $p has nickname "Bob";
      };
      """


  Scenario: when a rule's 'then' clause is empty, an error is thrown
    Then graql define; throws exception
      """
      define

      rule robert: when {
        $p has name "Robert";
      } then {
      };
      """


  Scenario: a rule can have negation in its 'when' clause
    Given graql define
      """
      define
      only-child sub attribute, value boolean;
      siblings sub relation, relates sibling;
      person plays siblings:sibling, owns only-child;
      rule only-child-rule: when {
        $p isa person;
        not {
          (sibling: $p, sibling: $p2) isa siblings;
        };
      } then {
        $p has only-child true;
      };
      """
    Then transaction commits


  Scenario: when a rule has a negation block whose pattern variables are all unbound outside it, an error is thrown
    Then graql define; throws exception
      """
      define
      has-robert sub attribute, value boolean;
      register sub entity, owns has-robert;
      rule register-has-no-robert: when {
        $register isa register;
        not {
          $p isa person, has name "Robert";
        };
      } then {
        $register has has-robert false;
      };
      """


  Scenario: when a rule has nested negation, an error is thrown
    Then graql define; throws exception
      """
      define
      rule unemployed-robert-maybe-doesnt-not-have-nickname-bob: when {
        $p isa person;
        not {
          (employee: $p) isa employment;
          not {
            $p has name "Robert";
          };
        };
      } then {
        $p has nickname "Bob";
      };
      """


  Scenario: when a rule has multiple negations, no error is thrown
    Then graql define
      """
      define

      residence sub relation, relates resident;
      person owns nickname, plays residence:resident;
      rule unemployed-homeless-robert-has-nickname-bob: when {
        $p isa person, has name "Robert";
        not {
          (employee: $p) isa employment;
        };
        not {
          (resident: $p) isa residence;
        };
      } then {
        $p has nickname "Bob";
      };
      """


  Scenario: a rule can have a conjunction in a negation
    Then graql define
      """
      define

      residence sub relation, relates resident;
      person owns nickname, plays residence:resident;

      rule unemployed-homeless-robert-has-nickname-bob: when {
        $p isa person, has name "Robert";
        not {
          (employee: $p) isa employment;
          (resident: $p) isa residence;
        };
      } then {
        $p has nickname "Bob";
      };
      """


  Scenario: when a rule has two conclusions, an error is thrown
    Then graql define; throws exception
      """
      define
      rule robert-has-nicknames-bob-and-bobby: when {
        $p has name "Robert";
      } then {
        $p has nickname "Bob";
        $p has nickname "Bobby";
      };
      """


  Scenario: a rule can use conjunction in its 'when' clause
    Given graql define
      """
      define
      person plays both-named-robert:named-robert;
      both-named-robert sub relation, relates named-robert;
      rule two-roberts-are-both-named-robert: when {
        $p isa person, has name "Robert";
        $p2 isa person, has name "Robert";
      } then {
        (named-robert: $p, named-robert: $p2) isa both-named-robert;
      };
      """
    Then transaction commits


  Scenario: when a rule contains a disjunction, an error is thrown
    Then graql define; throws exception
      """
      define
      rule sophie-and-fiona-have-nickname-fi: when {
        $p isa person;
        {$p has name "Sophie";} or {$p has name "Fiona";};
      } then {
        $p has nickname "Fi";
      };
      """


  Scenario: when a rule contains an unbound variable in the 'then' clause, an error is thrown
    Then graql define; throws exception
      """
      define
      rule i-did-a-bad-typo: when {
        $p has name "I am a person";
      } then {
        $q has nickname "Who am I?";
      };
      """


  Scenario: when a rule has an undefined attribute set in its 'then' clause, an error is thrown
    Given graql define; throws exception
      """
      define
      rule boudicca-is-1960-years-old: when {
        $person isa person, has name "Boudicca";
      } then {
        $person has age 1960;
      };
      """


  Scenario: when a rule attaches an attribute to a type that can't have that attribute, an error is thrown
    Given graql define; throws exception
      """
      define
      age sub attribute, value long;
      rule boudicca-is-1960-years-old: when {
        $person isa person, has name "Boudicca";
      } then {
        $person has age 1960;
      };
      """


  Scenario: when a rule creates an attribute value that doesn't match the attribute's type, an error is thrown
    Then graql define; throws exception
      """
      define
      rule may-has-nickname-5: when {
        $p has name "May";
      } then {
        $p has nickname 5;
      };
      """


  Scenario: when a rule infers a relation whose type doesn't exist, an error is thrown
    Then graql define; throws exception
      """
      define
      rule bonnie-and-clyde-are-partners-in-crime: when {
        $bonnie isa person, has name "Bonnie";
        $clyde isa person, has name "Clyde";
      } then {
        (criminal: $bonnie, sidekick: $clyde) isa partners-in-crime;
      };
      """


  Scenario: when a rule infers a relation with an incorrect roleplayer, an error is thrown
    Then graql define; throws exception
      """
      define
      partners-in-crime sub relation, relates criminal, relates sidekick;
      person plays partners-in-crime:criminal;
      rule bonnie-and-clyde-are-partners-in-crime: when {
        $bonnie isa person, has name "Bonnie";
        $clyde isa person, has name "Clyde";
      } then {
        (criminal: $bonnie, sidekick: $clyde) isa partners-in-crime;
      };
      """


  Scenario: when a rule infers an abstract relation, an error is thrown
    Then graql define; throws exception
      """
      define
      partners-in-crime sub relation, abstract, relates criminal, relates sidekick;
      person plays partners-in-crime:criminal, plays partners-in-crime:sidekick;
      rule bonnie-and-clyde-are-partners-in-crime: when {
        $bonnie isa person, has name "Bonnie";
        $clyde isa person, has name "Clyde";
      } then {
        (criminal: $bonnie, sidekick: $clyde) isa partners-in-crime;
      };
      """


  Scenario: when a rule infers an abstract attribute value, an error is thrown
    Then graql define; throws exception
      """
      define
      number-of-devices sub attribute, value long, abstract;
      person owns number-of-devices;
      rule karl-is-allergic-to-technology: when {
        $karl isa person, has name "Karl";
      } then {
        $karl has number-of-devices 0;
      };
      """


  Scenario: when defining a rule to generate new entities from existing ones, an error is thrown
    Given graql define
      """
      define

      baseEntity sub entity;
      derivedEntity sub entity;
      """

    Then graql define; throws exception
      """
      define
      rule rule-1: when {
          $x isa baseEntity;
      } then {
          $y isa derivedEntity;
      };
      """


  Scenario: when defining a rule to generate new entities from existing relations, an error is thrown
    Given graql define
      """
      define

      baseEntity sub entity,
          plays baseRelation:role1,
          plays baseRelation:role2;

      derivedEntity sub entity,
          plays baseRelation:role1,
          plays baseRelation:role2;

      baseRelation sub relation,
          relates role1,
          relates role2;
      """

    Then graql define; throws exception
      """
      define
      rule rule-1: when {
          (role1:$x, role2:$y) isa baseRelation;
          (role1:$y, role2:$z) isa baseRelation;
      } then {
          $u isa derivedEntity;
      };
      """


  Scenario: when defining a rule to generate new relations from existing ones, an error is thrown
    Given graql define
      """
      define

      baseEntity sub entity,
          plays baseRelation:role1,
          plays baseRelation:role2;

      baseRelation sub relation,
          relates role1,
          relates role2;
      """

    Then graql define; throws exception
      """
      define
      rule rule-1: when {
          (role1:$x, role2:$y) isa baseRelation;
          (role1:$y, role2:$z) isa baseRelation;
      } then {
          $u (role1:$x, role2:$z) isa baseRelation;
      };
      """


  Scenario: when defining a rule to infer an additional type that is missing a necessary attribute, an error is thrown
    Given graql define
      """
      define
      dog sub entity;
      """

    Then graql define; throws exception
      """
      define
      rule romeo-is-a-dog: when {
        $x isa person, has name "Romeo";
      } then {
        $x isa dog;
      };
      """


  Scenario: when a rule negates its conclusion in the 'when', causing a (self-)loop, an error is thrown
    Ensure rule stratification is possible
    Then graql define
      """
      define
      rule there-are-no-unemployed: when {
        $person isa person;
        not {
          (employee: $person) isa employment;
        };
      } then {
        (employee: $person) isa employment;
      };
      """
    Then transaction commits; throws exception

  Scenario: When multiple rules result in a loop with negation, an error is thrown
    Then graql define
      """
      define
      rule scholar-is-employee: when {
        $person isa person;
        (scholar: $person) isa scholarship;
      } then {
        (employee: $person) isa employment;
      };

      rule unemployed-is-apprentice: when {
        $person isa person;
        not { (employee: $person) isa employment;};
      } then {
        (apprentice: $person) isa apprenticeship;
      };

      rule nonapprentice-is-scholar: when {
        $person isa person;
        not { (apprentice: $person) isa apprenticeship;};
      } then {
        (scholar: $person) isa scholarship;
      };
      """
    Then transaction commits; throws exception

  Scenario: When rules are mutually recursive via negated predicates (strictly negative loop), an error is thrown
    Then graql define
      """
      define
      rule employed-nonscholar-is-apprentice: when {
        (employee: $person) isa employment;
        not { (scholar: $person) isa scholarship;};
      } then {
        (apprentice: $person) isa apprenticeship;
      };

      rule employed-nonapprentice-is-scholar: when {
        (employee: $person) isa employment;
        not { (apprentice: $person) isa apprenticeship;};
      } then {
        (scholar: $person) isa scholarship;
      };
      """
    Then transaction commits; throws exception

  Scenario: When rule creates a loop with negation within a type hierarchy via specialisation, an error is thrown
    Then graql define
      """
      define
      rule unemployed-are-selfemployed: when {
        $person isa person;
        not { (employee: $person) isa employment;};
      } then {
        (employee: $person) isa self-employment;
      };
      """
    Then transaction commits; throws exception

  Scenario: When rule generalises a negated type, the rule commits
    Then graql define
      """
      define
      rule nonselfemployed-are-employed: when {
        $person isa person;
        not { (employee: $person) isa self-employment;};
      } then {
        (employee: $person) isa employment;
      };
      """
    Then transaction commits

  Scenario: when a rule negates itself, but only in the rule body, the rule commits
    Given graql define
      """
      define
      rule crazy-rule: when {
        $p isa person;
        not { $p isa person;};
      } then {
        (employee: $p) isa employment;
      };
      """
    Then transaction commits


    Scenario: when a rule negates itself in the rule body, the rule commits even if that cycle involves a then clause in another rule
      Given graql define
      """
      define

      rule crazy-rule: when {
        $p isa person;
        (employee: $p) isa employment;
        not { (employee: $p) isa employment;};
      } then {
        (scholar: $p) isa scholarship;
      };

      rule another-rule: when {
        $p isa person;
      } then {
        (employee: $p) isa employment;
      };
      """
      Then transaction commits

    Scenario: rules with cyclic inferences are allowed as long as there is no negation
      When graql define
      """
      define

      rule employed-are-scholars: when {
        $p isa person;
        (employee: $p) isa employment;
      } then {
        (scholar: $p) isa scholarship;
      };

      rule scholars-are-employed:
      when {
        $p isa person;
        (scholar: $p) isa scholarship;
      } then {
        (employee: $p) isa employment;
      };
      """
      Then transaction commits


  Scenario: when a rule has a conjunction as the conclusion, an error is thrown
    When graql define; throws exception
    """
    define

    rule people-are-employed-scholars:
    when {
      $p isa person;
    } then {
        (scholar: $p) isa scholarship;
        (employee: $p) isa employment;
    };

    """


  Scenario: when a rule has a down-cast in a rule conclusion, an error is thrown
    When graql define; throws exception
      """
      define

      man sub person;

      rule all-bobs-are-men:
      when {
        $p isa person;
        $p has name 'bob';
      } then {
        $p isa man;
      };
      """


    Scenario: when a rule has a side-cast in a rule, an error is thrown
      When graql define; throws exception
      """
      define

      person owns age;

      age sub attribute, value long;

      man sub person;
      boy sub person;

      rule male-children-are-boys:
      when {
        $p isa person;
        $p has age $a;
        $a < 18;
      } then {
        $p isa boy;
      };
      """


  Scenario: when a rule adds a role to an existing relation, an error is thrown
    Checks adding new roles to existing relationships is not allowed
    When graql define; throws exception
      """
      define

      rule add-bob-to-all-employment:
      when {
        $r isa employment;
        $p isa person, has name bob;
      } then {
        $r (employee: $p) isa employment;
      };
      """


  Scenario: if a rule's body uses a type that doesn't exist, an error is thrown
    When graql define; throws exception
      """
      define

      rule all-men-are-employed:
      when {
        $m isa man;
      } then {
        (employee: $m) isa employment;
      };
      """


  Scenario: if a rule that uses a missing type within a negation, an error is thrown
    When graql define; throws exception
      """
      define

      rule all-men-are-employed:
      when {
        $p isa person;
        not {$p isa woman};
      } then {
        (employee: $p) isa employment;
      };
      """


  Scenario: a rule may infer a named variable for an attribute if the attribute type is left out
    When graql define
      """
      define

      rule robert-has-nickname-bob:
      when {
        $p isa person, has name 'robert';
        (employee: $p) isa employment;
        $bob 'bob' isa nickname;
      } then {
        $p has $bob;
      };
      """
    Then transaction commits


  Scenario: a rule may infer an attribute type when the value is concrete
    When graql define
    """
    define

    rule robert-has-nickname-bob:
      when {
        $p isa person, has name 'robert';
        (employee: $p) isa employment;
      } then {
        $p has nickname 'bob';
      };
    """
    Then transaction commits


  Scenario: if a rule infers both an attribute type and a named variable, an error is thrown
    When graql define; throws exception
    """
    define

    rule robert-has-nickname-bob:
      when {
        $p isa person, has name 'robert';
        (employee: $p) isa employment;
        $b 'bob' isa nickname;
      } then {
        $p has nickname $b;
      };
    """


  Scenario: a rule may have a clause asserting both an attribute type and a named variable within its when clause
    When graql define
    """
    define

    surname sub attribute, value string;

    person owns surname,
    plays family-relation:relative;

    family-relation sub relation,
    relates relative;

    rule surnames-are-family-names:
    when {
      $p isa person, has surname $name;
      $q isa person, has surname $name;
    } then {
      (relative: $p, relative: $q) isa family-relation;
    };
    """
    Then transaction commits

