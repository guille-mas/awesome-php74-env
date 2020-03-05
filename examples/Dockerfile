FROM guillermomaschwitz/awesome-php:7.4-development  AS my_awesome_dev_environment

ENV APP_PUBLIC_DIR=/usr/local/app/my_awesome_new_project/public

RUN curl -sS  https://get.symfony.com/cli/installer | bash
RUN mv /usr/local/app/.symfony/bin/symfony /usr/local/bin/symfony
RUN symfony new --full my_awesome_new_project
