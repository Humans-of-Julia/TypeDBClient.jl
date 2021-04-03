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
Feature: Rule Interaction Resolution

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
      plays team:leader,
      plays team:member,
      plays employment:employee,
      owns name;

      employment sub relation,
      relates employee;

      team sub relation,
      relates leader,
      relates member;

      name sub attribute, value string;
      """
    Given for each session, transaction commits
    Given for each session, open transactions of type: write


  ###########################
  # RULE INTERACTIONS BELOW #
  ###########################


  #  NOTE: There is a currently known bug in core 1.8.3 that makes this test fail (issue #5891)
  #  We will hope this is fixed by 2.0 as a result of mor robust alpha equivalence definition
  Scenario: when rules are similar but different the reasoner knows to distinguish the rules
    Given for each session, graql define
      """
      define

      person
      plays lesson:teacher,
      plays lesson:student,
      owns tag;

      lesson sub relation,
      relates teacher,
      relates student;

      tag sub attribute, value string;

      rule tag-teacher-leaders:
      when {
        $x isa person;
        $y isa person;
        (student: $x, teacher: $y) isa lesson;
        (member: $x, member: $y, leader: $y) isa team;
      } then {
        $y has tag "P";
      };

      rule tag-teacher-members:
      when {
        $x isa person;
        $y isa person;
        (student: $x, teacher: $y) isa lesson;
        (member: $x, member: $y, leader: $x) isa team;
      } then {
        $y has tag "P";
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

      $bob isa person, has name "bob";
      $alice isa person, has name "alice";
      $charlie isa person, has name "charlie";
      $dennis isa person, has name "dennis";

      (student: $bob, teacher: $alice) isa lesson;
      (member: $alice, member: $bob, leader: $alice) isa team;

      (student: $charlie, teacher: $dennis) isa lesson;
      (member: $charlie, member: $dennis, leader: $charlie) isa team;
      """
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $x isa person, has name $n, has tag "P";
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then materialised and reasoned databases are the same size


  Scenario: when two distinct rules have alpha-equivalent bodies and heads, the reasoner still sees them as distinct.
    More explicitly, suppose we have rule A and rule B. Suppose up to alpha equivalence A.when == B.when and
    A.then == B.then. But the {rule A} != {rule B} because the bindings of the variables makes the meaning of A.then
    distinct from B.then. In such a situation, the reasoner does not mistake the rules as equivalent.
    Given for each session, graql define
      """
      define

      person
      plays marriage:husband,
      plays marriage:wife;

      marriage sub relation,
      relates husband,
      relates wife;

      rule husbands-called-tracey:
      when {
          $x isa person;
          $y isa person;
          (husband: $x, wife: $y) isa marriage;
      } then {
          $x has name 'tracey';
      };

      rule wives-called-tracey:
      when {
          $x isa person;
          $y isa person;
          (husband: $x, wife: $y) isa marriage;
      } then {
          $y has name 'tracey';
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

      $a isa person;
      $b isa person;
      (husband: $a, wife: $b) isa marriage;
      """
    Then materialised database is completed
    Given for each session, transaction commits
    Given for each session, open transactions of type: read
    Then for graql query
      """
      match $x isa person, has name 'tracey';
      """
    Then all answers are correct in reasoned database
    Then answer size in reasoned database is: 2
    Then materialised and reasoned databases are the same size

