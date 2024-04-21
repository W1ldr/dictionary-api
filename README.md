# README

This is an open portuguese API, fell free to contribute

- ## System dependencies

  - Ruby 3.1.3
  - PostgresSQL 15
  - RoR 7.1.3.2

- ## Configuration

  to run locally just clone the project and inside the project folder on unix terminal

  - 1 - `bundle install`
  - 2 - `rails db:create; rails db:migrate`
  - 3 - `rails s`

    NOTE1: ensure the System dependencies are matched, the app will run on localhost:3000
    NOTE2: currently there is no data and it will be added in the future

- ## How to run the test suite

  - 1 - `rails t`

    NOTE1: currently there is no test...

- ## Deployment instructions

  coming soon

## Routes Available

### `/api/v1/words`

- **Method**: GET
- **Description**: Retrieve a list of all words.
- **Parameters**:
  - `page`: Page number (optional)
  - `per_page`: Number of items per page (optional)
- **Example Response**:

  ````json
  {
    "words": [
      "à luz de",
      "a olho nu",
      "a partir",
      "a partir de",
      "a posteriori",
      "a priori",
      "a propósito",
      "a reboque",
      "a respeito de",
      "à risca"
    ],
    "pagination": {
      "current_page": 2,
      "next_page": 3,
      "prev_page": 1,
      "total_pages": 11697
    }
  }```
  ````

### `/api/v1/words/:word`

- **Method**: GET
- **Description**: search for the word and and give you info about it.
- **Note**: replace the :word with the word you want like `/api/v1/words/teste`
- **Parameters**:
  - `page`: Page number (optional)
  - `per_page`: Number of items per page (optional)
- **Example Response**:

  ```json
  {
    "word": "barco",
    "syllabic_division": "bar-co",
    "meanings": [
      {
        "part_of_speech": "substantivo masculino",
        "definition": "Embarcação pequenas: barco a vela."
      },
      {
        "part_of_speech": "substantivo masculino",
        "definition": "Qualquer tipo de embarcação: andei de barco."
      },
      {
        "part_of_speech": "expressão",
        "definition": "Deixar correr o barco. Deixar as coisas como estão para ver o que acontecerá; não se preocupar com o desenrolar dos acontecimentos."
      },
      {
        "part_of_speech": "expressão",
        "definition": "Etimologia (origem da palavra barco). A palavra barco deriva como masculino de barca, do latim \"barca,ae\" com o mesmo sentido."
      }
    ]
  }
  ```

### `/api/v1/words/starting_with/:letter`

- **Method**: GET
- **Description**: list all the words starting with a letter
- **Note**: replace the :letter with the word you want like `/api/v1/words/starting_with/a`
- **Parameters**:
  - `page`: Page number (optional)
  - `per_page`: Number of items per page (optional)
- **Example Response**:

  ````json
  {
    "words": [
      "bababi",
      "babaca",
      "babaça",
      "babaço",
      "babaçu"
    ],
    "pagination": {
      "current_page": 4,
      "next_page": 5,
      "prev_page": 3,
      "total_pages": 1103
    }
  }```
  ````
