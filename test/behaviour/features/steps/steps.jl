
end


###### Given Steps ######################
#                                      #
########################################




@given("entity(person) set owns key type: username") do context
    @fail "Implement me"
end


@given("entity(person) set owns attribute type: email") do context
    @fail "Implement me"
end



###### When Steps ######################
#                                      #
########################################

@when("session opens transaction of type: write") do context
    @fail "Implement me"
end


@when("\$alice = attribute(username) as(string) put: alice") do context
    @fail "Implement me"
end


@when("entity \$a set has: \$alice") do context
    @fail "Implement me"
end


@when("\$alice = attribute(username) as(string) get: alice") do context
    @fail "Implement me"
end


@when("entity \$a unset has: \$alice") do context
    @fail "Implement me"
end


@when("\$bob = attribute(username) as(string) put: bob") do context
    @fail "Implement me"
end


@when("\$bob = attribute(username) as(string) get: bob") do context
    @fail "Implement me"
end


@when("\$b = entity(person) create new instance") do context
    @fail "Implement me"
end


@when("\$email = attribute(email) as(string) put: alice@email.com") do context
    @fail "Implement me"
end


@when("entity \$a set has: \$email") do context
    @fail "Implement me"
end


@when("\$email = attribute(email) as(string) get: alice@email.com") do context
    @fail "Implement me"
end


@when("entity \$a unset has: \$email") do context
    @fail "Implement me"
end


@when("entity \$a set has: \$email; throws exception") do context
    @fail "Implement me"
end

###### Then Steps ######################
#                                      #
########################################



@then("entity \$a get attributes(username) as(string) contain: \$alice") do context
    @fail "Implement me"
end


@then("entity \$a get keys contain: \$alice") do context
    @fail "Implement me"
end


@then("attribute \$alice get owners contain: \$a") do context
    @fail "Implement me"
end


@then("entity \$a get attributes(username) as(string) do not contain: \$alice") do context
    @fail "Implement me"
end


@then("entity \$a get keys do not contain: \$alice") do context
    @fail "Implement me"
end


@then("attribute \$alice get owners do not contain: \$a") do context
    @fail "Implement me"
end


@then("entity \$a set has: \$bob; throws exception") do context
    @fail "Implement me"
end


@then("entity \$b set has: \$alice; throws exception") do context
    @fail "Implement me"
end


@then("entity \$a get attributes(email) as(string) contain: \$email") do context
    @fail "Implement me"
end


@then("entity \$a get attributes contain: \$email") do context
    @fail "Implement me"
end


@then("attribute \$email get owners contain: \$a") do context
    @fail "Implement me"
end


@then("entity \$a get attributes(email) as(string) do not contain: \$email") do context
    @fail "Implement me"
end


@then("entity \$a get attributes do not contain: \$email") do context
    @fail "Implement me"
end


@then("attribute \$email get owners do not contain: \$a") do context
    @fail "Implement me"
end



