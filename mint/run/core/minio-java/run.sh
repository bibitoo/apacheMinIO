#!/bin/bash
#
#  Mint (C) 2017 Minio, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

# handle command line arguments
if [ $# -ne 2 ]; then
    echo "usage: run.sh <OUTPUT-LOG-FILE> <ERROR-LOG-FILE>"
    exit 1
fi

output_log_file="$1"
error_log_file="$2"

# run tests
endpoint="http://$SERVER_ENDPOINT"
if [ "$ENABLE_HTTPS" -eq 1 ]; then
    endpoint="https://$SERVER_ENDPOINT"
fi

java -Xmx4096m -Xms256m -cp "/mint/run/core/minio-java/*:." FunctionalTest \
    "$endpoint" "$ACCESS_KEY" "$SECRET_KEY" "$SERVER_REGION" "$RUN_ON_FAIL" 1>>"$output_log_file" 2>"$error_log_file"
