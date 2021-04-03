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
Feature: Concept Thing Type

  Background:
    Given connection has been opened
    Given connection does not have any database
    Given connection create database: grakn
    Given connection open schema session for database: grakn
    Given session opens transaction of type: write

  Scenario: Root thing type can retrieve all types
    When put entity type: person
    When put attribute type: is-alive, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: rating, with value type: double
    When put attribute type: name, with value type: string
    When put attribute type: birth-date, with value type: datetime
    When put relation type: marriage
    When relation(marriage) set relates role: husband
    When relation(marriage) set relates role: wife
    Then thing type root get supertypes contain:
      | thing |
    Then thing type root get supertypes do not contain:
      | person     |
      | is-alive   |
      | age        |
      | rating     |
      | name       |
      | birth-date |
      | marriage   |
      | husband    |
      | wife       |
    Then thing type root get subtypes contain:
      | thing      |
      | person     |
      | is-alive   |
      | age        |
      | rating     |
      | name       |
      | birth-date |
      | marriage   |
    Then thing type root get subtypes do not contain:
      | husband |
      | wife    |

  Scenario: Root thing type can retrieve all instances
    When put attribute type: is-alive, with value type: boolean
    When put attribute type: age, with value type: long
    When put attribute type: score, with value type: double
    When put attribute type: username, with value type: string
    When put attribute type: license, with value type: string
    When put attribute type: birth-date, with value type: datetime
    When put relation type: marriage
    When relation(marriage) set relates role: wife
    When relation(marriage) set owns key type: license
    When put entity type: person
    When entity(person) set owns key type: username
    When transaction commits
    When connection close all sessions
    When connection open data session for database: grakn
    When session opens transaction of type: write
    When $att1 = attribute(is-alive) as(boolean) put: true
    When $att2 = attribute(age) as(long) put: 21
    When $att3 = attribute(score) as(double) put: 123.456
    When $att4 = attribute(username) as(string) put: alice
    When $att5 = attribute(license) as(string) put: abc
    When $att6 = attribute(birth-date) as(datetime) put: 1990-01-01 11:22:33
    When $ent1 = entity(person) create new instance with key(username): alice
    When $rel1 = relation(marriage) create new instance with key(license): abc
    Then root(thing) get instances count: 8
    Then root(thing) get instances contain: $att1
    Then root(thing) get instances contain: $att2
    Then root(thing) get instances contain: $att3
    Then root(thing) get instances contain: $att4
    Then root(thing) get instances contain: $att5
    Then root(thing) get instances contain: $att6
    Then root(thing) get instances contain: $ent1
    Then root(thing) get instances contain: $rel1
