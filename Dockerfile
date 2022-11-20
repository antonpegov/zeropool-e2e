FROM python:3.6

LABEL maintainer Anton Pegov <github.com/antonpegov>
LABEL description Robot Framework with LambdaTest running on Docker

# Set environment variables
ENV ROBOT_RESOURCES_DIR /robot/resources
ENV ROBOT_TESTS_DIR /robot/tests
ENV ROBOT_WORK_DIR /robot/temp
ENV ROBOT_LOGS_DIR /robot/logs

# Create directories
RUN mkdir -p ${ROBOT_RESOURCES_DIR}
RUN mkdir -p ${ROBOT_TESTS_DIR}
RUN mkdir -p ${ROBOT_WORK_DIR}
RUN mkdir -p ${ROBOT_LOGS_DIR}

# Copy the tests to the tests directory
COPY ./tests ${ROBOT_TESTS_DIR}
COPY ./resources ${ROBOT_RESOURCES_DIR}
COPY requirements.txt ${ROBOT_WORK_DIR}/requirements.txt
COPY Makefile ${ROBOT_WORK_DIR}/Makefile
COPY make.exe ${ROBOT_WORK_DIR}/make.exe
COPY ./bin/runme.sh ${ROBOT_WORK_DIR}/runme.sh
RUN chmod +x ${ROBOT_WORK_DIR}/runme.sh

# A dedicated work folder to allow for the creation of temporary files
WORKDIR ${ROBOT_WORK_DIR}

# Install Robot Framework and dependencies
RUN python3 -m pip install virtualenv
RUN virtualenv venv
RUN . venv/bin/activate
RUN python3 -m pip install -r requirements.txt

# Execute tests
ENTRYPOINT ["./runme.sh"]

