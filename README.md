# Fruga Backend Service (Fruga-be)
## This repository contains the backend service for the Fruga application. The backend is built using Ruby on Rails and provides a RESTful API to manage budget-related data.

## Requirements
Ruby 3.2.2
Rails 7.1.4
PostgreSQL
Node

## Getting Started
### Clone the Repository
```bash
git clone https://github.com/Fruga-Budget/Fruga-be.git
cd Fruga-be
```
### Install Dependencies
Ruby and Rails dependencies:

```bash
bundle install
```

### Database Setup
Create and setup the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```
### Environment Variables
Create a .env file in the root directory and add the following environment variables:

API_BASE_URL="your_url_to_py_service"

### Start the Server
To start the Rails server, run:

```bash
rails server
```

The server will be available at http://localhost:3000.

## Usage
### API Endpoints
The API provides endpoints for managing budget-related data. Here are some example endpoints:

Create Advice:

```http
POST /api/v1/users/:user_id/advices
```
```json
{
  "total_income": 5000,
  "needs": [
    {"name": "Rent", "cost": 1500, "description": "On a lease, this can't be changed!", "isNegotiable": false},
    {"name": "Utilities", "cost": 500, "description": "", "isNegotiable": true},
    {"name": "Misc.", "cost": 500, "description": "Food Budget, Gas", "isNegotiable": false}
  ],
  "wants": [
    {"name": "Dining Out", "cost": 500, "description": "Yummy!"},
    {"name": "Entertainment", "cost": 500, "description": "Going to the movies is important to me"},
    {"name": "Starbucks Coffee", "cost": 200, "description": "I don't know how to make coffee"},
    {"name": "Shoes", "cost": 500, "description": "Every time I drive by DSW I buy shoes"}
  ],
  "savings": [
    {"name": "401k", "cost": 200, "description": "Deposited from paycheck at work."},
    {"name": "Savings Account", "cost": 800, "description": "0.5% apr"}
  ]
}
```
typical response:
```json
{
    "advice": "Based on the user's current budget breakdown:\n\n- Needs total: $2500\n- Wants total: $1700\n- Savings total: $1000\n\nTotal expenses: $5200, exceeding income of $5000.\n\nRecommendations:\n1. Consider reducing spending on dining out, entertainment, and shoes.\n2. Modify utilities and miscellaneous expenses if possible.\n3. Increase savings allocation if able.\n\nRevised budget breakdown to meet 50/30/20 rule:\n- Needs: $1500\n- Wants: $1500\n- Savings: $1000\n\nAdjusted allocation:\n- Rent: $1500 (unchanged)\n- Utilities: $300 (reduced)\n- Misc.: $200 (reduced)\n- Dining Out: $250 (reduced)\n- Entertainment: $250 (reduced)\n- Starbucks Coffee: $100 (reduced)\n- Shoes: $150 (reduced)\n- 401k: $200 (unchanged)\n- Savings Account: $800 (unchanged)"
}
```

Create a User:
Note: there is a 10 character password requirement

```http
POST /api/v1/users
```
```json
{
  user_name: 'Bolt',
  password: 'treats4lyf',
  password_confirmation: 'treats4lyf'
}
```
Response
```json
{
  "data": {
    "id": "4",
    "type": "user",
    "attributes": {
      "user_name": "Bolt"
    }
  }
}
```

Login a User:

```http
POST /api/v1/sessions
```
```json
{
  "user_name": "Odell",
  "password": "treats4lyf"
}
```
Response
```json
{
  "data": {
    "id": "4",
    "type": "user",
    "attributes": {
      "user_name": "Bolt"
    }
  }
}
```

### Running Tests

To run the test suite, use:
```bash
bundle exec rspec spec
```

### Contributions and contributing
This backend app was made possible by Nico and Steddman. More info can be found in organization .github.

Please submit a PR using the PR template mentioned in the readme in .github repo.
