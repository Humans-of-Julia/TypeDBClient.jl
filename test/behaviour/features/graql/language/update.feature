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
Feature: Graql Update Query

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
        plays parenthood:parent,
        plays parenthood:child,
        owns name,
        owns ref @key;
      friendship sub relation,
        relates friend,
        owns ref @key;
      parenthood sub relation,
        relates parent,
        relates child;
      name sub attribute, value string;
      ref sub attribute, value long;
      """
    Given transaction commits

    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write


  Scenario: Update owned attribute without side effects on other owners
    Given get answers of graql insert
      """
      insert
        $x isa person, has name "Alex", has ref 0;
        $y isa person, has name "Alex", has ref 1;
      """
    Given uniquely identify answer concepts
      | x         | y         |
      | key:ref:0 | key:ref:1 |
    Given transaction commits
    Given session opens transaction of type: write
    When graql update
      """
      match
      $x isa person, has ref 1, has $n;
      $n isa name;
      delete $x has $n;
      insert $x has name "Bob";
      """
    Then transaction commits
    When session opens transaction of type: read
    When get answers of graql match
      """
      match $x isa person, has name $n;
      """
    Then uniquely identify answer concepts
      | x          | n               |
      | key:ref:0  | value:name:Alex |
      | key:ref:1  | value:name:Bob  |

  Scenario: Deleting the last roleplayer of a relation means it cannot be updated
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex", has ref 0;
      $y isa person, has name "Bob", has ref 1;
      $r (friend: $x) isa friendship, has ref 0;
      """
    Given transaction commits
    Given session opens transaction of type: write
    When graql update; throws exception
      """
      match
      $x isa person, has name "Alex";
      $y isa person, has name "Bob";
      $r (friend: $x) isa friendship;
      delete $r (friend: $x);
      insert $r (friend: $y);
      """

  Scenario: Roleplayer exchange
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex", has ref 0;
      $y isa person, has name "Bob", has ref 1;
      $r (parent: $x, child:$y) isa parenthood;
      """
    Given transaction commits
    Given session opens transaction of type: write
    When graql update
      """
      match $r (parent: $x, child: $y) isa parenthood;
      delete $r isa parenthood;
      insert (parent: $y, child: $x) isa parenthood;
      """


  Scenario: Unrelated insertion
    Given get answers of graql insert
      """
      insert
      $x isa person, has name "Alex", has ref 0;
      """
    Given transaction commits
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    When graql update; throws exception
      """
      match $p isa person;
      delete $p isa person;
      insert $x isa entity;
      """


  Scenario: Complex migration
    Given get answers of graql insert
      """
      insert
      $u isa person, has name "Alex", has ref 0;
      $v isa person, has name "Bob", has ref 1;
      $w isa person, has name "Charlie", has ref 2;
      $x isa person, has name "Darius", has ref 3;
      $y isa person, has name "Alex", has ref 4;
      $z isa person, has name "Bob", has ref 5;
      """
    Given transaction commits
    Given connection close all sessions
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    Given graql define
      """
      define
      nameclass sub entity,
        owns name @key,
        plays naming:name;
      naming sub relation,
        relates named,
        relates name;
      person plays naming:named;
      """
    Given transaction commits
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write
    When graql insert
      """
      match $att isa name;
      insert $x isa nameclass, has $att;
      """
    When graql update
      """
      match
      $p isa person, has name $n;
      $nc isa nameclass, has name $n;
      delete $p has $n;
      insert (named: $p, name: $nc) isa naming;
      """
    Then transaction commits
    When session opens transaction of type: read
    When get answers of graql match
      """
      match
      (named: $p, name: $nc) isa naming;
      $nc has name $n;
      """
    Then uniquely identify answer concepts
      | p          | n                  |
      | key:ref:0  | value:name:Alex    |
      | key:ref:1  | value:name:Bob     |
      | key:ref:2  | value:name:Charlie |
      | key:ref:3  | value:name:Darius  |
      | key:ref:4  | value:name:Alex    |
      | key:ref:5  | value:name:Bob     |

    When get answers of graql match
      """
      match
      $p isa person;
      $p has name $n;
      """
    Then answer size is: 0



