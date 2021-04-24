#
# Copyright (C) 2021 TypeDB Labs
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
Feature: Connection Session

  Background:
    Given connection has been opened
    Given connection does not have any database

  Scenario: for one database, open one session
    When connection create database: typedb
    When connection open session for database: typedb
    Then session is null: false
    Then session is open: true
    Then session has database: typedb

  Scenario: for one database, open many sessions
    When connection create database: typedb
    When connection open sessions for databases:
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
    Then sessions are null: false
    Then sessions are open: true
    Then sessions have databases:
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |

  Scenario: for one database, open many sessions in parallel
    When connection create database: typedb
    When connection open sessions in parallel for databases:
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
    Then sessions in parallel are null: false
    Then sessions in parallel are open: true
    Then sessions in parallel have databases:
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |
      | typedb |

  Scenario: for many databases, open many sessions
    When connection create databases:
      | alice   |
      | bob     |
      | charlie |
      | dylan   |
      | eve     |
      | frank   |

    When connection open sessions for databases:
      | alice   |
      | bob     |
      | charlie |
      | dylan   |
      | eve     |
      | frank   |

    Then sessions are null: false
    Then sessions are open: true
    Then sessions have databases:
      | alice   |
      | bob     |
      | charlie |
      | dylan   |
      | eve     |
      | frank   |


  Scenario: for many databases, open many sessions in parallel
    When connection create databases:
      | alice   |
      | bob     |
      | charlie |
      | dylan   |
      | eve     |
      | frank   |

    When connection open sessions in parallel for databases:
      | alice   |
      | bob     |
      | charlie |
      | dylan   |
      | eve     |
      | frank   |

    Then sessions in parallel are null: false
    Then sessions in parallel are open: true
    Then sessions in parallel have databases:
      | alice   |
      | bob     |
      | charlie |
      | dylan   |
      | eve     |
      | frank   |


  Scenario: write schema in a data session throws
    When connection create database: typedb
    Given connection open data session for database: typedb
    When session opens transaction of type: write
    Then graql define; throws exception containing "session type does not allow"
      """
      define person sub entity;
      """


  Scenario: write data in a schema session throws
    When connection create database: typedb
    Given connection open schema session for database: typedb
    When session opens transaction of type: write
    Then graql define
      """
      define person sub entity;
      """
    Then graql insert; throws exception containing "session type does not allow"
      """
      insert $x isa person;
      """
