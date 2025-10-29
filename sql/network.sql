-- Copyright 2025 Snowflake Inc.
-- SPDX-License-Identifier: Apache-2.0
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

USE ROLE FESTIVAL_DEMO_ROLE;
USE DATABASE OPENFLOW_FESTIVAL_DEMO;
CREATE SCHEMA IF NOT EXISTS networks;
use schema networks;
show network rules;

CREATE OR REPLACE NETWORK RULE google_network_rule
  MODE = EGRESS
  TYPE= HOST_PORT
  VALUE_LIST = (
                 'admin.googleapis.com',
                 'oauth2.googleapis.com',
                 'www.googleapis.com',
                 'google.com'
                );

DESC NETWORK RULE google_network_rule;
USE ROLE ACCOUNTADMIN;


CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION festival_ops_access_integration
  ALLOWED_NETWORK_RULES = (OPENFLOW_FESTIVAL_DEMO.networks.google_network_rule)
  ENABLED = true
  COMMENT =  'Used for accessing google workspace';
  

DESC EXTERNAL ACCESS INTEGRATION festival_ops_access_integration;

-- access and grants

GRANT USAGE ON DATABASE OPENFLOW_FESTIVAL_DEMO TO OPENFLOWADMIN;
GRANT USAGE ON SCHEMA OPENFLOW_FESTIVAL_DEMO.NETWORKS TO OPENFLOWADMIN;
GRANT USAGE ON INTEGRATION festival_ops_access_integration TO OPENFLOWADMIN;

-- check grants
SHOW GRANTS TO ROLE OPENFLOWADMIN;
  
