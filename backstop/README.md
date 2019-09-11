# CircleCI orb for running BackstopJS

This is a CircleCI orb for running visual regression tests with
[BackstopJS](https://github.com/garris/BackstopJS) and reporting the
status and report link as a GitHub status.

## Documentation

See https://circleci.com/orbs/registry/orb/reload/backstop.

## Example setup
This example sets up a simple Backstop job for running visual tests.

It will run `backstop reference`, `backstop test`, and then publish
the status and a link to the test report as a GitHub status.

You can add `before_rerefrence` and `before_test` steps if you need to
prepare the environments.

```yaml
version: 2.1

orbs:
  backstop: reload/backstop@2

workflows:
  version: 2

  test:
    jobs:
      - backstop/visual-test:
          name: Visual regression tests
          filters:
            branches:
              ignore:
                - master
```
