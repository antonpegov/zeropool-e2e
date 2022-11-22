# End to end automated testing using Robot Framework and Selenium via Lambdatest

# Deployment with docker-compose

1. Edit bin/publish.sh if needed
2. Run `./bin/publish.sh` to deploy your image to docker hub
3. Create docker-compose.yml file with the following content:

```yaml
# Example of docker-compose.yml
version: '3.9'

services:
  e2e:
    image: antonpegov/zeropool-e2e:latest
    environment:
      - LT_USERNAME=your_username
      - LT_ACCESS_KEY=your_lambdatest_access_key
```

4. Run `docker-compose up -d` to start the container

# Start local development

## Prerequisites

1. Create an account on [LambdaTest](https://www.lambdatest.com/)
2. Get the username and access key
3. In the root directory run the following commands

```bash
`pip3 install virtualenv`

`python -m virtualenv venv`

`source .\venv\scripts\activate`

`pip install -r requirements.txt`
```

## Run tests locally

```bash
`./make <test_name_from_Makefile>`
```

## Debugging

1. Install [Visual Studio Code](https://code.visualstudio.com/)
2. Install [Robot Framework Language Server](https://marketplace.visualstudio.com/items?itemName=TomiTurtiainen.rf-language-server)

\*\*\* Note: `Make` and `Makefile` used to run tests in parallel. Special subscription required for parallel testing.
