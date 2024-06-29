# Simple OAuth 2.0 example

This repository contains clients and a resource/authorization server. The clients are simple web application that use the OAuth 2.0 authorization code grant to obtain an access token from the authorization server. The clients then use the access token to make a request to the resource server. More specifically, the clients request the UserEndpoint from the resource server.

This example in not meant to be particularly secure or robust. It is meant to be a simple example of how OAuth 2.0 works with the authlib library.