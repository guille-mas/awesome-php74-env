# Awesome PHP 7.4 environment

An awesome PHP 7.4 containerized environment, for development purposes.

Features:

- PHP 7.4
- Apache with HTTP/HTTPS support out of the box
- Composer support
- XDebug support
- A PHP Debugger
- A PHP Tracer
- A PHP Profiler
- Customizable

## Sample use cases

### Create a dev environment for a Symfony 5 app

```dockerfile
FROM guillermomaschwitz/awesome-php:7.4-development  AS my_awesome_dev_environment

ENV APP_PUBLIC_DIR=/usr/local/app/my_awesome_new_project/public

RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN curl -sS  https://get.symfony.com/cli/installer | bash
RUN .symfony/bin/symfony new --full my_awesome_new_project
```

**Build it**

```bash
docker build -t symfony-app-image --target my_awesome_dev_environment .
```

**Run it**

```bash
docker run -it --rm -p 8080:8080/tcp -p 8081:8081/tcp symfony-app-image
```

And you are ready to visit http://localhost:8080 or https://localhost:8081

**Or run it as a development environment** by mounting your pre-existing Symfony source code with the **-v** parameter


**Heads up** You might need to tell your browser to trust the self-signed SSL cert when trying your app at https://localhost:8081
