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
Feature: Concept Relation

  Background:
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write
    # Write schema for the test scenarios
    Given put attribute type: username, with value type: string
    Given put attribute type: license, with value type: string
    Given put attribute type: date, with value type: datetime
    Given put relation type: marriage
    Given relation(marriage) set relates role: wife
    Given relation(marriage) set relates role: husband
    Given relation(marriage) set owns key type: license
    Given relation(marriage) set owns attribute type: date
    Given put entity type: person
    Given entity(person) set owns key type: username
    Given entity(person) set plays role: marriage:wife
    Given entity(person) set plays role: marriage:husband
    Given transaction commits
    Given connection close all sessions
    Given connection open data session for database: grakn
    Given session opens transaction of type: write

  Scenario: Relation with role players can be created and role players can be retrieved
    When $m = relation(marriage) create new instance with key(license): m
    Then relation $m is null: false
    Then relation $m has type: marriage
    Then relation(marriage) get instances contain: $m
    When $a = entity(person) create new instance with key(username): alice
    When $b = entity(person) create new instance with key(username): bob
    When relation $m add player for role(wife): $a
    When relation $m add player for role(husband): $b
    Then relation $m is null: false
    Then relation $m has type: marriage
    Then relation(marriage) get instances contain: $m
    Then relation $m get players for role(wife) contain: $a
    Then relation $m get players for role(husband) contain: $b
    Then relation $m get players contain: $a
    Then relation $m get players contain: $b
    Then relation $m get players contain:
      | wife    | $a |
      | husband | $b |
    When transaction commits
    When session opens transaction of type: read
    When $m = relation(marriage) get instance with key(license): m
    Then relation $m is null: false
    Then relation $m has type: marriage
    Then relation(marriage) get instances contain: $m
    When $a = entity(person) get instance with key(username): alice
    When $b = entity(person) get instance with key(username): bob
    Then relation $m get players for role(wife) contain: $a
    Then relation $m get players for role(husband) contain: $b
    Then relation $m get players contain: $a
    Then relation $m get players contain: $b
    Then relation $m get players contain:
      | wife    | $a |
      | husband | $b |

  Scenario: Relation without role player cannot be created
    When $m = relation(marriage) create new instance with key(license): m
    Then relation(marriage) get instances contain: $m
    Then relation $m is null: false
    Then relation $m has type: marriage
    Then transaction commits; throws exception
