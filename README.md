# Simple OAuth 2.0 example

This repository contains clients and a resource/authorization server. The clients are simple web application that use the OAuth 2.0 authorization code grant to obtain an access token from the authorization server. The clients then use the access token to make a request to the resource server. More specifically, the clients request the UserEndpoint from the resource server.

This example in not meant to be particularly secure or robust. It is meant to be a simple example of how OAuth 2.0 works with the authlib library.

## Custom OAuth 2.0 Server

This server is heavily based on authlibs [example-oauth2-server](https://github.com/authlib/example-oauth2-server) thats under the BSD License for open source projects.

While in development, you can set the `AUTHLIB_INSECURE_TRANSPORT` environment variable to disable HTTPS. This is useful for testing and development.
```bash
$ export AUTHLIB_INSECURE_TRANSPORT=1
```

## Custom OAuth 2.0 Client

## Github OAuth2 Client

To register a new OAuth2 client on Github, you need to create a new OAuth App on Github [here](https://github.com/settings/developers).