FROM guillermomaschwitz/awesome-php:7.4-development  AS my_awesome_dev_environment

ENV APP_PUBLIC_DIR=/usr/local/app/my_awesome_new_project/public

RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN curl -sS  https://get.symfony.com/cli/installer | bash
RUN .symfony/bin/symfony new --full my_awesome_new_project
