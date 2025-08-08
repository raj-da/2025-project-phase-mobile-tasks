GET my_chats (gets all the chats of current user)
	End point: https://g5-flutter-learning-path-be.onrender.com/api/v3/chats

	Example Request: curl --location 'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats' (with bearer token)

	Example Response:
	{
  "statusCode": 200,
  "message": "",
  "data": [
    {
      "_id": "66c837f2b7068ee15142f66a",
      "user1": {
        "_id": "66c44fd86198f150e643c827",
        "name": "0000andthenwhen",
        "email": "mooooa@gmail.com",
        "__v": 0
      },
      "user2": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "__v": 0
    },
    {
      "_id": "66c83a67b7068ee15142f6c8",
      "user1": {
        "_id": "66c8386ab7068ee15142f684",
        "name": "Mr.Robot",
        "email": "robot@gmail.com",
        "__v": 0
      },
      "user2": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "__v": 0
    },
  ]
}

	outer _id: is chat id
	one of the user1 is the current user and the other is the other user

GET my_chat_by_id : gets a chat by it's id
	End point: https://g5-flutter-learning-path-be.onrender.com/api/v3/chats/66c837f2b7068ee15142f66a  (with bearer token)

	Example Request: curl --location 'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats/66c837f2b7068ee15142f66a'

	Example Response:
	{
  "statusCode": 200,
  "message": "",
  "data": {
    "_id": "66c837f2b7068ee15142f66a",
    "user1": {
      "_id": "66c44fd86198f150e643c827",
      "name": "0000andthenwhen",
      "email": "mooooa@gmail.com",
      "__v": 0
    },
    "user2": {
      "_id": "66bde36e9bbe07fc39034cdd",
      "name": "Mr. User",
      "email": "user@gmail.com",
      "__v": 0
    },
    "__v": 0
  }
}

