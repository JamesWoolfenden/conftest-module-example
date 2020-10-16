# Conftest with Terraform

This repo contains early examples (im learning the REGO).

This example demonstrates access to a module.

Why?
Most of the validation required will eventual target modules,
 rather than the resources themselves,
that's in any real implementation.

One of great features of OPA/Conftest is that it works on the planned
 and evaluated values.

To Use this example you will need Conftest installed in your path:

```conftest
make conftest
...
terraform show -json tfplan.binary > tfplan.json
conftest test ./tfplan.json -p ./policies
←[31mFAIL←[0m - ./tfplan.json - JamesWoolfenden/ip/http

←[31m3 tests, 2 passed, 0 warnings, 1 failure, 0 exceptions←[0m
make: *** [Makefile:47: conftest] Error 1

```

This example raises a failure when you can retrieve the source of the
module being used but it could be any value or test.

See the REGO test file in the policies folder for the REGO rule.

This ability alone is enough to start adopting conftest use for our tf work.
