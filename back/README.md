# back

# API

### `/users`

```
# get user list
curl -XGET 127.0.0.1:8080/users

# get user by int ID
curl -XGET 127.0.0.1:8080/users/1

# get user by email
curl 127.0.0.1:8080/users/user \
-XPOST \
-H "Content-type: application/json" \
-H "Accept: application/json" \
-d '"neo@matrix.com"'

# post new user
curl 127.0.0.1:8080/users \
-XPOST \
-H 'Content-type: application/json' \
-H 'Accept: application/json' \
-d '{"email":"neo@matrix.com","createdAt":"2019-12-06T00:56:29.537709Z","name":"Neo"}'

```

### `/diaries`

```
# get diary list
curl -XGET 127.0.0.1:8080/diaries

# get diary by int ID
curl -XGET 127.0.0.1:8080/diaries/1
```
