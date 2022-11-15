# README

## Requirments
-Docker

## Installation
```
docker compose up -d
docker-compose exec rails rails db:create
docker-compose exec rails rails db:migrate
sudo chmod 777 docker_data/ -R

```

## EndPoints
-End Point for creating application => POST: localhost:3000/api/v1/applications
-End Point for listing all applications => GET: localhost:3000/api/v1/applications
-End Point for updating applications => PATCH: localhost:3000/api/v1/update
-End Point for find application by token => GET: localhost:3000/api/v1/applications/{application_token}/

-End Point for creating messages => POST: localhost:3000/api/v1/applications/{application_token}/chats/{chat_number}/messages/
                                    ()
-End Point for Listing all messages => GET: localhost:3000/api/v1/message
-End Point for updating message => PATCH: localhost:3000/api/v1/applications/{application_token}/chats/{chat_number}/messages/{message_number}
-End Point for list chat messages => GET: localhost:3000/api/v1/applications/{application_token}/chats/{chat_number}/messages


-End Point for creating chat => POST: localhost:3000/api/v1/applications/{application_token}/chats/
-End Point for list application chats => GET: localhost:3000/api/v1/applications/{application_token}/chats/
-End Point for updating chats => PATCH: localhost:3000/api/v1/applications/{application_token}/chats/{chat_number}