#
  Scenario: Role players can get relations
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) create new instance with key(username): alice
    When $b = entity(person) create new instance with key(username): bob
    Then entity $a get relations(marriage:wife) do not contain: $m
    Then entity $b get relations(marriage:husband) do not contain: $m
    When relation $m add player for role(wife): $a
    When relation $m add player for role(husband): $b
    Then entity $a get relations(marriage:wife) contain: $m
    Then entity $b get relations(marriage:husband) contain: $m
    When transaction commits
    When session opens transaction of type: read
    When $m = relation(marriage) get instance with key(license): m
    Then relation(marriage) get instances contain: $m
    When $a = entity(person) get instance with key(username): alice
    When $b = entity(person) get instance with key(username): bob
    Then entity $a get relations(marriage:wife) contain: $m
    Then entity $b get relations(marriage:husband) contain: $m

  Scenario: Role player can be unassigned from relation
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) create new instance with key(username): alice
    When $b = entity(person) create new instance with key(username): bob
    When relation $m add player for role(wife): $a
    When relation $m add player for role(husband): $b
    When relation $m remove player for role(wife): $a
    Then entity $a get relations(marriage:wife) do not contain: $m
    Then relation $m get players for role(wife) do not contain: $a
    Then relation $m get players do not contain:
      | wife | $a |
    When transaction commits
    When session opens transaction of type: write
    When $m = relation(marriage) get instance with key(license): m
    When $a = entity(person) get instance with key(username): alice
    Then entity $a get relations(marriage:wife) do not contain: $m
    Then relation $m get players for role(wife) do not contain: $a
    Then relation $m get players do not contain:
      | wife | $a |
    When relation $m add player for role(wife): $a
    When transaction commits
    When session opens transaction of type: write
    When $m = relation(marriage) get instance with key(license): m
    When $a = entity(person) get instance with key(username): alice
    When relation $m remove player for role(wife): $a
    Then entity $a get relations(marriage:wife) do not contain: $m
    Then relation $m get players for role(wife) do not contain: $a
    Then relation $m get players do not contain:
      | wife | $a |
    When transaction commits
    When session opens transaction of type: read
    When $m = relation(marriage) get instance with key(license): m
    When $a = entity(person) get instance with key(username): alice
    Then entity $a get relations(marriage:wife) do not contain: $m
    Then relation $m get players for role(wife) do not contain: $a
    Then relation $m get players do not contain:
      | wife | $a |

  Scenario: Relation without role players get deleted
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) create new instance with key(username): alice
    When relation $m add player for role(wife): $a
    When relation $m remove player for role(wife): $a
    Then relation $m is deleted: true
    Then entity $a get relations do not contain: $m
    Then relation(marriage) get instances do not contain: $m
    When $m = relation(marriage) get instance with key(license): m
    Then relation $m is null: true
    Then relation(marriage) get instances is empty
    When transaction commits
    When session opens transaction of type: write
    When $m = relation(marriage) get instance with key(license): m
    Then relation $m is null: true
    Then relation(marriage) get instances is empty
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) get instance with key(username): alice
    When relation $m add player for role(wife): $a
    When transaction commits
    When session opens transaction of type: write
    When $m = relation(marriage) get instance with key(license): m
    When $a = entity(person) get instance with key(username): alice
    When relation $m remove player for role(wife): $a
    Then relation $m is deleted: true
    Then entity $a get relations do not contain: $m
    When $m = relation(marriage) get instance with key(license): m
    Then relation $m is null: true
    Then relation(marriage) get instances is empty
    When transaction commits
    When session opens transaction of type: read
    When $m = relation(marriage) get instance with key(license): m
    Then relation $m is null: true
    Then relation(marriage) get instances is empty

  Scenario: Relation with role players can be deleted
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) create new instance with key(username): alice
    When $b = entity(person) create new instance with key(username): bob
    When relation $m add player for role(wife): $a
    When relation $m add player for role(husband): $b
    When delete relation: $m
    Then relation $m is deleted: true
    Then relation(marriage) get instances do not contain: $m
    Then entity $a get relations do not contain: $m
    Then entity $b get relations do not contain: $m
    Then relation(marriage) get instances is empty
    When transaction commits
    When session opens transaction of type: write
    When $a = entity(person) get instance with key(username): alice
    When $b = entity(person) get instance with key(username): bob
    When $m = relation(marriage) create new instance with key(license): m
    When relation $m add player for role(wife): $a
    When relation $m add player for role(husband): $b
    When transaction commits
    When session opens transaction of type: write
    When $a = entity(person) get instance with key(username): alice
    When $b = entity(person) get instance with key(username): bob
    When $m = relation(marriage) get instance with key(license): m
    When delete relation: $m
    Then relation $m is deleted: true
    Then relation(marriage) get instances do not contain: $m
    Then entity $a get relations do not contain: $m
    Then entity $b get relations do not contain: $m
    Then relation(marriage) get instances is empty
    When transaction commits
    When session opens transaction of type: read
    When $m = relation(marriage) get instance with key(license): m
    Then relation $m is null: true
    Then relation(marriage) get instances is empty

  Scenario: Relation cannot have roleplayers inserted after deletion
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) create new instance with key(username): alice
    When relation $m add player for role(wife): $a
    When delete relation: $m
    Then relation $m is deleted: true
    When relation $m add player for role(wife): $a; throws exception

  Scenario: Relation cannot have roleplayers inserted after indirect deletion
    When $m = relation(marriage) create new instance with key(license): m
    When $a = entity(person) create new instance with key(username): alice
    When relation $m add player for role(wife): $a
    When delete entity: $a
    Then relation $m is deleted: true
    When relation $m add player for role(wife): $a; throws exception
