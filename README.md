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

# Dais orb

The repository also holds an orb command for running
[Dais](https://github.com/xendk/dais).

## Documentation

See https://circleci.com/orbs/registry/orb/reload/dais.

## Example setup
This is the same example as before, but it has been extended with
`before_test` steps to let Dais wait for environments to be ready (a
`before_reference` configuration also exists).

Notice that we need to specify another executor in this case as the
default executor in the backstop orb has no PHP.

```yaml
version: 2.1

orbs:
  backstop: reload/backstop@2
  dais: reload/dais@1

executors:
  backstop-dais:
    docker:
      - image: circleci/php:7.2-cli-node-browsers

jobs:
  checks:
    docker:
      - image: circleci/php:7.2-cli
    steps:
      - checkout
      - run:
          name: Validate composer.json and composer.lock
          command: composer validate --no-check-all --no-check-publish

workflows:
  version: 2

  test:
    jobs:
      - checks
      - backstop/visual-test:
          name: Visual regression tests
          context: BackstopJS Report Github Status
          executor: backstop-dais
          before_test:
            - dais/wait:
                files: backstop.json
          filters:
            branches:
              ignore:
                - master
```
