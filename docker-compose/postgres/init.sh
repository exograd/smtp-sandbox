#!/bin/sh

set -eu

psql -v ON_ERROR_STOP=1 -U $POSTGRES_USER <<-EOF
CREATE DATABASE roundcube;

CREATE USER mail WITH ENCRYPTED PASSWORD 'password';
CREATE DATABASE mail OWNER mail;
EOF

psql -v ON_ERROR_STOP=1 -U mail mail <<-EOF
-- this is the table for the users accounts
CREATE TABLE public.accounts (
    id serial,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    password character varying(255) DEFAULT ''::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL
);

-- this is the table for the virtual mappings for email -> email
CREATE TABLE public.virtuals (
    id serial,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    destination character varying(255) DEFAULT ''::character varying NOT NULL
);

-- this view is used to determine where to deliver things
CREATE VIEW public.delivery AS
 SELECT virtuals.email,
    virtuals.destination
   FROM public.virtuals
  WHERE (length((virtuals.email)::text) > 0)
UNION
 SELECT accounts.email,
    'vmail'::character varying AS destination
   FROM public.accounts
  WHERE (length((accounts.email)::text) > 0);

-- this view is used to determine which domains this server is serving
CREATE VIEW public.domains AS
 SELECT split_part((virtuals.email)::text, '@'::text, 2) AS domain
   FROM public.virtuals
  WHERE (length((virtuals.email)::text) > 0)
  GROUP BY (split_part((virtuals.email)::text, '@'::text, 2))
UNION
 SELECT split_part((accounts.email)::text, '@'::text, 2) AS domain
   FROM public.accounts
  WHERE (length((accounts.email)::text) > 0)
  GROUP BY (split_part((accounts.email)::text, '@'::text, 2));

-- this view should control the email addresses users can send with
CREATE VIEW public.sending AS
 SELECT virtuals.email,
    virtuals.destination AS login
   FROM public.virtuals
  WHERE (length((virtuals.email)::text) > 0)
UNION
 SELECT accounts.email,
    accounts.email AS login
   FROM public.accounts
  WHERE (length((accounts.email)::text) > 0);
EOF
