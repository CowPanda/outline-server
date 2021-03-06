#!/bin/bash -eu
#
# Copyright 2018 The Outline Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "** Currently broken, use yarn do shadowbox/docker/run instead **" >&2
exit 1

do_action shadowbox/server/build

export LOG_LEVEL="${LOG_LEVEL:-debug}"
export SB_PUBLIC_IP="${SB_PUBLIC_IP:-$(curl https://ipinfo.io/ip)}"
# WARNING: The SB_API_PREFIX should be kept secret!
export SB_API_PREFIX=TestApiPrefix
export SB_METRICS_URL=https://metrics-test.uproxy.org
export SB_STATE_DIR=/tmp/outline

source $ROOT_DIR/src/shadowbox/scripts/make_test_certificate.sh $SB_STATE_DIR

# This will fail because it expects prometheus and outline-ss-server to be in /root/shadowbox/bin.
# TODO: Fix it
node $BUILD_DIR/shadowbox/app/server/main
