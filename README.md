# Awesome PHP 7.4 environment

An awesome PHP 7.4 containerized environment, for development purposes.

Features:

- PHP 7.4
- Composer support
- XDebug support
- A PHP Debugger
- A PHP Tracer
- A PHP Profiler

## Sample use cases

### Create a dev environment for a Symfony 5 app

```dockerfile
FROM guillermomaschwitz/awesome-php:7.4-development  AS my_awesome_dev_environment

ENV APP_PUBLIC_DIR=/usr/local/app/my_awesome_new_project/public

RUN curl -sS  https://get.symfony.com/cli/installer | bash
RUN mv /usr/local/app/.symfony/bin/symfony /usr/local/bin/symfony
RUN symfony new --full my_awesome_new_project
```
