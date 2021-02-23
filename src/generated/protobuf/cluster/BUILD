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

package(default_visibility = ["//visibility:public"])

load("@graknlabs_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

proto_library(
    name = "grakn-cluster-proto",
    srcs = [":grakn_cluster.proto"],
    deps = [":cluster-proto", ":database-proto"],
)

proto_library(
    name = "cluster-proto",
    srcs = [":cluster.proto"],
)

proto_library(
    name = "database-proto",
    srcs = [":database.proto"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl",
    size = "small",
)