GET get_chat_messages: gets every message of a user in a chat
	End point: https://g5-flutter-learning-path-be.onrender.com/api/v3/chats/66c84151b7068ee15142f817/messages (with token)

	Example Request: curl --location 'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats/66c84151b7068ee15142f817/messages'

	Example Response:
{
  "statusCode": 200,
  "message": "",
  "data": [
    {
      "_id": "66c872f6346255dac2604bab",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "content": "Hello",
      "__v": 0,
      "type": "text"
    },
    {
      "_id": "66c888fa50d6a19c665b7239",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "hhh",
      "__v": 0
    },
    {
      "_id": "66c88a1050d6a19c665b72a3",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "hhkkkkh",
      "__v": 0
    },
    {
      "_id": "66c88a3a50d6a19c665b72ad",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "hhkkkkh",
      "__v": 0
    },
    {
      "_id": "66c88a5750d6a19c665b72b9",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c88a5f50d6a19c665b72c6",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "hhkkkkh",
      "__v": 0
    },
    {
      "_id": "66c89a0eb07aa10a8a1ef59e",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c89a59b07aa10a8a1ef5b3",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c89e72b07aa10a8a1ef677",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c89e7ab07aa10a8a1ef683",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "jello",
      "__v": 0
    },
    {
      "_id": "66c89f06b07aa10a8a1ef6cc",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "jello",
      "__v": 0
    },
    {
      "_id": "66c89f0fb07aa10a8a1ef6d7",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "123455",
      "__v": 0
    },
    {
      "_id": "66c89f73b07aa10a8a1ef709",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "123455",
      "__v": 0
    },
    {
      "_id": "66c89f7ab07aa10a8a1ef713",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "123455!",
      "__v": 0
    },
    {
      "_id": "66c89fb4b07aa10a8a1ef739",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Yohoooo!",
      "__v": 0
    },
    {
      "_id": "66c8a12bb07aa10a8a1ef7c0",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Yohoooo!",
      "__v": 0
    },
    {
      "_id": "66c8a13cb07aa10a8a1ef7c9",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "jaguar!",
      "__v": 0
    },
    {
      "_id": "66c8a162b07aa10a8a1ef7e8",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "jaguar!",
      "__v": 0
    },
    {
      "_id": "66c8a1b9b07aa10a8a1ef826",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "jaguar!",
      "__v": 0
    },
    {
      "_id": "66c8a1ceb07aa10a8a1ef83b",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "new one!",
      "__v": 0
    },
    {
      "_id": "66c8a1e6b07aa10a8a1ef84d",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "new one!",
      "__v": 0
    },
    {
      "_id": "66c8a5f8b07aa10a8a1ef90c",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c8a671b07aa10a8a1ef937",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c8a673b07aa10a8a1ef941",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c8a67ab07aa10a8a1ef957",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "bt",
      "__v": 0
    },
    {
      "_id": "66c8a68fb07aa10a8a1ef96c",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    },
    {
      "_id": "66c8a694b07aa10a8a1ef97e",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hellojj",
      "__v": 0
    },
    {
      "_id": "66c8a69cb07aa10a8a1ef98c",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hellojjp",
      "__v": 0
    },
    {
      "_id": "66c8a6a4b07aa10a8a1ef994",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hellojjpj",
      "__v": 0
    },
    {
      "_id": "66c8a814b07aa10a8a1ef9e6",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hellojjpj",
      "__v": 0
    },
    {
      "_id": "66c8a81bb07aa10a8a1ef9ef",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "pwe",
      "__v": 0
    },
    {
      "_id": "66c8a820b07aa10a8a1ef9fc",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "pwe",
      "__v": 0
    },
    {
      "_id": "66c8a826b07aa10a8a1efa10",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "pwe!",
      "__v": 0
    },
    {
      "_id": "66c8a83bb07aa10a8a1efa27",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "sky is blue!",
      "__v": 0
    },
    {
      "_id": "66c8a84ab07aa10a8a1efa30",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "nice duplication is off!",
      "__v": 0
    },
    {
      "_id": "66c8a90f9a6479759255dd0e",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "nice duplication is off!",
      "__v": 0
    },
    {
      "_id": "66c8a91d9a6479759255dd25",
      "sender": {
        "_id": "66c840e4b7068ee15142f7ef",
        "name": "string",
        "email": "cat@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "The above is intentional! nice duplication is off!",
      "__v": 0
    },
    {
      "_id": "66c986f489ce20757228a55a",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "hi",
      "__v": 0
    },
    {
      "_id": "66c9889989ce20757228a574",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "hey",
      "__v": 0
    },
    {
      "_id": "66c98d5489ce20757228a584",
      "sender": {
        "_id": "66bde36e9bbe07fc39034cdd",
        "name": "Mr. User",
        "email": "user@gmail.com",
        "__v": 0
      },
      "chat": {
        "_id": "66c84151b7068ee15142f817",
        "user1": {
          "_id": "66c840e4b7068ee15142f7ef",
          "name": "string",
          "email": "cat@gmail.com",
          "__v": 0
        },
        "user2": {
          "_id": "66bde36e9bbe07fc39034cdd",
          "name": "Mr. User",
          "email": "user@gmail.com",
          "__v": 0
        },
        "__v": 0
      },
      "type": "text",
      "content": "Hello",
      "__v": 0
    }
  ]
}

POST initiate_chat: initiates a chat id when creating a chat
	End point: https://g5-flutter-learning-path-be.onrender.com/api/v3/chats (with token)
	
	Example Request: 
curl --location 'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats' \
--data '{
    "userId": "66c730840740f8c2bae904e0"
}'

	Example response:

{
  "statusCode": 201,
  "message": "",
  "data": {
    "user1": {
      "_id": "66c72bd1fc1a63830d084348",
      "name": "string",
      "email": "m@gmail.com",
      "__v": 0
    },
    "user2": {
      "_id": "66c730840740f8c2bae904e0",
      "name": "string",
      "email": "a@a.com",
      "__v": 0
    },
    "_id": "66c767d7944d8f950440bd9e",
    "__v": 0
  }
}

DELETE chat: deletes a chat
	End point: https://g5-flutter-learning-path-be.onrender.com/api/v3/chats/66c7452fbe1a05e9551c3ead (with token)
	
	Example Request: curl --location --request DELETE 'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats/66c7452fbe1a05e9551c3ead'

	Example Response: no response body

GET users: gets all the users in the server
    End point: https://g5-flutter-learning-path-be.onrender.com/api/v3/users (with token)