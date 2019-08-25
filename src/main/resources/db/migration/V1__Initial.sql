CREATE TABLE roles
(
  name        varchar(100) PRIMARY KEY,
  description varchar(2000)
);

CREATE TABLE users
(
  id              UUID PRIMARY KEY,
  name            varchar(100)          NOT NULL,
  preferred_email varchar(200)          NOT NULL,
  phone_number    varchar(100),
  enabled         boolean DEFAULT false NOT NULL,
  validated       boolean DEFAULT false NOT NULL
);

CREATE TABLE users_roles
(
  user_id   UUID REFERENCES users,
  role_name varchar(100) REFERENCES roles,
  PRIMARY KEY (user_id, role_name)
);

CREATE TABLE firebase_users
(
  uid     varchar(200) PRIMARY KEY,
  user_id UUID REFERENCES users NOT NULL,
  email   varchar(200)
);

CREATE TABLE oauth_client_details
(
    client_id               VARCHAR(256) PRIMARY KEY,
    resource_ids            VARCHAR(256),
    client_secret           VARCHAR(256),
    scope                   VARCHAR(256),
    authorized_grant_types  VARCHAR(256),
    web_server_redirect_uri VARCHAR(256),
    authorities             VARCHAR(256),
    access_token_validity   INTEGER,
    refresh_token_validity  INTEGER,
    additional_information  VARCHAR(4096),
    autoapprove             VARCHAR(256)
);

CREATE TABLE programs
(
    id          UUID PRIMARY KEY,
    name        varchar(200) UNIQUE  NOT NULL,
    description varchar(500)  NOT NULL,
    responsible varchar(2000) NOT NULL
);

CREATE TABLE batches
(
    id         UUID PRIMARY KEY,
    program_id UUID REFERENCES programs,
    name       varchar(200) NOT NULL,
    start_date DATE         NOT NULL,
    end_date   DATE         NOT NULL,
    notes      varchar(2000),

    CONSTRAINT batch_name_by_program UNIQUE (program_id, name)
);

CREATE TABLE sessions
(
    id         UUID PRIMARY KEY,
    batch_id   UUID REFERENCES batches,
    title      varchar(200) NOT NULL,
    notes      TEXT         NOT NULL,
    location   varchar(500),
    date       DATE         NOT NULL,
    start_time TIME,
    end_time   TIME,

    CONSTRAINT session_title UNIQUE (batch_id, title)
);

CREATE TABLE confirm_attendance
(
    session_id  UUID REFERENCES sessions,
    user_id     UUID REFERENCES users,
    PRIMARY KEY (session_id, user_id)
);

INSERT INTO roles (name, description)
VALUES ('ROLE_TECKER',
        'Main consumers of the programs provided by the organization, for many of the programs they are supposed to be kids'),
       ('ROLE_PARENT', 'Parents/tutors of the teckers'),
       ('ROLE_MENTOR', 'People in charge of some team of teckers'),
       ('ROLE_STAFF', 'People helping to achieve success in any of the programs'),
       ('ROLE_ADMINISTRATOR',
        'People guiding the programs. An administrator belongs to staff as well');

INSERT INTO oauth_client_details
(client_id, client_secret, scope, authorized_grant_types,
 web_server_redirect_uri, authorities, access_token_validity,
 refresh_token_validity, additional_information, autoapprove)
VALUES
('iOSApp', '$2a$10$7rdl7jOe.LW1Db05XkPhneoAFXryHC0qGhmDdsmSbLYjMpZPTrBZ2', 'read,write','firebase', null, null, 5184000, 0, null, true);

INSERT INTO oauth_client_details
(client_id, client_secret, scope, authorized_grant_types,
 web_server_redirect_uri, authorities, access_token_validity,
 refresh_token_validity, additional_information, autoapprove)
VALUES
('AndroidApp', '$2a$10$SK3CdCpS2ui543vb4dMS4ev1F5NanWS.wxzlSFRa/huWBZkKIWwe6', 'read,write','firebase', null, null, 5184000, 0, null, true);

INSERT INTO oauth_client_details
(client_id, client_secret, scope, authorized_grant_types,
 web_server_redirect_uri, authorities, access_token_validity,
 refresh_token_validity, additional_information, autoapprove)
VALUES
('ManagementApp', '$2a$10$QyEdcDTyzndP6/3p7IrtWOF.Bg.AgzejotqLgYOjwzU0Ua5szaRDC', 'read,write','firebase', null, null, 5184000, 0, null, true);
